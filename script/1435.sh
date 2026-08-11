#!/bin/bash
# Date : (2012-05-01 00-01)
# Last revision : 
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-01 00-01)
#   Initial script.
# [Pierre Etchemaite] (2014-02-25 21-26)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="runaway_a_road_adventure"
PREFIX="Runaway_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Runaway: A Road Adventure"
SHORTCUT_NAME="Runaway: A Road Adventure"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1435
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pendulo Studio / Focus Home Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2faf90aedca00fc744ddf84d63d0ea5b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Expect an dialog box about missing WMP 5.2 at the very end of installation
POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# "1024x768 16bits color"
POL_SetupWindow_VMS "2"

# Without this, some sounds (car trunk slam for example) are missing
POL_Call POL_Install_dsound

# Avoid a crash on first run
cat <<_EOFINI_ > "$WINEPREFIX/drive_c/windows/RUNAWAY.INI"
[GUIDS]
VIDEO={0,0,0,0,0,0,0,0,0,0,0}
_EOFINI_

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Runaway.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Runaway - A Road Adventure/manual.pdf"
# C:\GOG Games\Runaway - A Road Adventure\README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Runaway - A Road Adventure/" || exit 1

TITLE="$TITLE"

POL_Wine "Video Card Setup.exe"

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCfzQAKCRDlMfrJqhPK
RzaLAJ0Sb7Vdzz64nNlXcaWr+GpMcMRMIwCbBaLc98bPfQhPInvuAoNnihJe11U=
=+IWY
-----END PGP SIGNATURE-----
