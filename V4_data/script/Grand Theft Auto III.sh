#!/usr/bin/env playonlinux-bash
# Date : (2019-06-01 13-21)
# Last revision : (2019-06-01 14-56)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Media used:
#
# CHANGELOG:
# [Dadu042] (2019-06-01)
#   Rewrite the script for because the previous (2009-10-31) fail working (on POL 4.3.4).
#
# KNOWN ISSUES:
# None.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Grand Theft Auto III"
PREFIX="gta_III"
WORKING_WINE_VERSION="2.22"
AUTHOR="Dadu042"
EDITOR="Rockstar Games"
GAME_URL="https://en.wikipedia.org/wiki/Grand_Theft_Auto_III"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

################
# GPU settings #
################

# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "16"

POL_Call POL_Install_VideoDriver

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# Useless because On by default (Set if the window manager will be allowed to manage Wine windows.)
# Set_Managed "On"

POL_Wine_X11Drv "DXGrab" "Y"
# Was used in 2009:
# Set_DXGrab "On"

###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,CD"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup.exe"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "gta3.exe" "$TITLE" "" "Game;"

POL_SetupWindow_message "When you will run GTA 3, wait a few seconds and double-click to launch correctly\nthe game.\n\nFRENCH: Quand vous lancerez GTA 3, patientez quelques secondes puis double-cliquez pour\nlancer correctement le jeu." "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRic3gAKCRDlMfrJqhPK
R14mAKCp5k7su7o8T6xIoj+h3sQ7NmhDJQCeNyYggH6Jz4HssXI6mH1jQtkWZos=
=VgrW
-----END PGP SIGNATURE-----
