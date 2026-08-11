#!/bin/bash
# Date : (2012-01-02 23-43)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Pierre Etchemaite] (2012-01-02 23-43)
#   First script.
# [Pierre Etchemaite] (2014-05-04 22-20)
#   ?
# [Dadu042] (2020-08-24)
#   Wine 1.6.2 (outdated) -> system


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="fallout_2"
PREFIX="Fallout2_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Fallout 2"
SHORTCUT_NAME="Fallout 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1033
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Black Isle Studios / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a567c4777ce4cf0f28ffb64211018f1c"

POL_Wine_SelectPrefix "$PREFIX"
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "fallout2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
# sometimes exits with an exitcode of 1 for what it seems no good reason
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Fallout 2/MANUAL.PDF"
# C:\Program Files\GOG.com\Fallout 2\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX0PmJwAKCRDlMfrJqhPK
R2WlAJ0aQ7qfxwAR8SgjtvOaDECCFELJ4QCfeNrrsStFqjFVewzuDSC1jxXXQFA=
=Dunq
-----END PGP SIGNATURE-----
