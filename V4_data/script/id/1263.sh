#!/bin/bash
# Date : (2011-12-14 23-58)
# Last revision : see changelog
# Wine version used : 1.5.5, 1.5.29
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-14 23-58)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2013-05-22 23-28)
#   ?: 1.5.5 -> 1.5.29
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.5.29 (outdated) -> 2.22
#
# KNOWN ISSUE (2011 ?):
# Tested up to Wine 1.3.35 without native DirectSound, and still looping sounds
# Same thing with 1.3.36
# Same thing with 1.5.0 (less often I feel)
#
#
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="beyond_good_and_evil"
PREFIX="BeyondGaE_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Beyond Good and Evil"
SHORTCUT_NAME="Beyond Good and Evil"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1263
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "8599aff06ba1ccd81f74ed16cb98a01f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# Can only get lots of looping sounds (2s loops) without native DirectSound
# (and emulated sound outputs?)
# Not so bad as it used to in 1.5.0?
# POL_Call POL_install_dsound

# GoG work!
Set_OS winxp

# Has problems when unconstrained
Set_Desktop "On" "1024" "768"

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BGE.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
# Fixes a problem with CPU management on modern computers (specially laptops):
# BGE doesn't handle variable frequency, so make sure they stay at top frequency
# with a background busy loop (other means are less portable and/or require root privileges)
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'taskset -pc 0 $$'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'nice -19 bash -c "while true; do let i=1; done" &'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'BUSYLOOP_PID=$!'
echo 'kill $BUSYLOOP_PID' >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Beyond Good and Evil/manual.pdf"
# C:/GOG Games/Beyond Good and Evil/readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Beyond Good and Evil/" || exit 1

TITLE="$TITLE"

POL_Wine "SettingsApplication.exe"

exit 0
_EOF_

# Run the configurator? Ok!
bash "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiweWwAKCRDlMfrJqhPK
R7KxAJ0ZoCG7Mb4VWXGw5YEdUO6hFv2r8gCgst+n1FtcjGrHVU4amhUMF2Q68OI=
=xPL4
-----END PGP SIGNATURE-----
