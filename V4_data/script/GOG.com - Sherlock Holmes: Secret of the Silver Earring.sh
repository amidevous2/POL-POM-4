#!/bin/bash
# Date : (2012-11-18 14-37)
# Last revision : 
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-11-18 14-37)
#   Initial script.
# [Pierre Etchemaite] (2014-06-15 19-11)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)
 
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sherlock_holmes_secret_of_the_silver_earring"
PREFIX="SherlockHolmesSOTSE_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Sherlock Holmes: Secret of the Silver Earring"
SHORTCUT_NAME="Sherlock Holmes: Secret of the Silver Earring"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1471
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Frogwares" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e15e72f7021bc85f511dbcd87178d7ef"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "game.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Sherlock Holmes - Secret of the Silver Earring/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Sherlock Holmes - Secret of the Silver Earring/" || exit 1

TITLE="$TITLE"
POL_Wine setup.exe
exit 0
_EOF_

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCYEQAKCRDlMfrJqhPK
R+t2AJ4sHYYWYK5t1sSYev2Ei9qbrlplggCeI7FL1UQjWGTpmGau87ExURsxH3U=
=+oOz
-----END PGP SIGNATURE-----
