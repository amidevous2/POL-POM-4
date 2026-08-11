#!/bin/bash
# Date : (2012-06-30 13-10)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-30 13-10)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2013-07-10 13-29)
#   ?
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="blackwell_bundle"
PREFIX="BlackwellBundle_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Blackwell Bundle"
SHORTCUT_NAME1="Blackwell 1: The Blackwell Legacy"
SHORTCUT_NAME2="Blackwell 2: Blackwell Unbound"
SHORTCUT_NAME3="Blackwell 3: Blackwell Convergence"
SHORTCUT_NAME4="Blackwell 4: Blackwell Deception"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left2.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1288
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Wadjet Eye Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ef717235021813125b4e1230ec35487f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "blackwell1.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut "Unbound.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut "Convergence.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"
POL_Shortcut "Deception.exe" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Blackwell Bundle/Episode 1 - The Blackwell Legacy/" || exit 1
TITLE="$TITLE"

POL_Wine winsetup.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME2"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Blackwell Bundle/Episode 2 - Blackwell Unbound/" || exit 1
TITLE="$TITLE"

POL_Wine winsetup.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME3"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Blackwell Bundle/Episode 3 - Blackwell Convergence/" || exit 1
TITLE="$TITLE"

POL_Wine winsetup.exe
exit 0
_EOF_

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME4"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Blackwell Bundle/Episode 4 - Blackwell Deception/" || exit 1
TITLE="$TITLE"

POL_Wine winsetup.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwiMgAKCRDlMfrJqhPK
RwaUAKCPoJx86ypbe4PT7nIKBcDAeYfaKQCgpjPt8Hak2an3GZtcmBculXGuxyk=
=S0uN
-----END PGP SIGNATURE-----
