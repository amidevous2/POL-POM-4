#!/bin/bash
# Date : (2013-07-19 23-13)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-07-19 23-13)
#   Initial script.
# [Pierre Etchemaite]  (2014-03-02 19-50)
#   ? Wine 1.4.1 -> 1.6.2
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 3.0.3
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="avadon_the_black_fortress"
PREFIX="AvadonTBF_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Avadon: The Black Fortress"
SHORTCUT_NAME="Avadon: The Black Fortress"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1777
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Studio / Publisher" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c2c2b35b29a2fb5bfdecd413cbc3dbb4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Avadon.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Avadon - The Black Fortress/Manual.pdf"
# C:\GOG Games\Avadon - The Black Fortress\Map of Lynaeus.jpg

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYiqQAKCRDlMfrJqhPK
R+oYAJ4tdQOlNn0abrrUbvV+1HNvcqte8wCeJEffdcz7nCHrnO3aEUxRevZOjnU=
=9PkW
-----END PGP SIGNATURE-----
