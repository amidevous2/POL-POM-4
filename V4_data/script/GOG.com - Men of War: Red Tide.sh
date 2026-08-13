#!/usr/bin/env playonlinux-bash
#
# CHANGELOG
# [robka] (2015-12-04)
#   Initial script.
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.6.2 -> 3.0.3


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="men_of_war_red_tide"
WORKING_WINE_VERSION="3.0.3"
TITLE="GOG.com - Men of War: Red Tide"
PREFIX="MoW_RedTide"
SHORTCUT_NAME="Men of War: Red Tide"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2668
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Digitalmindsoft" "http://www.gog.com/game/$GOGID" "Robin Karlsson" $PREFIX
 
POL_Call POL_GoG_setup "$GOGID"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install "/nogui"
Set_OS winxp
POL_Call POL_Install_d3dx9_36
 
POL_Shortcut "redtide.exe" "$SHORTCUT_NAME" "" "" "Game;"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYcpAAKCRDlMfrJqhPK
RzDqAJ9CPyTmdjnTzt9rDh7Y0eXiBGc1IwCgl9oso754bMrqMR3ERF8BZBiWJQE=
=UNYk
-----END PGP SIGNATURE-----
