#!/usr/bin/env playonlinux-bash
# Date : (2019-05-22 01-04)
# Last revision : (2019-05-22 01-04)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Script wrote according to: https://medium.com/@kewshka/sketchup-pro-2018-on-ubuntu-18-04-bionic-9b33a7986850
# Thanks to Jorge_r69 for the report.
# According the date ot the howto, I (Dadu042) think that the Wine version used was 3.13

[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="SketchUp 2018"
PREFIX="SketchUp2018"
WORKING_WINE_VERSION="3.12"
AUTHOR="Dadu042"
EDITOR="Trimble"
GAME_URL="https://en.wikipedia.org/wiki/SketchUp"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "win7"

POL_Call "POL_Install_vcrun2005"

# Allow to choose between 2 video cards in the same PC.
POL_Call "POL_Install_VideoDriver"

POL_Call "POL_Install_dotnet45"

POL_Wine_OverrideDLL "native" "mfc140u.dll"

###############
# Go          #
###############

        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"

POL_Shortcut "SketchUp.exe" "$TITLE" "" "Graphics;"
POL_Shortcut "SketchUpPro.exe" "$TITLE Pro" "" "Graphics;"

# POL_Shortcut_Document "$TITLE" "Manual.pdf"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiNGgAKCRDlMfrJqhPK
RxrWAJ0dawH55ufXPttAIQK1pfqfSO9C9gCgkrD0wflwDH5hHdW3serJ9Utxju8=
=x1g2
-----END PGP SIGNATURE-----
