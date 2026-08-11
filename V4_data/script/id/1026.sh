#!/bin/bash
# Date : (2011-12-28 18-20)
# Last revision : 
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-28 18-20)
#   Initial script.
# [Pierre Etchemaite] (2014-06-14 11-16)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system
# 
 
#    Lockup with Wine 1.3.36 when reaching to top of the stairs
#    Same with 1.3.35
#    Same with 1.3.34
#    Same with 1.3.30
#    Same with 1.4.1
#    Crash with 1.5.3 when reaching to top of the stairs
#    Crash with 1.3.29 when statue "lights up"
#    Same with 1.5.0
#    Heavy flickering with 1.3.27-rawinput2
#    Ok with 1.3.24?
#    Ok with 1.3.23?
#    Ok with 1.2.3?
#    Ok with 1.5.24?
#    Ok with 1.5.20?
#    Ok with 1.5.15?
#    Ok with 1.5.10?
#    Ok with 1.5.5?
#    Ok with 1.5.4?

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sanitarium"
PREFIX="Sanitarium_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Sanitarium"
SHORTCUT_NAME="Sanitarium"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1026
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "DreamForge Intertainment / XS Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "9ae34606b3ce3ffb893e5e8b191525bc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


Set_OS win98

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

SHORTCUT_WINDOW="$SHORTCUT_NAME $(eval_gettext '(windowed)')"
POL_Shortcut "sntrm.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut "sntrm.exe" "$SHORTCUT_WINDOW" "$SHORTCUT_NAME.png" "-w" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Sanitarium/manual.pdf"
POL_Shortcut_Document "$SHORTCUT_WINDOW" "$GOGROOT/Sanitarium/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCZKgAKCRDlMfrJqhPK
R8vNAKCVKDeWTt/KD3YqpsE6wlENWcsOvACfV0FqIdsVzDeJaTVoma8XKyTVs9I=
=pESN
-----END PGP SIGNATURE-----
