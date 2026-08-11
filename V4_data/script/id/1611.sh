#!/bin/bash
# Date : (2013-03-07 20-17)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite]  (2013-03-07 20-17)
#   Initial script.
# [Pierre Etchemaite]  (2013-12-08 05-22)
#   ?
# [Dadu042] (2020-01-19 22:00)
#  Wine 1.6.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="1nsane"
PREFIX="1nsane_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - 1nsane"
SHORTCUT_NAME="1nsane"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1611
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Invictus Games / Codemasters" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6c508e40e2a25994cb3c93dc6f7d422f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# Intro video, not really necessary
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_amstream
POL_Call POL_Install_iv50

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Game.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/1nsane/MANUAL.PDF"
# C:\GOG Games\1nsane\Readme.chm

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/1nsane/" || exit 1
TITLE="$TITLE"

POL_Wine "Language Setup.exe"
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYXcQAKCRDlMfrJqhPK
RzkEAKCLe/q4KjWV9RT0mCgsoGKFL7VovQCgpRFRoliMmJLK8LgD8qquWHKpgtk=
=BpNn
-----END PGP SIGNATURE-----
