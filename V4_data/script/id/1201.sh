#!/bin/bash
# Date : (2012-05-16 20-31)
# Last revision : 
# Wine version used : 1.4.1, 1.5.4
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-16 20-31)
#   Initial script.
# [Pierre Etchemaite] (2013-11-03 11-03)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ufo_aftermath"
PREFIX="UfoAftermath_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - UFO: Aftermath"
SHORTCUT_NAME="UFO: Aftermath"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1201
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Altar Interactive / 1C Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6cfb5c1eb7c6e5e1882d9d31a2f9bf78"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "UFO.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/UFO Aftermath/manual.pdf"
# C:\GOG Games\UFO Aftermath\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/UFO Aftermath/" || exit 1

TITLE="$TITLE"

POL_Wine launcher.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxG1wAKCRDlMfrJqhPK
R3C6AJ4pRwdBcMLDe6jkAs715JAKTkFY+ACcDSXEzxEX1WW5QDM3HfWjtsT1bYY=
=xjag
-----END PGP SIGNATURE-----
