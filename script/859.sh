#!/bin/bash
# Date : (2011-07-07 21-00)
# Last revision : (2011-07-07 21-00)
# Wine version used : 1.2.3
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Legacy of Kain : Soul Reaver"
PREFIX="SoulReaver"
WORKING_WINE_VERSION="1.2.3"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="La taille de votre mémoire graphique?"
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de\n512Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory do your graphic card have got?"
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than\n512Mb of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/soulreaver/top.jpg" "http://files.playonlinux.com/resources/setups/soulreaver/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
 
POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics" "http://www.crystald.com/" "GNU_Raziel" "$PREFIX" 
 
select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"
 
#downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

#Creating prefix 
POL_SetupWindow_prefixcreate

# Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_DVD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_DVD" ]; then
	GAME_MEDIAVERSION="DVD"
else
	GAME_MEDIAVERSION="DD"
fi

# Installing mandatory dependencies (To fix some sound issues and for Joystick support)
POL_Call POL_Install_dxfullsetup

if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "kain2.exe"
	cd "$WINEPREFIX"/dosdevices
	ln -s "$CDROM" d:
	Set_OS "win98"
	wine start /unix "$CDROM/Setup.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
	wine start /unix "$SETUP_EXE"
	INSTALL_ON="1"
	until [ "$INSTALL_ON" == "" ]; do
	sleep 5
	INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
	done
	POL_SetupWindow_detect_exit
fi
 
# Asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1792-2048-3072-4096" "-" "64"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > vms.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
EOF
regedit vms.reg
if [ "$VMS" -lt "64" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

## Fix for this game
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
	# Mandatory official patch 1.2 + XP fixed exe + fixed winplay DLL
	cd "$POL_USER_ROOT/ressources"
	if [ ! -e "Soul_Reaver_Patch_v1.2_XP_Fixed.zip" ]; then
		POL_SetupWindow_download "$LNG_GAME_PATCH" "$TITLE" "http://files.playonlinux.com/Soul_Reaver_Patch_v1.2_XP_Fixed.zip"
	fi
	GAME_PATH=`find $WINEPREFIX -name "kain2.exe" | sed s/kain2.exe//g`
	cd "$GAME_PATH"
	unzip -o "$POL_USER_ROOT/ressources/Soul_Reaver_Patch_v1.2_XP_Fixed.zip"
fi

# Sound problem fix - pulseaudio related
POL_Call POL_Function_OverrideDLL "" "mmdevapi"
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section ##
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "kain2.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4XWLoACgkQ5TH6yaoTykf52wCdFxXjAl/JJCCs2tbC0PbnydPD
sNwAn2Q5SbY59x5gJDxHoWJ6lAdiD093
=slHr
-----END PGP SIGNATURE-----
