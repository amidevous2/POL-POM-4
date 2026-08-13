#!/bin/bash
# Date : (2019-03-21 19-11)
# Last revision : (2019-03-23 20-51)
# Wine version used : 3.19
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : CD v1.10 french (ef.dbd : january 2001).
# Game released with DirectX 7.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star Trek Voyager - Elite Force"
PREFIX="star-trek-v-elite-force"
WORKING_WINE_VERSION="3.20"
AUTHOR="Dadu042"
EDITOR="Activision"
GAME_URL="https://en.wikipedia.org/wiki/Star_Trek:_Voyager_%E2%80%93_Elite_Force"

Set_OS "winxp"
Set_Desktop On 1024 768

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

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
        POL_SetupWindow_check_cdrom "ds32.dll"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "stvoy.exe" "$TITLE" ""
POL_Shortcut "stvoyHM.exe" "$TITLE - Multi player" ""
POL_Shortcut "sysinfo.exe" "$TITLE - Sysinfo" ""

POL_Shortcut_Document "$TITLE" "default.htm"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiGHAAKCRDlMfrJqhPK
R64gAJ0YtI2TSfF0waNmMHEwvQL1zntNvACfazf1h2Ib9PXjIiFfIEjydc0+P6Y=
=/9ES
-----END PGP SIGNATURE-----
