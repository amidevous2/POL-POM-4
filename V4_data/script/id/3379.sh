#!/bin/bash
# Date : (2018-08-27 00-00)
# Last revision : (2018-08-27 00-00)
# Wine version used : 3.14
# Distribution used to test : Mint 17.3 Rosa
# Authors : Sergey Pavlov <qiwichupa@gmail.com>
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="xcom_terror_from_the_deep"
PREFIX="xcom_tftd_gog"
WORKING_WINE_VERSION="3.14"
 
TITLE="GOG.com - X-COM: Terror from the Deep"
SHORTCUT_NAME1="X-COM: Terror from the Deep"

POL_SetupWindow_Init
#POL_SetupWindow_SetID

POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "MicroProse Software Inc." "http://www.gog.com/gamecard/$GOGID" "Qiwichupa" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "e5ca29effaf5b17f4244a8e16be51d5b"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS winxp

POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"
POL_Call POL_GoG_install /nogui

GOGPATH="$GOGROOT/X-COM Terror from the Deep"

# Dosbox config
cat <<_EOFCFG_ > "$GOGPATH/dosbox_xcomtftd_playonlinux.conf"
[sdl]
fullscreen=false
_EOFCFG_

POL_Shortcut "DOSBOX.EXE" "$SHORTCUT_NAME1" "" " -c 'C:\GOG Games\X-COM Terror from the Deep\DOSBOX' -conf '..\dosbox_xcomtftd.conf' -conf '..\dosbox_xcomtftd_single.conf' -conf '..\dosbox_xcomtftd_playonlinux.conf' -noconsole" "Game;StrategyGame;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNUvEgAKCRDlMfrJqhPK
R7XiAKCLSMEg4DsTtjbUp4+bD2oYB8bxhQCffJLUCkihajOlDRJthRSLhQ6DdsE=
=1F/Z
-----END PGP SIGNATURE-----
