#!/bin/bash
# Date : (2012-02-25 23-27)
# Last revision : (2014-06-14 20-29)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Seems to work ok with and without QT Lite - your choice

# CHANGELOG
# [Pierre Etchemaite] (2012-02-25 23-27)
#   Initial script.
# [Dadu042] (2020-03-18 11:10)
#   Wine 1.6.2 (outdated) -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="riven_the_sequel_to_myst"
PREFIX="Riven_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Riven: The sequel to Myst"
SHORTCUT_NAME="Riven: The sequel to Myst"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1074
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cyan Worlds / Cyan Inc" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "27b5e91662ac661b0a825bdd5a68c9c8"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2" # "640x480 16bit"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Riven.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Riven - The Sequel to Myst/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnJ/zQAKCRDlMfrJqhPK
R+BKAKChYOURONC0uNZrO7jAx4LwRud7UQCdEZb+dr84RbSWzeNwFXOtAMj9xy4=
=CBAW
-----END PGP SIGNATURE-----
