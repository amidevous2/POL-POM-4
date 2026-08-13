#!/bin/bash
# Date : (2012-07-12 21-15)
# Last revision : (2014-07-14 21-22)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="populous_2"
PREFIX="Populous2_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Populous 2"
SHORTCUT_NAME="Populous 2: Trials of The Olympian Gods"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1312
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "4f3b46cbadcd44821c212d96ef02cec5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GOG.com's cycles=20000 is too high
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=7500
render_aspect=true
mixer_blocksize=1024
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# Original lacks the necessary "@ECHO OFF" line
cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Populous 2/GO.BAT"
@ECHO OFF
Intro
Pop2 /ss /h %1 %2
EXIT
_EOFBAT_

POL_Shortcut "GO.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Populous 2/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPEPuMACgkQ5TH6yaoTykeZfgCfX4bH7wjo55xedvIObGwAIE9m
Q6UAn1syMttQIPsnDC3uCikgdf6VcIMd
=23P/
-----END PGP SIGNATURE-----
