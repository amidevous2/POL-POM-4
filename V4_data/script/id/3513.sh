#!/usr/bin/env playonlinux-bash
# Date : (2019-04-01 12-26)
# Last revision : see changelog
# Wine version used : 4.8
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# CHANGELOG
# [Dadu042] (2019-04-01)
#   First script.
# [Dadu042] (2019-12-30)
#   POL_RequiredVersion 4.3.4
#   Improve POL_Shortcut
#
# KNOWN ISSUEs:
# - As of 2019-04-0 with Wine 3.19 : game suffer from graphic issues (red filter).
# - As of 2019-04-0 with Wine 4.5 : game suffer from graphic issues (black parts).

 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Farming simulator 19"
PREFIX="fs19"
WORKING_WINE_VERSION="4.8"
AUTHOR="Dadu042"
EDITOR="Giants"
GAME_URL="https://en.wikipedia.org/wiki/Farming_Simulator"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "Win7"

POL_Call POL_Install_VideoDriver

# Really Useful ? (Dadu042)
POL_SetupWindow_VMS "1024"

POL_Call POL_Install_d3dx11

###############
# Go          #
###############
  
POL_SetupWindow_InstallMethod "LOCAL,DVD"
  
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup-3.bin"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "FarmingSimulator2019.exe" "$TITLE" "" "" "Game;"

# Filename to change ?
POL_Shortcut_Document "$TITLE" "Manual.pdf"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgqYlwAKCRDlMfrJqhPK
Ry9lAJ0aGeIKEnHgQX0rlD2SEkhVa75o7ACfWTyE7qciC6zN2tVz4SCt8h6xFhk=
=6Nyn
-----END PGP SIGNATURE-----
