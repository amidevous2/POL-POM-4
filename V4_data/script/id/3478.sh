#!/bin/bash
# Date : (2019-04-03 21-43)
# Last revision : (2019-04-03 21-43)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : version unknown, files date on DVD : february 2011.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Margrave Manor 2: The Lost Ship"
PREFIX="margravemanor2"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="Just For Games"
GAME_URL="https://en.wikipedia.org/wiki/MumboJumbo"

Set_OS "win7"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# Not necessary:
# POL_Call POL_Install_d3dx9
 
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
        POL_SetupWindow_check_cdrom "MargraveManor2.exe"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "Margrave Manor 2.exe" "$TITLE" ""

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiL4QAKCRDlMfrJqhPK
R86qAJ9K4rvakOdqNNFwiZ3YSNXLR9ktsgCeJpLJC8CvDFmtoca2y8YxN+wGjqc=
=CR1M
-----END PGP SIGNATURE-----
