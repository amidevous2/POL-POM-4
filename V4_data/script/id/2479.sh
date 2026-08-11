#!/bin/bash
# Date : (2015-03-25T21:00Z)
# Last revision : see changelog
# Distribution used to test : Arch Linux
# Author : Alexander Borysov (Xenos5)
# Script licence : GPLv3
# Program licence: Proprietary
#
# CHANGELOG:
# [Catskan] (2015-03-25)
#   First version.
# [Dadu042] (2019-12-08)
#   Wine 1.7.39 -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="S.T.A.L.K.E.R.: Call of Pripyat"
PREFIX="STALKERCallOfPripyat"
WINEVERSION="2.22"
STEAM_APP_ID=41700

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "BitComposer Games" "http://stalker-game.com" "Alexander Borysov" "$PREFIX"

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
POL_Wine_OverrideDLL "" "d3dx11_42" # avoids a crash on start

if [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APP_ID -no-dwrite"
else
    POL_Shortcut "Stalker-COP.exe" "$TITLE" "S.T.A.L.K.E.R.: Call of Pripyat.png" "" "Game;"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXe1QMwAKCRDlMfrJqhPK
RxoVAJ4h8Niv74YoD0BBzg8KAX36pVNkkACeKPFCkDp3ldRmGE6fIczJD+wv6mM=
=5hyE
-----END PGP SIGNATURE-----
