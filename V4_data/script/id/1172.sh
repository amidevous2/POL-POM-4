#!/bin/bash
# Date : (2012-05-07 22-36)
# Last revision : see changelog
# Wine version used : 1.5.15, 1.6, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-07 22-36)
#   Initial script.
# [Pierre Etchemaite] (2014-05-29 15-08)
#   Script updated for GOG's installer v2.
#   Sound mixing fixed in 1.5.7
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="syberia"
PREFIX="Syberia_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Syberia"
SHORTCUT_NAME="Syberia"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1172
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microids / Anuman Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "0ec452842adf2fb4f95c5f06e4304d42"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

POL_Call POL_Install_vcrun6

cd "$POL_USER_ROOT/tmp"
POL_Download "http://files.playonlinux.com/nircmd.zip" "3d6d3f094633c5c97f8b15f8fe1023bf"
POL_System_ExtractSingleFile "nircmd.zip" "nircmd.exe" "$WINEPREFIX/drive_c/windows/nircmd.exe"

# For OS X
Set_Managed Off

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Syberia.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"

# Work around "black screen" bug http://bugs.winehq.org/show_bug.cgi?id=21796
# double quotes around "P"OL_Wine prevent POL getArgs to pickup this line, sorry for the hack
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '(sleep 10; "P"OL_Wine nircmd.exe win hide title Syberia; sleep 0.1; "P"OL_Wine nircmd.exe win hideshow title Syberia)&'
echo "wait" >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Syberia/Manual.pdf"
# C:\GOG Games\Syberia\ReadMe.txt

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx8NwAKCRDlMfrJqhPK
R6c5AKCx1pnKHiVtUWbmU+G4uAdFIiaoPgCdHzC6GmwHnZjcfAVgefU7Ltn41kM=
=elwp
-----END PGP SIGNATURE-----
