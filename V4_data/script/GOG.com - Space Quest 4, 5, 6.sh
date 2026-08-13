#!/bin/bash
# Date : (2012-05-18 20-22)
# Last revision : (2014-06-14 23-48)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="space_quest_4_5_6"
PREFIX="SpaceQuest456_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Space Quest 4, 5, 6"
SHORTCUT_NAME1="Space Quest 4: Roger Wilco and The Time Rippers"
SHORTCUT_NAME2="Space Quest 5: Roger Wilco - The Next Mutation"
SHORTCUT_NAME3="Space Quest 6: Roger Wilco in The Spinal Frontier"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1212
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0df532306b7979f72daaa35d7f8bb89e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$WINEPREFIX/drive_c/GOG Games/Space Quest 4-5-6" || POL_Debug_Fatal "Game not installed in standard path?"
# Problem with shortizing "Space Quest 4", "Space Quest 5" and "Space Quest 6" subdirectories side-by-side :(
SPACEQUEST4="SQ4"
SPACEQUEST5="SQ5"
SPACEQUEST6="SQ6"
mv "Space Quest 4" "$SPACEQUEST4"
mv "Space Quest 5" "$SPACEQUEST5"
mv "Space Quest 6" "$SPACEQUEST6"

POL_SetupWindow_VMS "1"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=simple
cpu_cputype=386_slow
cpu_cycles="auto 5000"
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
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"


POL_Shortcut "GOG Games/Space Quest 4-5-6/$SPACEQUEST4/SIERRA.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Space Quest 4-5-6/manual.pdf"
# C:\GOG Games\Space Quest 4-5-6\readme.txt
# C:\GOG Games\Space Quest 4-5-6\Customer_support.htm

POL_Shortcut "GOG Games/Space Quest 4-5-6/$SPACEQUEST5/SIERRA.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Space Quest 4-5-6/manual.pdf"

POL_Shortcut "GOG Games/Space Quest 4-5-6/$SPACEQUEST6/SIERRA.EXE" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "-o resource.cfg" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Space Quest 4-5-6/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOcx7EACgkQ5TH6yaoTykdcegCdHTUNtrcIHD0/GHkpQw5Pd04d
QLMAoJgpIgmJljnJy9T/YiTbKRLNW1kJ
=BJeK
-----END PGP SIGNATURE-----
