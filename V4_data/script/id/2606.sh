#!/usr/bin/env playonlinux-bash
# Date : (2019-05-10 22-16)
# Last revision : (2019-05-10 22-16)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Software version used of the software to write this script: v11.2.2 (2019)

[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="E-Sword"
PREFIX="e-sword"
WORKING_WINE_VERSION="6.0"
AUTHOR="Dadu042"
EDITOR=""
GAME_URL="https://www.e-sword.net"
 
Set_OS "win7"
 
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"


###############
# Go          #
###############
    
POL_SetupWindow_InstallMethod "LOCAL"
    
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
fi
    
POL_Shortcut "e-sword.exe" "$TITLE" ""
  
POL_Shortcut_Document "$TITLE" "e-sword_guide.pdf"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYjJwNAAKCRDlMfrJqhPK
R5unAKCk/ymiYkhMxYSKBVejo7xjOAHw5ACgltuYRx23PuSowg/cgrfGy/Lk7S8=
=U0CT
-----END PGP SIGNATURE-----
