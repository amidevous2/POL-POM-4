#!/bin/bash
# Date : (2013-06-19 00-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Ubuntu 12.04.2 LTS
# Author : Niriddiki
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


# CHANGELOG
# [Niriddiki] (2013-06-19 00-00)
#   Initial script.
# [Niriddiki] (2013-06-29 15-13)
#   1.5.16 (very often errors) -> 1.6-rc2
# [Dadu042] (2020-01-19 13:50)
#   1.6-rc2 -> 2.22


TITLE="Heroes Chronicles: All Chapters"
WINEVERSION="2.22"
PREFIX="HC:ac_gog"
GOGID="heroes_chronicles_all_chapters"
EDITOR_URL="http://www.gog.com/gamecard/$GOGID" #?????? ?? ??????????? ?? ???? ???

POL_SetupWindow_Init
POL_SetupWindow_SetID 1743
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "New World Computing Inc. / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Niriddiki" "$PREFIX"

POL_SetupWindow_message "It's my first script. I have passed an examination in Mathematical analysis discipline and decided to do something good. Hope you'll try it. If you have any suggestions about script - you can write me at playonlinux.com If you have any advices about the wine version (I used 1.6-rc2, cause in 1.5.16 the game ends with error very often after the end of the turn) - please, do it!" "BETA!"

POL_SetupWindow_message "It is a lot of trouble in case you have two screens. Please, turn one off for the game. And it is highly recommended to switch your screen into 600x800 resolution. This will reduce quantity of errors during the game. Good Game!" "Attention!"

POL_Call POL_GoG_setup "$GOGID" "09c7be7cb7723a2e63afcee7bd9bca29"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

# GoG runs!

Set_OS winxp

#this 3 lines are also from HoMM3 script, thanks to petch

POL_SetupWindow_VMS "2"
Set_Managed "Off"
POL_Wine_reboot

POL_Shortcut "Warlords.exe" "Heroes Chronicles [Chapter 1] - Warlords of the Wasteland" "" "" "Game;StrategyGame;"
POL_Shortcut "Underworld.exe" "Heroes Chronicles [Chapter 2] - Conquest of the Underworld" "" "" "Game;StrategyGame;"
POL_Shortcut "Elements.exe" "Heroes Chronicles [Chapter 3] - Masters of the Elements" "" "" "Game;StrategyGame;"
POL_Shortcut "Dragons.exe" "Heroes Chronicles [Chapter 4] - Clash of the Dragons" "" "" "Game;StrategyGame;"
POL_Shortcut "WorldTree.exe" "Heroes Chronicles [Chapter 5] - The World Tree" "" "" "Game;StrategyGame;"
POL_Shortcut "FieryMoon.exe" "Heroes Chronicles [Chapter 6] -The Fiery Moon" "" "" "Game;StrategyGame;"
POL_Shortcut "Beastmaster.exe" "Heroes Chronicles [Chapter 7] - Revolt of the Beastmasters" "" "" "Game;StrategyGame;"
POL_Shortcut "Sword.exe" "Heroes Chronicles [Chapter 8] - The Sword of Frost" "" "" "Game;StrategyGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiWBjQAKCRDlMfrJqhPK
R2hzAJ9LUjPiP+z5SOjbrAeOQZxi27JQEwCfeTZnAXicHiyRFD05dVw2dWjVB3A=
=siMT
-----END PGP SIGNATURE-----
