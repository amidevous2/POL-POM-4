#!/bin/bash
# Date : (2015-08-05 18-29)
# Wine version used : 3.0.3
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-08-05 18-29)
#   Initial script.
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 (outdated) -> 3.0.3
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - ANNO 1602 A.D."
PREFIX="ANNO1602"
WINEVERSION="3.0.3"
SHORTCUT_NAME="ANNO 1602 A.D."
GOGID="anno_1602_ad"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Max Design GesMBH" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "ef641bc8dc3d434d8bbb6ff752df6ba7"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

# virtual desktop required to avoid crash on launch
Set_Desktop On 640 480

POL_Wine_reboot

POL_Shortcut "1602.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;"
POL_Shortcut "1602Edit.exe" "$SHORTCUT_NAME Editor" "" "" "Game;StrategyGame;"
POL_Shortcut "Config.exe" "$SHORTCUT_NAME Config" "" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Anno 1602 - Creation of a New World/Manual.PDF"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwQAQAKCRDlMfrJqhPK
R3NHAJ4sII2yhQYP3phzKZDR163hD4oqWQCeN87IfQQ6W4dm4NnNtgHqDBaj0cs=
=PRBs
-----END PGP SIGNATURE-----
