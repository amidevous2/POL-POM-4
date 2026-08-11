#!/bin/bash
# Date : (2014-07-07 12-00)
# Wine version used : 1.7.21
# Distribution used to test : Arch Linux x64
# Author : Thermionix
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Counter Strike: Global Offensive"
PREFIX="csgo"
STEAM_ID="730"
EDITOR="Valve"
GAME_URL="http://www.counter-strike.net/"
AUTHOR="Thermionix"
WORKING_WINE_VERSION="2.11"
GAME_VMS="512"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/csgo/top.png" "http://files.playonlinux.com/resources/setups/csgo/left.png" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_dinput

POL_Call POL_Install_steam 
POL_Call POL_Install_steam_flags "$STEAM_ID"

POL_Wine_SetVideoDriver
POL_SetupWindow_VMS $GAME_VMS

POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
POL_Wine_Direct3D "StrictDrawOrdering" "disabled"
POL_Wine_OverrideDLL "" "gameoverlayrenderer"

# Spoof as Nvidia card for AMD users
if `POL_DetectVideoCards | grep -qi AMD` ; then
POL_Wine_UpdateRegistry amd_fix <<- _EOFINI_
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoPCIVendorID"=dword:000010de
"VideoPCIDeviceID"=dword:00000402
_EOFINI_
fi

POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""

POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAln5/EYACgkQ5TH6yaoTykf6YQCgj6ckIazi9cOmYjHs+PW5X417
HJsAnigGFFOTIm/skyduQ5fmxsTr6idv
=t0bw
-----END PGP SIGNATURE-----
