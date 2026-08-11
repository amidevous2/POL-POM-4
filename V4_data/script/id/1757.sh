#!/bin/bash
# Date : (2013-06-29 13-44)
# Last revision : (2013-09-16 23-26)
# Wine version used : 1.4.1
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="GOG.com - Fez"
GOGID="fez"
PREFIX="Fez_gog"
TITLE="GOG.com - Fez Patch"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1757
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Polytron Corporation" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

# Verify base game existence
if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update;nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

POL_Call POL_GoG_setup "$GOGID" --alternate "patch_${GOGID}_2.0.7.9" "1" --patch "5eb8e95d748efd0c61664a9daf64d3ef"

POL_Wine_SelectPrefix "$PREFIX"

POL_Call POL_GoG_install

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlI3hysACgkQ5TH6yaoTykfHIQCdG4lqF2Y+cRfaJpXJabHxO7AB
7S8AnA0aDH1X2lciQZ2PQZnume1Lglai
=b/5I
-----END PGP SIGNATURE-----
