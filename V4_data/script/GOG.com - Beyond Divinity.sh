#!/bin/bash
# Date : (2012-12-07 16-07)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-07 16-07)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2014-02-23 20-10)
#   Wine 1.4.1 -> 1.6.2
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.2 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="beyond_divinity"
PREFIX="BeyondDivinity_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Beyond Divinity"
SHORTCUT_NAME="Beyond Divinity"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1505
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Larian Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "855921665ea5357a7f445d550c0cbe84"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "div.exe" "$SHORTCUT_NAME" "" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Beyond Divinity/manual.pdf"
# C:\GOG Games\Beyond Divinity\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Beyond Divinity/" || exit 1
TITLE="$TITLE"

POL_Wine configtool.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwdNgAKCRDlMfrJqhPK
R/4kAJ4va+vANxZS+Y79zQjvlM2YZvlKkwCeIr/OgdkTTGN8ZQM0PaE5PQHliCQ=
=8aHL
-----END PGP SIGNATURE-----
