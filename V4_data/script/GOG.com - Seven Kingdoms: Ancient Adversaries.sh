#!/bin/bash
# Date : (2013-12-07 10-47)
# Wine version used :
# Distribution used to test : Ubuntu 12.04.2
# Author : markus_s
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [markus_s] (2013-12-07 10-47)
#   Initial script.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="seven_kingdoms_ancient_adversaries"
PREFIX="SevenKingdoms_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Seven Kingdoms: Ancient Adversaries"
SHORTCUT_NAME="Seven Kingdoms"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1898
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Enlight Software / Enlight Software" "http://www.gog.com/gamecard/$GOGID" "markus_s" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a8578d2554cbcea4cf2e2f06f2dab771"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#fake sdbinst.exe(this is from HoMM3 script made by petch)
#installer otherwise gives error message regarding sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"

POL_Call POL_GoG_install

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

cd "$POL_USER_ROOT/tmp"
POL_Download 'http://sourceforge.net/projects/skfans/files/Seven%20Kingdoms%20AA/Executables/7kaa-patch-2.13.2.zip/download' 'ea603670d78e8dacea65f1b309c41d73'
mv download 7kaa-patch-2.13.2.zip
POL_System_ExtractSingleFile 7kaa-patch-2.13.2.zip 7kaa-patch/7kaa.exe "$GOGROOT/Seven Kingdoms - Ancient Adversaries/7k.exe"

POL_Shortcut "7k.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Seven Kingdoms - Ancient Adversaries/manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCVTwAKCRDlMfrJqhPK
R32gAJ0X/uPnMFqg1thFM5i30/oSFZW+gQCfYtt6NibBdHe+jLv31rU5LCyP5jM=
=gmP+
-----END PGP SIGNATURE-----
