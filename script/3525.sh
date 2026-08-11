#!/bin/bash
# Date : (2019-03-11 14-23)
# Last revision : (2019-03-11 14-23)
# Wine version used : 4.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : Digital Download build.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Evoland Legendary Edition"
PREFIX="evoland_le"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Dadu042"
EDITOR="Shiro Games"
GAME_URL="https://en.wikipedia.org/wiki/Evoland"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# Fix the error 'Runtime error 229 at XXXXXXX'
Set_OS winxp
 
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
#        POL_SetupWindow_check_cdrom "setup-1.bin"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "Evoland.exe" "$TITLE" "" "" "game;"
 
# POL_Shortcut_Document "$TITLE" "manual.pdf"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYCjenwAKCRDlMfrJqhPK
R2OtAKCo0nx3S75yV3etgpg7mVeSdCE/QwCfbg9wJU11VagJ7ons0TEoQkMvsk8=
=QLGu
-----END PGP SIGNATURE-----
