#!/bin/bash
# Date : (2013-02-19 21-20)
# Last revision : 
# Wine version used : 1.4.1, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-02-19 21-20)
#   Initial script.
# [Pierre Etchemaite] (2013-12-22 11-32)
#   ?
# [Dadu042] (2020-04-22 21:00).
#   Script updated for GOG's installer v2.
#   Wine 1.6.1 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)
#   POL_Install_d3dx9_36 -> 43

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="runaway_3_a_twist_of_fate"
PREFIX="Runaway3_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Runaway 3: A Twist of Fate"
SHORTCUT_NAME="Runaway 3: A Twist of Fate"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1586
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pendulo Studios / Focus Home Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 4 "787b978f339660e011b9880c23271b7a" "e3bf11359c116ad556167176ed6409ae" "6bef8aef010f35c6e239919b14db1daa" "b3cecbd2aa79d8d967081a47b5465344" "0dbe0511da0c1087f5172b3a3452257f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

POL_Call POL_Install_d3dx9_43

#POL_LoadVar_ScreenResolution
#cat <<_EOFCONF_ > "$GOGROOT/Runaway - A Twist Of Fate/ratof.config"
#Adapter = 0
#Width = $ScreenWidth
#Height = $ScreenHeight
#Format = 0
#RefreshRate = 0
#_EOFCONF_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "RATOF.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME.png"
#echo "xrandr -s 0" >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Runaway - A Twist Of Fate/manual.pdf"

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Runaway - A Twist Of Fate/" || exit 1
TITLE="$TITLE"

POL_Wine "RATOF-Config.exe"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCgZQAKCRDlMfrJqhPK
RyXOAJ95dtfHz38FIlYMHl+tFy9pBdn5ZgCfSH7jrd9jTSfsdZ1FneUFUjTCWAY=
=PewJ
-----END PGP SIGNATURE-----
