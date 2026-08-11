#!/bin/bash
# Date : (2012-10-19 18-04)
# Last revision : (2014-06-03 22-06)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="pirates_gold_plus"
PREFIX="PiratesPack_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Pirates Pack"
SHORTCUT_NAME1='Pirates!'
SHORTCUT_NAME2='Pirates! Gold'

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1441
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "MicroProse / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "cd0d2f4b084b0fc9628a33237f6d04df"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Pirate! Gold expects itself in C:\, at least some parts
mv "$WINEPREFIX/drive_c/GOG Games/Pirates Pack/Pirates! Gold"/* "$WINEPREFIX/drive_c/"

# GOG's cpu_cycles=auto (aka 3000) is a bit low
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=30
cpu_core=normal
cpu_cputype=auto
cpu_cycles=5000
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
render_aspect=true
render_frameskip=1
_EOFCFG_
# I prefer advmame2x over hq2x for Pirates! game - more "round" letters maybe
[ "$POL_OS" = "Linux" ] && echo "render_scaler=advmame2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Pirates Pack/Pirates!/P1.BAT"
@ECHO OFF
LOADFIX
PIR.EXE
EXIT
_EOFBAT_

PGLANG='' # english
[ "$POL_LANG" == "fr" ] && PGLANG=F
[ "$POL_LANG" == "de" ] && PGLANG=G

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/P2.BAT"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/DATA.DAT" -t iso
D:
rem CALL PIRATESG.BAT

cd piratesg.cd
lh cdpatch %1
piratesg.exe $PGLANG %1 %2 %3 %4 %5
cdpatch x
cd ..
EXIT
_EOFBAT_

POL_Shortcut "P1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Pirates Pack/Pirates!/codes.pdf"
# C:\GOG Games\Pirates Pack\Pirates!\manual.pdf

POL_Shortcut "P2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/flags.pdf"
# C:\GOG Games\Pirates Pack\Pirates! Gold\manual.pdf

POL_SetupWindow_message "$(eval_gettext 'The codes needed to start a new game can be found in the\ndocumentation;\nRight-click the game icon, "Read the manual".')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOOMWcACgkQ5TH6yaoTyke9ZACggO06GUxwu5fHomhJFzPrQNFl
SkEAoJ4vaeO8r3Ukj0kXHLeaGmxP8omo
=RCBs
-----END PGP SIGNATURE-----
