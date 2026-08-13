#!/bin/bash
# Date : (2011-16-07 21-00)
# Last revision : (2011-16-07 21-00)
# Wine version used : 1.3.23
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Lume"
PREFIX="lume"
WORKING_WINE_VERSION="1.3.23"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="La taille de votre mémoire graphique?"
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory do your graphic card have got?"
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/lume/top.jpg" "http://files.playonlinux.com/resources/setups/lume/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "State of Play Games" "http://www.lumegame.com/" "GNU_Raziel" "$PREFIX" 
 
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

# Choose between Steam and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_STEAM~$LNG_DDV" "~"

if [ "$APP_ANSWER" == "$LNG_STEAM" ]; then
	GAME_MEDIAVERSION="STEAM"
else
	unset STEAM_TYPE
	GAME_MEDIAVERSION="DD"
fi

# Installing mandatory dependencies
if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	POL_Call POL_Install_steam
else
	POL_Call POL_Install_vcrun2005
fi

if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	wine "Steam.exe" -applaunch 105100
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
POL_SetupWindow_auto_shortcut "$PREFIX" "Lume.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk46gMcACgkQ5TH6yaoTykcv7wCdE91NUUrllx9cXH8RJlwSHaEc
+LMAn16ILVPOIE2KMBFlWb9Io3zDh4Wy
=IXYE
-----END PGP SIGNATURE-----
