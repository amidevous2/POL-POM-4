#!/bin/bash
# Date : (2012-04-25 19-32)
# Last revision : (2013-05-19 12-54)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="earthworm_jim_1_2"
PREFIX="EarthwormJim_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Earthworm Jim 1 and 2"
SHORTCUT_NAME1="Earthworm Jim"
SHORTCUT_NAME2="Earthworm Jim 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1146
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Shiny Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c8bac890508cdb4300746aa4e73fec87"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
render_frameskip=1
cpu_core=auto
cpu_cputype=auto
cpu_cycles=auto
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
dos_keyboardlayout=auto
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/EWJ1.BAT"
@ECHO OFF
mount A "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim/"
imgmount B "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim/EWJ1.inst" -t iso -fs fat
A:
EWJ1.EXE 320x224
exit
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/EWJ2.BAT"
@ECHO OFF
mount A "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim 2/"
imgmount B "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim 2/EWJ2.inst" -t iso -fs fat
A:
EWJ2.EXE
exit
_EOFBAT_

POL_Shortcut "EWJ1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim/readme.txt"
# C:\GOG Games\Earthworm Jim 1 and 2\Earthworm Jim\WORM0.HLP

POL_Shortcut "EWJ2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Earthworm Jim 1 and 2/Earthworm Jim 2/readme.txt"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlP4nqQACgkQ5TH6yaoTyke6MgCfQ7xSbKPXyDZH8Y01/I/xxVW3
BLUAoJ3i3O/AxrDCTuDKptFKG5jkptnY
=aqeV
-----END PGP SIGNATURE-----
