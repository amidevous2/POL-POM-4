#!/bin/bash
# Date : (2013-07-28 11-12)
# Last revision : (2014-03-10 21-37)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ishar_compilation"
PREFIX="IsharCompilation_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Ishar Compilation"
SHORTCUT_NAME1="Ishar - Crystals of Arborea"
SHORTCUT_NAME2="Ishar 1 - Legend of the Fortress"
SHORTCUT_NAME3="Ishar 2 - Messengers of Doom"
SHORTCUT_NAME4="Ishar 3 - The Seven Gates of Infinity"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1790
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Silmaris / DotEmu" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "cbec7f58ac1b7699196f1b458a1e03fe"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_type=auto
cpu_cycles=7000
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_sbtype=sb1
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=true
gus_gusrate=22050
gus_gusbase=240
gus_irq1=5
gus_irq2=5
gus_dma1=3
gus_dma2=3
ipx_ipx=false
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$GOGROOT/Ishar Compilation/Crystals of Arborea/I0.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=max"
CONFIG -set "sblaster sbtype=sbpro1"
rem CONFIG -set "sblaster dma=0"
start.exe
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$GOGROOT/Ishar Compilation/Ishar 3/I3.BAT"
@ECHO OFF
CONFIG -set "sblaster sbtype=sb16"
CONFIG -set "sblaster irq=7"
start.exe start.stp
EXIT
_EOFBAT_

POL_Shortcut "I0.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"

POL_Shortcut "GOG Games/Ishar Compilation/Ishar 1/start.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Ishar Compilation/Ishar 1/manual.pdf"
# C:\GOG Games\Ishar Compilation\Ishar 1\solution.txt

POL_Shortcut "GOG Games/Ishar Compilation/Ishar 2/start.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$GOGROOT/Ishar Compilation/Ishar 2/manual.pdf"
# C:\GOG Games\Ishar Compilation\Ishar 2\solution.txt
# C:\GOG Games\Ishar Compilation\Ishar 2\map1.gif
# C:\GOG Games\Ishar Compilation\Ishar 2\map2.gif

POL_Shortcut "I3.BAT" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME4" "$GOGROOT/Ishar Compilation/Ishar 3/manual.pdf"
# C:\GOG Games\Ishar Compilation\Ishar 3\solution.txt
# C:\GOG Games\Ishar Compilation\Ishar 3\dungeons_in_future.gif
# C:\GOG Games\Ishar Compilation\Ishar 3\dungeons_in_past.gif
# C:\GOG Games\Ishar Compilation\Ishar 3\machine_of_time.gif

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMeM0gACgkQ5TH6yaoTykd5sgCeKGyxCsGUsdW/cGG/yOT/b2Uq
DJ8An1nDdKkCagKcR8jWj4Pn2aDGKiHC
=7su6
-----END PGP SIGNATURE-----
