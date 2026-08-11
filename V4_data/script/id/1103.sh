#!/bin/bash
# Date : (2012-03-18 22-56)
# Last revision : (2013-05-18 16-38)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dungeons_dragons_dragonshard"
PREFIX="Dragonshard_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Dungeons and Dragons: Dragonshard"
SHORTCUT_NAME="Dungeons&Dragons: Dragonshard"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1103
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Liquid Entertainment / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2305ae02d1f1df7147aeddc52e05ccd2"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Dragonshard.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Dungeons and Dragons - Dragonshard/manual.pdf"
# C:\GOG Games\Dungeons and Dragons - Dragonshard\DNDEditor.exe
# C:\GOG Games\Dungeons and Dragons - Dragonshard\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGXlqYACgkQ5TH6yaoTykfITgCeKNWfpnBx6IBKG4kN9eP3/x0t
DVcAniGB1ogWwUX5NbCkc5S7/UqWaOmn
=49BV
-----END PGP SIGNATURE-----
