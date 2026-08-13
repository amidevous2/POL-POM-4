#!/bin/bash
# Date : (2020-07-24 18-49)
# Wine version used : 5.9
# Distribution used to test : OpenSUSE Leap 15.1
# Author : Benjamin Hardy


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - The Marvellous Miss Take"
PREFIX="The_Marvellous_Miss_Take"
WINEVERSION="5.9"
SHORTCUT_NAME="The Marvellous Miss Take"
GOGID="the_marvellous_miss_take"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Wonderstruck / Rising Star Games" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "e2824f1920a6589c4b83c7ad2480c6f8"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install


POL_Wine_reboot

POL_Shortcut "misstake.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"


POL_SetupWindow_Close
 
exit 0 
 

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXvOaBwAKCRDlMfrJqhPK
R8GqAJ9B5FO0+Tdq686fAD34i9ogSmp3cACfR0DalTBA3THX2IDxtbMfEDA4aD8=
=wcrO
-----END PGP SIGNATURE-----
