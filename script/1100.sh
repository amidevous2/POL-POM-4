#!/bin/bash
# Date : (2012-03-17 21:00)
# Last revision : (2012-03-25 21:00)
# Wine version used : 1.4
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2012-03-17 21:00)
#   First script.
# [Dadu042] (2019-12-23 20:55)
#   Wine 1.4 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Q.U.B.E"
TITLE_DEMO="Q.U.B.E (Demo)"
PREFIX="qube"
EDITOR="Toxic Games"
GAME_URL="http://qube-game.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/qube/top.jpg" "http://files.playonlinux.com/resources/setups/qube/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,STEAM,DESURA,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam
fi
if [ "$INSTALL_METHOD" == "DESURA" ]; then
	POL_Call POL_Install_desura
fi
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_dotnet40

# Mandatory settings for Digital version
[ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="204610"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="203730"; SHORTCUT_NAME="$TITLE"; }
[ "$INSTALL_METHOD" == "DESURA" ] && { DESURA_ID="1334"; SHORTCUT_NAME="$TITLE"; }

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > Fix.reg
[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]
"GrabFullscreen"="Y"
EOF
POL_Wine regedit "Fix.reg"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Begin installation
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "DESURA" ]; then
	# Shortcut done before install for desura version
	POL_Shortcut "Desura.exe" "$SHORTCUT_NAME" "" "desura://launch/games/star-twine/$DESURA_ID"
	# Desura install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Desura is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Desura interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Desura"
	POL_Wine start /unix "Desura.exe" desura://launch/games/star-twine/$DESURA_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"

	# Shortcut done after install for local version
	POL_Shortcut "QUBE.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgI5XgAKCRDlMfrJqhPK
R02CAJ984mAukSJAGt/tj5ux26s1KN2SXwCdE8CG0Ka/3ipZaV967KhCwjsIarU=
=AI5p
-----END PGP SIGNATURE-----
