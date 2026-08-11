#!/bin/bash
# Date : (2012-05-17 20-12)
# Last revision : (2014-04-20 15-43)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="master_of_orion_1_2"
PREFIX="MasterOfOrion12_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Master of Orion 1 and 2"
SHORTCUT_NAME1="Master of Orion I"
SHORTCUT_NAME2="Master of Orion II"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1207
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "SimTex / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "664169a970a239df40328c1500fc47f5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$GOGROOT/Master of Orion 1 and 2" || POL_Debug_Fatal "Game not installed in standard path?"

# Problem with shortizing "Master of Orion" and "Master of Orion 2" subdirectories side-by-side :(
ORION1="MOO1"
ORION2="MOO2"
mv "Master of Orion" "$ORION1"
mv "Master of Orion 2" "$ORION2"

# "640x480 256 colors"
POL_SetupWindow_VMS "2"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
sdl_autolock=false
dosbox_memsize=16
render_frameskip=1
render_aspect=true
cpu_core=auto
cpu_type=auto
cpu_cycles="auto 5000"
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"


POL_Shortcut "ORION.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Master of Orion 1 and 2/$ORION1/manual.pdf"
# C:\GOG Games\Master of Orion 1 and 2\Master of Orion 1\README.TXT
# C:\GOG Games\Master of Orion 1 and 2\Master of Orion 1\ReferenceCard.pdf

POL_Shortcut "Orion2.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Master of Orion 1 and 2/$ORION2/Manual.PDF"
# C:\GOG Games\Master of Orion 1 and 2\Master of Orion 2\README.TXT

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNT1GUACgkQ5TH6yaoTykdnNQCgoJ6/jpPkRTdl7asgZPaRdmRU
PtkAn3V6RUHaCZVPyYbPymPnAVhCohJe
=UEgG
-----END PGP SIGNATURE-----
