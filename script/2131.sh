#!/bin/bash
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Riffstation"
PREFIX="Riffstation"
EDITOR="Riffstation"
GAME_URL="http://www.riffstation.com/"
AUTHOR="Quentin PÂRIS"
 
# Starting the script
POL_SetupWindow_Init
POL_SetupWindow_SetID 2131
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting Wine Version
WORKING_WINE_VERSION="1.7.17"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Downloading client or using local one
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Downloading client or choosing existing one
mkdir -p "$WINEPREFIX/drive_c/$PROGRAMFILES/TERA"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Downloading client
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/TERA"
        POL_Download "http://www.riffstation.com/RiffstationTrial.exe" "c1abbcdc69dc561045634f0bb08ceed7"
        SETUP_EXE="$PWD/RiffstationTrial.exe"
else
        # Asking for client exe
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
fi
POL_Wine "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
 
# Making shortcut
POL_Shortcut "Riffstation.exe" "Riffstation"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXmqLJwAKCRDlMfrJqhPK
R7kMAJ9Xzyo7xRfUfoE3hqf49Rqby7P2uACeJBGTnPMBEc7R08L5QfRtgqbUTOo=
=LOg5
-----END PGP SIGNATURE-----
