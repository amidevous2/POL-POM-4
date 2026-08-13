#!/bin/bash
# Date : (2012-01-08 10-18)
# Last revision : (2014-08-04 17-18)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="forgotten_realms_demon_stone"
PREFIX="DemonStone_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Forgotten Realms: Demon Stone"
SHORTCUT_NAME="Forgotten Realms: Demon Stone"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1037
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Stormfront Studios / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "63a2ad1487f308abab163a299b8a4d0b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "demonlaunch.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Demon Stone/manual.pdf"
# C:\GOG Games\Demon Stone\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPgBLQACgkQ5TH6yaoTykcUbwCgmQi6JdAafRj129CYu7TvO5U6
zmgAnjl6PS/CV2t0eisNZCV4UQyLJRdY
=Sibj
-----END PGP SIGNATURE-----
