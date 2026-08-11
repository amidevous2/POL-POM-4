 #!/bin/bash
# Date : (2014-11-09 19-30)
# Wine version used : 
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2014-11-09 19-30)
#   Initial script.
# [Dadu042] (2020-04-09 19:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - The Blackwell Epiphany"
PREFIX="blackwell_epiphany"
WORKING_WINE_VERSION="3.0.3"
SHORTCUT_NAME="The Blackwell Epiphany"
GOGID="blackwell_epiphany_the"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Wadjet Eye Games" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "2b8f160c00c8de5ce316dbaa09bdb366"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"


POL_Call POL_GoG_install


POL_Wine_reboot

POL_Shortcut "epiphany.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo955QAKCRDlMfrJqhPK
R7IuAJ9sNlWdYW8NeEbZU/ryVyAEdFnZcwCgr7N5vmrK/IKQxpH3fIPC1hDrpwA=
=sz4X
-----END PGP SIGNATURE-----
