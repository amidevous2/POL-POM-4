#!/bin/bash
# Date : (2014-04-28 11-05)
# Last revision : (2014-04-28 11-05)
# Wine version used : 1.6.2-dos_support_0.6
# Distribution used to test : Archlinux
# Author : MindLikeWater, mlw dot play at pi dot xelpara dot de
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_1_2_3"
PREFIX="Ultima123_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Ultima 1, 2, 3"
DEVELOPER="Origin Systems / Electronic Arts"
INSTALL_FILE_HASH="4c3c6ed8842be74d98035573bbfdd3cf"
INSTALL_DIR="Ultima Trilogy"
GAME_DIR1="ULTIMA1"
GAME_DIR2="ULTIMA2"
GAME_DIR3="ULTIMA3"
EXEC1="ULTIMA.EXE"
EXEC2="ULTIMAII.EXE"
EXEC3="ULTIMA.COM"
MANUAL1="Ultima_1_manual.pdf"
MANUAL2="Ultima_2_manual.pdf"
MANUAL3="Ultima_3_manual.pdf"
SHORTCUT_NAME1="Ultima 1"
SHORTCUT_NAME2="Ultima 2: Revenge of the Enchantress"
SHORTCUT_NAME3="Ultima 3: Exodus"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2019
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "http://www.gog.com/gamecard/$GOGID" "MindLikeWater" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "$INSTALL_FILE_HASH"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=simple
cpu_cputype=386_slow
cpu_cycles=500
render_aspect=true
render_frameskip=1
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
_EOFCFG_

POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR1/$EXEC1" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR1/$MANUAL1"

POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR2/$EXEC2" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR2/$MANUAL2"

POL_Shortcut "GOG Games/$INSTALL_DIR/$GAME_DIR3/$EXEC3" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/$INSTALL_DIR/$GAME_DIR3/$MANUAL3"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNiXDsACgkQ5TH6yaoTyke/DgCgsy4aaCf2HpgnZkLIyVe1/QN/
eu0AoIk/KUAQbXq2cRON7IXJy9RnjXEB
=lFgZ
-----END PGP SIGNATURE-----
