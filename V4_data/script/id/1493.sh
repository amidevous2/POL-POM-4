#!/bin/bash
# Date : (2012-11-30 20-18)
# Last revision : (2013-05-25 10-37)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="wing_commander_1_2"
PREFIX="WingCommander_1_2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Wing Commander 1 and 2"
SHORTCUT_NAME1="Wing Commander"
SHORTCUT_NAME11="Wing Commander - The Secret Missions 2: Crusade"
SHORTCUT_NAME2="Wing Commander II"
SHORTCUT_NAME21="Wing Commander II - Special Operations 1"
SHORTCUT_NAME22="Wing Commander II - Special Operations 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1493
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "de1c1c40406a83b7d910e964044208b1"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=4000
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=20
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
gus_gus=false
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC/WC.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=4000"
loadfix -1 wc
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC/WCSM2.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=4000"
loadfix -1 sm2
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC2/WC2.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
loadfix -32 wc2
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC2/WC2SO1.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
loadfix -32 so1
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC2/WC2SO2.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
loadfix -32 so2
EXIT
_EOFBAT_

POL_Shortcut "WC.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC/manual.pdf"
# C:\GOG Games\Wing Commander 1 and 2\WC\Ships Blueprints.pdf
# C:\GOG Games\Wing Commander 1 and 2\WC\The Secret Missions - Reference Card.pdf
POL_Shortcut "WCSM2.BAT" "$SHORTCUT_NAME11" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME11" "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC/The Secret Missions 2 - Reference Card.pdf"

POL_Shortcut "WC2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Wing Commander 1 and 2/WC2/manual.pdf"
POL_Shortcut "WC2SO1.BAT" "$SHORTCUT_NAME21" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut "WC2SO2.BAT" "$SHORTCUT_NAME22" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJa0ZIACgkQ5TH6yaoTykcdAACgni7hxLjfxCCe8UhyJtA3CCNi
1iQAmwX/VkcYtrg0/Zpi2VjL29klpJ85
=cX99
-----END PGP SIGNATURE-----
