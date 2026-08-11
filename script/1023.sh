#!/bin/bash
# Date : (2011-12-18 01-01)
# Last revision : see changelog
# Wine version used : 1.5.1, 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-03-31)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2014-06-09 15-10
#   script for GOG v2 ?.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.2 -> 2.22


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dungeon_keeper_2"
PREFIX="DungeonKeeper2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Dungeon Keeper 2"
SHORTCUT_NAME="Dungeon Keeper II"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1023
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "92d04f84dd870d9624cd18449d3622a5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

# DKII-DX.EXE seems to have timing issues, stick to DKII.EXE
POL_Shortcut "DKII.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Dungeon Keeper 2/manual.pdf"
# C:\GOG Games\Dungeon Keeper 2\reference_card.pdf
# C:\GOG Games\Dungeon Keeper 2\ReadMe.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Dungeon Keeper 2/" || exit 1

TITLE="$TITLE"

POL_Wine "DKII_SOFT.EXE"

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwldQAKCRDlMfrJqhPK
Rx9kAJ46fZMyUc21Bu+IVhADvV0Pj+Y/4ACeNxDm+oa3Yv6zKaLdOEye8IbYyiM=
=LBpX
-----END PGP SIGNATURE-----
