#!/bin/bash
# Date : (2012-09-29 03-54)
# Last revision :  see changelog
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-29 03-54)
#   Initial script.
# [Pierre Etchemaite] (2013-11-24 20-44)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="zeus_poseidon"
PREFIX="ZeusAndPoseidon_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Zeus and Poseidon"
SHORTCUT_NAME="Zeus + Poseidon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1418
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Impressions Games / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "34964312b267b50e2628e6f68026b004"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Zeus.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Zeus and Poseidon/Zeus - Manual.pdf"
# C:\GOG Games\Zeus and Poseidon\Zeus - Quick Reference Card.pdf
# C:\GOG Games\Zeus and Poseidon\Zeus - Poseidon - Manual.pdf
# C:\GOG Games\Zeus and Poseidon\Zeus - Adventure_Editor - Manual.pdf
# C:\GOG Games\Zeus and Poseidon\Zeus - Poseidon - Adventure_Editor - Manual.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYgJQAKCRDlMfrJqhPK
RyBuAJ9H7gHpcOwQJCCES0EWmlgnBcRZMgCeN6c/c/fVdF8Wkx9AJgY6+nOTF10=
=cX1r
-----END PGP SIGNATURE-----
