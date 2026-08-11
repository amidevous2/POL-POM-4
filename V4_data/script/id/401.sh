#!/bin/bash
# Date : (2015-03-30T17:30Z)
# Last revision : (2015-03-30T17:30Z)
# Distribution used to test : Arch Linux
# Author : Alexander Borysov (Xenos5)
# Script licence : GPLv3
# Program licence: Proprietary
#
# CHANGELOG
# [Alexander Borysov (Xenos5)] (2015-03-30T17:30Z)
#   Initial script.
# [Dadu042] (2020-01-16 23:00)
#   Wine 1.7.39 -> 3.0.3.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="S.T.A.L.K.E.R.: Clear Sky"
PREFIX="STALKERClearSky"
WINEVERSION="3.0.3"
STEAM_APP_ID=20510

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Deep Silver" "http://stalker-game.com" "Alexander Borysov" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup-1.bin"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$CDROM/setup.exe"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Call POL_Install_steam
   cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
   POL_Wine "steam.exe" "steam://install/$STEAM_APP_ID"
   POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
fi

POL_SetupWindow_VMS "128"

if [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APP_ID -no-dwrite"
else
    binary_path=$(find_binary xrEngine.exe | sed 's|dedicated/xrEngine.exe$|xrEngine.exe|g')
    #binary_path=$(POL_System_find_file "bin/xrEngine.exe") # needs commit 09735e098bc3aa6649393c9271d5f55466f35bfb, presumably in PoL 4.2.7
    POL_SetupWindow_make_shortcut "$PREFIX" "$(dirname "$(dirname "$binary_path")")" "bin/xrEngine.exe" "S.T.A.L.K.E.R.: Clear Sky.png" "$TITLE" "" ""
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDenwAKCRDlMfrJqhPK
R/SAAKCxfMBjSoZSbad8Vk9m39K/NYHsmwCeMf97ZGV4lSZLksEdx4Su+9QLOz4=
=KAeE
-----END PGP SIGNATURE-----
