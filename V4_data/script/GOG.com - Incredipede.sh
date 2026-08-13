#!/bin/bash
# Date : (2013-03-08 22-54)
# Last revision : (2013-05-23 21-23)
# Wine version used : 1.5.5
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# 1.5.5, 1.5.10, 1.5.16, 1.5.20, 1.5.24, 1.5.25: Connect server just fine
# 1.4.1, 1.5.0, 1.5.3, 1.5.4: Problem connecting to server

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="incredipede"
PREFIX="Incredipede_gog"
WORKING_WINE_VERSION="1.5.5"

TITLE="GOG.com - Incredipede"
SHORTCUT_NAME="Incredipede"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1613
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Northway Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "91c011a2bbae10c7f9a2b8ecdfe9cb24"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Incredipede.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;LogicGame;"

# Disable autorepeat to avoid flooding Adobe Air with keyboard events
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'xset r off'
echo "xset r on" >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGeb2UACgkQ5TH6yaoTykfPFgCeNh7sEi8/RqfW7+CBRPXiuZac
mxoAniilygXefDjfKNN9fkmmPmFiV0Go
=PAmP
-----END PGP SIGNATURE-----
