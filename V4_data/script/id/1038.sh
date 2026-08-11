#!/bin/bash
# Date : (2012-01-08 20-49)
# Last revision : (2013-11-12 22-58)
# Wine version used : 1.3.36, 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-01-08 20-49)
#   Initial script.
# [Dadu042] (2020-02-15 23:53)
#   Wine 1.4.1 -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="iron_storm"
PREFIX="IronStorm_gog"

TITLE="GOG.com - Iron Storm"
SHORTCUT_NAME="Iron Storm"
SHORTCUT_DS="$SHORTCUT_NAME - $(eval_gettext 'Dedicated Server')"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1038
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "4X Studio / Anuman Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a5bd2245b5da437821bd93a0fc1e4daa"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "IronStorm.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut "IronStorm_DS.exe" "$SHORTCUT_DS" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Iron Storm/Manual.pdf"
# C:\GOG Games\Iron Storm\readme.txt

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXkmpNwAKCRDlMfrJqhPK
R+i7AJ9v7mmDDMRa7pBFY8t7nAnuCFRFbQCglZW19Qce7q37352unhEmQRkaGo0=
=UCDH
-----END PGP SIGNATURE-----
