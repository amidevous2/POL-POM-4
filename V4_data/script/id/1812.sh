#!/bin/bash
# Date : (2013-08-30 22-00)
# Last revision : (2013-08-30 22-00)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Fedora 19
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="slipstream_5000"
PREFIX="Slipstream5000_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"
 
TITLE="GOG.com - Slipstream 5000"
SHORTCUT_NAME="Slipstream 5000"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1812
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Software Refinery / Blue Moon Red Owl" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "66964f539a9977f39d365460fd9f4a69"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
GOGPATH="$GOGROOT/Slipstream 5000"
 
 
# Dosbox config
cat <<_EOFCFG_ > "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_fullresolution=original
sdl_output=overlay
dosbox_machine=vesa_oldvbe
cpu_cputype=486_slow
cpu_cycles=80000
cpu_cycleup=5000
cpu_cycledown=5000
mixer_prebuffer=80
gus_gus=false
_EOFCFG_
 
 
# Batch launcher
cat <<_EOFBAT_ > "$GOGPATH/RUN.BAT"
@echo off
MOUNT G "$GOGPATH"
G:
REM logo.exe
playgdv intro.gdv
slipstrm 5000
exit
_EOFBAT_
 
# Configure install path with G: drive instead of C:
cp "$GOGPATH/CONFIG.INI" "$GOGPATH/CONFIG.BAK"
sed -e 's/^SourcePath=C:/SourcePath=G:/' "$GOGPATH/CONFIG.BAK" > "$GOGPATH/CONFIG.INI"
 
 
POL_Shortcut "RUN.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;SportsGame"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Manual.PDF"
 
POL_SetupWindow_Close
 
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlIjf20ACgkQ5TH6yaoTykdvGQCfW64t1MDu1uEetAkcUwfaQK6N
QmkAn3bztupAiC9TvNW+rXP2JzPFvIJ+
=GqfO
-----END PGP SIGNATURE-----
