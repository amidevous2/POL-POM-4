#!/bin/bash
# Date : (2014-03-10 22-22)
# Last revision : (2014-03-11 00-59)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Archlinux
# Author : MindLikeWater, mlw dot play at pi dot xelpara dot de
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Note: This script is based on the install script for "Space Quest 4, 5, 6" by Pierre Etchemaite

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="space_quest_1_2_3"
PREFIX="SpaceQuest123_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Space Quest 1, 2, 3"
SHORTCUT_NAME1="Space Quest 1: The Sarien Encounter"
SHORTCUT_NAME2="Space Quest 2: Vohaul's Revenge"
SHORTCUT_NAME3="Space Quest 3: The Pirates of Pestulon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1972
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Chris Top" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "80595875142fd25a6d088aa42809d193"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$WINEPREFIX/drive_c/GOG Games/Space Quest 1-2-3" || POL_Debug_Fatal "Game not installed in standard path?"

SPACEQUEST1="SQ1"
SPACEQUEST2="SQ2"
SPACEQUEST3="SQ3"
mv "Space Quest 1" "$SPACEQUEST1"
mv "Space Quest 2" "$SPACEQUEST2"
mv "Space Quest 3" "$SPACEQUEST3"

POL_SetupWindow_VMS "1"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=simple
cpu_cputype=386_slow
cpu_cycles=auto
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

POL_Shortcut "GOG Games/Space Quest 1-2-3/$SPACEQUEST1/SQ.COM" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Space Quest 1-2-3/$SPACEQUEST1/Manual.pdf"

POL_Shortcut "GOG Games/Space Quest 1-2-3/$SPACEQUEST2/SIERRA.COM" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Space Quest 1-2-3/$SPACEQUEST2/Manual.pdf"

POL_Shortcut "GOG Games/Space Quest 1-2-3/$SPACEQUEST3/SIERRA.COM" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Space Quest 1-2-3/$SPACEQUEST3/Manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMfUrsACgkQ5TH6yaoTykdKBQCgi99auFSWu1cnkKn7EuzqI5U8
bS4An3383eBfo9aHMHkumoKtwM6ar89S
=62tI
-----END PGP SIGNATURE-----
