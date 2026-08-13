#!/bin/bash
# Date : (2010-21-09 20-00)
# Last revision : (2011-18-07 20-00)
# Wine version used : 1.2, 1.2.3
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Prince of Persia : Sands of Time"
PREFIX="PoP-SandsOfTime"
WORKING_WINE_VERSION="1.2.3"

if [ "$POL_LANG" == "fr" ]; then
TITLE="Prince of Persia : Les Sables du Temps"
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_CD="Version CD"
LNG_DVD="Version DVD"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA_1="Veuillez insérer le disque 1 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_CHANGE_DISK="Lorsque le setup du jeu demandera le prochain disque\nappuyez sur \"Suivant\"."
LNG_INSERT_MEDIA_2="Veuillez insérer le disque 2 dans votre lecteur\nsi ce n'est pas déja fait."
LNG_INSERT_MEDIA="Veuillez insérer le disque dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_GAME_WARNING="Vous devez contourner les protections anti-piratage de ce jeu\npour qu'il fonctionne avec wine."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_CD="CD Version"
LNG_DVD="DVD Version"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA_1="Please insert disk 1 into your disk drive\nif not already done."
LNG_CHANGE_DISK="When the game setup will ask for next disk\nclick on \"Forward\""
LNG_INSERT_MEDIA_2="Please insert disk 2 into your disk drive\nif not already done."
LNG_INSERT_MEDIA="Please insert the disk into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256Mo of memory."
LNG_GAME_WARNING="You must disable anti-piracy protections of this game\nif you want to play it with wine."
LNG_SUCCES="$TITLE has been installed successfully."
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.princeofpersiagame.com" "GNU_Raziel" "$PREFIX"

select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

# Downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

# Creating prefix 
POL_SetupWindow_prefixcreate

# Choose between CD, DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CD~$LNG_DVD~$LNG_STEAM~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_CD" ]; then
	GAME_MEDIAVERSION="CD"	
elif [ "$APP_ANSWER" == "$LNG_DVD" ]; then
	GAME_MEDIAVERSION="DVD"
elif [ "$APP_ANSWER" == "$LNG_STEAM" ]; then
	GAME_MEDIAVERSION="STEAM"
else
	GAME_MEDIAVERSION="DD"
fi

# Installing mandatory dependencies
if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	POL_Call POL_Install_steam
else
	POL_Call POL_Install_vcrun2005
fi
POL_Call POL_Install_dxfullsetup

if [ "$GAME_MEDIAVERSION" == "CD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_1"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	cd "$WINEPREFIX"/dosdevices
	ln -s "$CDROM" d:
	wine start /unix "$CDROM/setup.exe"
	POL_SetupWindow_message "$LNG_CHANGE_DISK"
	wine eject
	POL_SetupWindow_message "$LNG_INSERT_MEDIA_2"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	rm ./d:
	ln -s "$CDROM" d:
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
elif [ "$GAME_MEDIAVERSION" == "DVD" ]; then
	# Asking for DVDROM and checking if it's correct one
	POL_SetupWindow_message "$LNG_INSERT_MEDIA"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	wine start /unix "$CDROM/setup.exe"
	POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
elif [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	wine "steam.exe" -applaunch 13600
	POL_SetupWindow_message "$LNG_WAIT_STEAM_END" "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
	wine start /unix "$SETUP_EXE"
	wineserver -w
	POL_SetupWindow_detect_exit
fi

# Asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > vms.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
EOF
regedit vms.reg
if [ "$VMS" -lt "256" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

## Fix for this game
POL_Call POL_Function_OverrideDLL "" "mmdevapi"

# Sound problem fix - pulseaudio related
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## PlayOnMac Section
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "PrinceOfPersia.EXE" "$TITLE" "Prince of Persia : Sands of Time.xpm" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

# Game protection warning
POL_SetupWindow_message "$LNG_GAME_WARNING" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4kf/kACgkQ5TH6yaoTykfekQCffAV1cUDPwK5A8juNMHGlrjxw
8vwAoIuKkbkxz56q2lLbAHAIRi9lai3h
=CZwj
-----END PGP SIGNATURE-----
