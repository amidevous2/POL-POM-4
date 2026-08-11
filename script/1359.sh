#!/bin/bash
# Date : (2012-08-10 15-11)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable), Arch Linux
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Author : Kevin Becker khbecker@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-08-10 15-11)
#   Initial script.
# [Kevin Becker] (2014-09-03 20-14)
#   ?
# [Dadu042] (2020-01-05)
#   Wine "1.3.32-tlj2" (outdated) -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_longest_journey"
PREFIX="TheLongestJourney_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Longest Journey"
SHORTCUT_NAME="The Longest Journey"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1359
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Funcom" "http://www.gog.com/game/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7b97808b8a282af566a9bac4ee5aa790"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Game.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
# GPFs on exit, I know
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/The Longest Journey/manual.pdf"
# C:\Program Files\GOG.com\The Longest Journey\readme.txt

# Fix pink text bug
REGFILE="$POL_USER_ROOT/tmp/tlj.reg"
(echo "[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]"
echo "\"ClientSideAntiAliasWithRender\"=\"N\"") > "$REGFILE"
POL_Wine regedit "$REGFILE"
rm "$REGFILE"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/\$PROGRAMFILES/GOG.com/The Longest Journey/" || exit 1
TITLE="$TITLE"
POL_Wine configure.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhFNtQAKCRDlMfrJqhPK
R/qPAJ95MUPVYXwhG+RTFkdiTNnrxdEofwCfdYldFZmw8XZwHUUSVb1DirgEpnY=
=f0rS
-----END PGP SIGNATURE-----
