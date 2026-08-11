#!/bin/bash
# Date : (2012-05-10 12-39)
# Last revision : see changelog
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-10 12-39)
#   Initial script.
# [Pierre Etchemaite] (2014-04-12 21-06)
#   Script updated for GOG installer v2.
# [Dadu042] (2020-03-20 19:30)
#   Wine 1.5.15d -> 2.22
# [Dadu042] (2020-06-27 11:00) (tested with game v2.0.0.4)
#   Wine 2.22 -> 4.0.4 (fix the jerky scrolling that occured also with Wine 3.0.3 on AMD GPU Radeon).
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="sacred_gold"
PREFIX="Sacred_gog"
WORKING_WINE_VERSION="4.0.4"
 
TITLE="GOG.com - Sacred Gold"
SHORTCUT_NAME="Sacred Gold"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1177
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "ASCARON Entertainment / Strategy First" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
 
POL_Call POL_GoG_setup "$GOGID" "876c6c2eaa94e92a0ee6f1437013d6ca"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install "/nogui"
 
 
# Required for videos http://bugs.winehq.org/show_bug.cgi?id=16250
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_amstream
 
# GoG work!
Set_OS "winxp"
 
POL_SetupWindow_VMS "16"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
POL_Shortcut "Sacred.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Sacred Gold/Manual.pdf"
# C:\GOG Games\Sacred Gold\Readme.html
# C:\GOG Games\Sacred Gold\Map.pdf
# C:\GOG Games\Sacred Gold\Quickstart.pdf
 
# C:\GOG Games\Sacred Gold\GameServer.exe
 
POL_SetupWindow_Close
 
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"
 
POL_LoadVar_PROGRAMFILES
 
cd "$GOGROOT/Sacred Gold/" || exit 1
 
TITLE="$TITLE"
 
POL_SetupWindow_Init
 
POL_Wine --ignore-errors Config.exe
 
POL_SetupWindow_Close
exit 0
_EOF_
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXvcUigAKCRDlMfrJqhPK
R51gAJ97xGIYpeIrSXexZrSECsWaeivjoACfZAePwSG495g0kKkiSts2t1Re9p4=
=mt4L
-----END PGP SIGNATURE-----
