#!/usr/bin/env playonlinux-bash
# Date : (2020-04-19 19-33)
# Last revision : (2020-04-19 22-53)
# Wine version used : 4.0.3
# Distribution used to test : Linux Mint 19.3 Cinnamon
# Author : Yaotl
# PlayOnLinux : 4.3.4
# Script licence : GPL3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Anno 1404"
PREFIX="Anno1404"
WINEVERSION="4.0.4"

# Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 4028
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Ubisoft/Related Designs/Blue Byte" "http://anno.uk.ubi.com/pc/history1404.php" "Yaotl" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dx9_40
POL_Call POL_Install_vcrun2005

# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}

Set_OS "winxp"

Set_Desktop On 1024 768

# Delete DirectX 10 dependence # only works correctly with directx 9
rm -rf "$WINEPREFIX/drive_c/windows/system32/d3d10.dll"

# Installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" == "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup.exe"
    POL_Wine start /unix "$CDROM/setup.exe"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
fi

# Create Shortcut
POL_Shortcut "Anno4.exe" "$TITLE" "" "" "Game;"

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkOQXAAKCRDlMfrJqhPK
R37aAJ0fFedVYOJFl7v0tpcozPa6KvFXoQCgmwQ61nHnMJ6lta5cfCrwr+WE4+M=
=6ZhH
-----END PGP SIGNATURE-----
