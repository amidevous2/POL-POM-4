#!/bin/bash
# Date : (2013-05-27 21-25)
# Last revision : (2014-07-07 23-57)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="quest_for_glory"
PREFIX="QuestForGlory_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Quest for Glory 1-5"
SHORTCUT_NAME1E="Quest for Glory 1 (EGA)"
SHORTCUT_NAME1V="Quest for Glory 1 (VGA remake)"
SHORTCUT_NAME2="Quest for Glory 2"
SHORTCUT_NAME3="Quest for Glory 3"
SHORTCUT_NAME4="Quest for Glory 4"
SHORTCUT_NAME5="Quest for Glory 5"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1725
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "49f6e86f2afe774f685e4aa7724d0849"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# Problem with shortizing subdirectories side-by-side :(
cd "$GOGROOT/Quest for Glory Pack" || POL_Debug_Fatal "Could not find game directory"
QFG1E="QFG_1E"
mv "Quest for Glory 1 EGA" "$QFG1E" || POL_Debug_Fatal "Game not installed in standard path?"
QFG1V="QFG_1V"
mv "Quest for Glory 1 VGA" "$QFG1V" || POL_Debug_Fatal "Game not installed in standard path?"
QFG2="QFG_2"
mv "Quest for Glory 2" "$QFG2" || POL_Debug_Fatal "Game not installed in standard path?"
QFG3="QFG_3"
mv "Quest for Glory 3" "$QFG3" || POL_Debug_Fatal "Game not installed in standard path?"
QFG4="QFG_4"
mv "Quest for Glory 4" "$QFG4" || POL_Debug_Fatal "Game not installed in standard path?"
QFG5="QFG_5"
mv "Quest for Glory 5" "$QFG5" || POL_Debug_Fatal "Game not installed in standard path?"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=normal
cpu_cputype=auto
cpu_cycles='fixed 10000'
mixer_rate=22050
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
sblaster_oplrate=22050
gus_gus=false
ipx_ipx=false
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "GOG Games/Quest for Glory Pack/$QFG1E/SCIV.EXE" "$SHORTCUT_NAME1E" "$SHORTCUT_NAME1E.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1E" "$GOGROOT/Quest for Glory Pack/$QFG1E/Quest for Glory 1 - manual.pdf"

POL_Shortcut "SCIDHUV.EXE" "$SHORTCUT_NAME1V" "$SHORTCUT_NAME1V.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1V" "$GOGROOT/Quest for Glory Pack/$QFG1V/Quest for Glory 1 - manual.pdf"

POL_Shortcut "GOG Games/Quest for Glory Pack/$QFG2/SCIV.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Quest for Glory Pack/$QFG2/Quest for Glory 2 - manual.pdf"

POL_Shortcut "GOG Games/Quest for Glory Pack/$QFG3/SIERRA.EXE" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$GOGROOT/Quest for Glory Pack/$QFG3/Quest for Glory 3 - manual.pdf"

POL_Shortcut "GOG Games/Quest for Glory Pack/$QFG4/SIERRA.EXE" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME4" "$GOGROOT/Quest for Glory Pack/$QFG4/Quest for Glory 4 - manual.pdf"

POL_Shortcut "QfG5.exe" "$SHORTCUT_NAME5" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME5.png"
POL_Shortcut_Document "$SHORTCUT_NAME5" "$GOGROOT/Quest for Glory Pack/$QFG5/Quest for Glory 5 - manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO912wACgkQ5TH6yaoTykftNACdGqRDcwtj6Mi59bKYAtS2JC8T
jAIAn1Qv7Gd6C1amMzOUQntpIOCLxfjs
=Fy2R
-----END PGP SIGNATURE-----
