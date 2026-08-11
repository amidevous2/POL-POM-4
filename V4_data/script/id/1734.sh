#!/bin/bash
# Date : (2013-06-09 22-00)
# Last revision : (2013-06-09 22-00)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Fedora 17
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="sensible_world_of_soccer_9697"
PREFIX="SWoS_9697_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"
 
TITLE="GOG.com - Sensible World of Soccer 96-97"
SHORTCUT_NAME="Sensible World of Soccer 96-97"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1734
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Sensible Software / Codemasters" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "906834ea1f8f9d811d91588bf7917d8f"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
GOGPATH="$GOGROOT/Sensible World of Soccer 96-97"
 
# Dosbox config
cat <<_EOFCFG_ > "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_fullresolution=original
sdl_output=direct3d
sdl_mapperfile=mapper-SVN.map
dosbox_vmemsize=4
render_scaler=hardware2x
cpu_cycleup=10
cpu_cycledown=20
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=20
sblaster_oplrate=44100
speaker_pcrate=44100
speaker_disney=false
innova_innova=false
gus_gus=false
_EOFCFG_
 
# Language selection
POL_SetupWindow_menu "$(eval_gettext 'What is your preferred language?')" "$(eval_gettext 'Language')" "English~French~German~Italian" "~"
 
# Batch launcher
cat <<_EOFBAT_ > "$GOGPATH/swos9697.bat"
@echo off
cd C:\GOGGAM~1\SENSIB~1
imgmount D "SWOS97.DAT" -t iso -fs iso
${APP_ANSWER}.exe
exit
_EOFBAT_
 
POL_Shortcut "swos9697.bat" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Sensible World of Soccer 96-97 - Manual.pdf"
 
POL_SetupWindow_Close
 
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlG0nU8ACgkQ5TH6yaoTykfGCQCgpc+Vp7qhMVSWjyQsKDidO2u5
mPIAoJOacHMyygmatY0EXW3pvFLYKHcB
=L4mj
-----END PGP SIGNATURE-----
