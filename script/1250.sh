#!/bin/bash
# Date : (2012-06-09 16-26)
# Last revision : 
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-09 16-26)
#   Initial script.
# [Pierre Etchemaite] (2013-07-23 20-21)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="thief_2_the_metal_age"
PREFIX="Thief2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Thief 2"
SHORTCUT_NAME="Thief 2: The Metal Age"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1250
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Looking Glass Studios / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c554b94e371ff78bfbe5a8ef3417afe2"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Enable OpenAL by default (#2585)
cp "$GOGROOT/Thief 2 - The Metal Age/cam.cfg" "$GOGROOT/Thief 2 - The Metal Age/cam.cfg.bak"
sed -e 's/^sfx_device [0-9]\+/sfx_device 4/' \
    -e 's/^master_volume -\?[0-9]\+/master_volume -1/' \
  < "$GOGROOT/Thief 2 - The Metal Age/cam.cfg.bak" > "$GOGROOT/Thief 2 - The Metal Age/cam.cfg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Thief2_ND.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Thief 2 - The Metal Age/Manual.pdf"
# C:\GOG Games\Thief 2 - The Metal Age\DromEd.exe

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxLtgAKCRDlMfrJqhPK
R50zAKCT1pmekT7ABXRFKMh9kppvrsueqwCgoeulzQxOh4aYXQ07QTlLdjGWK7U=
=njRD
-----END PGP SIGNATURE-----
