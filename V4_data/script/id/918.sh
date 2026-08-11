#!/bin/bash
# Date : (2011-04-08 21-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-04-08)
#   First script.
# [Dadu042] (2019-12-08)
#   Wine 1.3.23 -> 2.22
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Runespell : Overture"
TITLE_DEMO="Runespell : Overture (Demo)"
PREFIX="runespell_overture"
WORKING_WINE_VERSION="2.22"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DEMO="Version Demo (via Steam)"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="La taille de votre mémoire graphique ?"
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_DEMO="Demo Version (with Steam)"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory do your graphic card have got?"
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256MB of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/runespell/top.jpg" "http://files.playonlinux.com/resources/setups/runespell/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "In-House" "http://www.runespell.com/" "GNU_Raziel" "$PREFIX" 
 
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

# Choose between Steam and other Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_DEMO~$LNG_STEAM~$LNG_DDV" "~"

if [ "$APP_ANSWER" == "$LNG_DEMO" ]; then
	STEAM_TYPE="$APP_ANSWER"
	GAME_MEDIAVERSION="STEAM"
elif [ "$APP_ANSWER" == "$LNG_STEAM" ]; then
	STEAM_TYPE="$APP_ANSWER"
	GAME_MEDIAVERSION="STEAM"
else
	unset STEAM_TYPE
	GAME_MEDIAVERSION="DD"
fi

#Installing mandatory dependencies
if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	POL_Call POL_Install_steam
else
	POL_Call POL_Install_vcrun2005
fi
POL_Call POL_Install_vcrun2008

if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
	if [ "$STEAM_TYPE" == "$LNG_DEMO" ]; then
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
		wine "Steam.exe" -applaunch 102220
	else
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
		wine "Steam.exe" -applaunch 102200
	fi
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
if [ "$STEAM_TYPE" == "$LNG_DEMO" ]; then
	POL_SetupWindow_auto_shortcut "$PREFIX" "Steam.exe" "$TITLE_DEMO" "$TITLE.png" "-applaunch 102220"
	Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE_DEMO"
else
	POL_SetupWindow_auto_shortcut "$PREFIX" "Runespell.exe" "$TITLE" "$TITLE.png" ""
	Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
fi

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXe1OoQAKCRDlMfrJqhPK
R5LOAKCJXGXF7mKhLzjq/i6jHz5T3Ci1vwCcD3jV7IT7lnx+7IG9vjKoxGEDqRo=
=ci/n
-----END PGP SIGNATURE-----
