#!/bin/bash
# Date : (2012-06-30 23-07)
# Last revision : (2014-02-02 19-35)
# Wine version used : 1.5.7
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="broken_sword_4"
PREFIX="BrokenSword4_gog"
WORKING_WINE_VERSION="1.5.7"

TITLE="GOG.com - Broken Sword 4: The Angel of Death"
SHORTCUT_NAME="Broken Sword 4: The Angel of Death"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1287
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Sodtware" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "8fb838777b6bb5f65390322bc7145e20"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Call POL_Install_d3dx9_36

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "bs4pc.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-language=english" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Broken Sword - The Angel of Death/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLukI8ACgkQ5TH6yaoTykd7dgCcDqePKEA+/z0Ijm8SyA9LpCzC
Qd0AnRnAO+ie5PpAkKQ8X6K1lFzFaYJQ
=MBIc
-----END PGP SIGNATURE-----
