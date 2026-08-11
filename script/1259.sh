#!/bin/bash
# Date : (2012-06-17 10-47)
# Last revision : (2013-12-21 00-47)
# Wine version used : 1.4.1, 1.5.5, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-17 10-47)
#   Initial script.
# [Dadu042] (2020-02-02 21:40)
#   Wne 1.6.2 -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="still_life"
PREFIX="StillLife_gog"

TITLE="GOG.com - Still Life"
SHORTCUT_NAME="Still Life"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1259
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microids / Anuman Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "130a60446434e68dacb4bed552baa784"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "StillLife.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Still Life/MANUAL.pdf"
# C:\GOG Games\Still Life\ReadMe.txt
# C:\GOG Games\Still Life\walkthrough.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjnkYgAKCRDlMfrJqhPK
Rz7MAJ41cAseKbh4GECGEMOEarfra1cK5wCfdRVg+YiwQqy5X207r8lXTJuFe+A=
=8/jc
-----END PGP SIGNATURE-----
