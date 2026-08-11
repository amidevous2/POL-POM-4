#!/usr/bin/env playonlinux-bash
# Date : (2019-05-27 17-15)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: Eat The Rich (Windows) 26 April 2019, 79 MB.
# Software based on Unity 2018.
#
# CHANGELOG
# [Dadu042] (2019-05-27 17-15)
#   Initial writting.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Eat the rich"
PREFIX="Eat_the_rich"
WORKING_WINE_VERSION="4.9"
AUTHOR="Dadu042"
EDITOR="Call of the void & LolthersArt"
GAME_URL="https://callofthevoid.itch.io/eat-the-rich"
 
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "win7"

# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11

# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

###############
# Go          #
###############

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup ZIP file to extract.')" "$TITLE"
SETUP_EXE="$APP_ANSWER"

cd "$POL_System_TmpDir"
# TARGET_DIR="$WINEPREFIX/drive_c/$PREFIX"
# mkdir -p "$TARGET_DIR"
# cd "$TARGET_DIR"

POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"

POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"


POL_Shortcut "Eat The Rich.exe" "$TITLE" ""
  
# POL_Shortcut_Document "$TITLE" "doc.pdf"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOwFEAAKCRDlMfrJqhPK
R8kTAJ9dDLSYvZmHGLc4nbg1Acwiy+qoGACbBB5KwrntgSn0W2M3qjMhJCx24H4=
=b1Nm
-----END PGP SIGNATURE-----
