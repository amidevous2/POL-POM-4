#!/bin/bash
# Date : (2012-09-08 10-59)
# Last revision : 
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-08 10-59)
#   Initial script.
# [Pierre Etchemaite] (2013-07-10 13-41)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="total_annihilation_kingdoms"
PREFIX="TotalAnnihilationKingdoms_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Total Annihilation: Kingdoms"
SHORTCUT_NAME="Total Annihilation: Kingdoms"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1391
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cavedog Entertainment / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "206f4b8e9159414ee38ec609831907bb"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


Set_Desktop "On" "640" "480"
POL_Wine_X11Drv "GrabFullScreen" "Y"

# GoG work!
Set_OS winxp

# "SVGA"?
POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Kingdoms.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Total Annihilation Kingdoms/Manual.pdf"
# C:\GOG Games\Total Annihilation Kingdoms\ReadMe.txt
# C:\GOG Games\Total Annihilation Kingdoms\atlas\index.html
# C:\GOG Games\Total Annihilation Kingdoms\readme.htm
# C:\GOG Games\Total Annihilation Kingdoms\Cartographer.exe
# C:\GOG Games\Total Annihilation Kingdoms\nglide_config.exe

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "\$WINEPREFIX/drive_c/GOG Games/Total Annihilation Kingdoms/" || exit 1
TITLE="$TITLE"
POL_Wine ChooseRenderer.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxJJgAKCRDlMfrJqhPK
R6i0AKCTTd04CLrP2up+ghORJxgfXoI7OQCgla3hIkpSqfIDBktdBucEu+iLglg=
=CmwJ
-----END PGP SIGNATURE-----
