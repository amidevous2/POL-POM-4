#!/bin/bash
# Date : (2012-09-08 18-30)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-08 18-30)
#   Initial script.
# [Pierre Etchemaite] (2014-02-10 00-02)
#   ? Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 2.22
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="back_to_the_future_the_game"
PREFIX="BackToTheFutureTG_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Back To The Future The Game"
SHORTCUT_NAME1="Back To The Future E1: It's About Time!"
SHORTCUT_NAME2="Back To The Future E2: Get Tannen!"
SHORTCUT_NAME3="Back To The Future E3: Citizen Brown"
SHORTCUT_NAME4="Back To The Future E4: Double Visions"
SHORTCUT_NAME5="Back To The Future E5: OUTATIME"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1392
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "52911f4ac26b5c519d2ecf3fcd8bc1fb" "9915656c4dbae69fede5c22b0b5cc633" "975b4662327a83b940e85f6a5b020ae3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_36

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BackToTheFuture101.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut "BackToTheFuture102.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut "BackToTheFuture103.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"
POL_Shortcut "BackToTheFuture104.exe" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"
POL_Shortcut "BackToTheFuture105.exe" "$SHORTCUT_NAME5" "$SHORTCUT_NAME5.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME5"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYj/QAKCRDlMfrJqhPK
R+HaAJwLwM67yXtqW9ff+Sh1UWo/hXgmwACfQ1Oj6HRI82JHpZOSseLz9MoLoO0=
=dSY9
-----END PGP SIGNATURE-----
