#!/bin/bash
# Date : (2014-03-11 23-14)
# Last revision : (2014-03-11 23-14)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Archlinux
# Author : MindLikeWater, mlw dot play at pi dot xelpara dot de
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

######################
#
#  Parameters
#
######################

# PlayOnLinux

TITLE="GOG.com - Personal Nightmare"
PREFIX="PersonalNightmare_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"
POL_ID=1973

# GOG

GOG_ID="personal_nightmare"
GOG_MD5="fa7e91869a5ab191af892cfb5b169a43"

# Setup window

COMPANY="Horrorsoft / Adventure Soft"
PUBLISHER_HOMEPAGE="http://www.gog.com/gamecard/$GOG_ID"
SCRIPT_AUTHOR="MindLikeWater"

# Installation details

SHORTCUT_NAME="Personal Nightmare"
SHORTCUT_CATEGORY="Game;AdventureGame;"
INSTALL_DIR="GOG Games/Personal Nightmare"
EXECUTABLE="Test.exe"   # Yes, that is the name they used...
MANUAL="manual.pdf"

######################
#
#  Installation
#
######################

POL_GetSetupImages \
   "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" \
   "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" \
   "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID $POL_ID
POL_Debug_Init

POL_SetupWindow_presentation \
   "$TITLE" \
   "$COMPANY" \
   "$PUBLISHER_HOMEPAGE" \
   "$SCRIPT_AUTHOR" \
   "$PREFIX"

POL_Call POL_GoG_setup "$GOG_ID" "$GOG_MD5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

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

POL_Shortcut \
   "$INSTALL_DIR/$EXECUTABLE" \
   "$SHORTCUT_NAME" \
   "$SHORTCUT_NAME.png" \
   "" \
   "$SHORTCUT_CATEGORY"

POL_Shortcut_InsertBeforeWine \
   "$SHORTCUT_NAME" \
   "export SDL_VIDEO_X11_DGAMOUSE=0"

POL_Shortcut_Document \
   "$SHORTCUT_NAME" \
   "$WINEPREFIX/drive_c/$INSTALL_DIR/$MANUAL"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMg1w4ACgkQ5TH6yaoTykc3+gCfWpH7/MAD9AQBjinFktbTNtO1
jnUAn2gihoA0Xcs6xn5pO9l5nBrV/SZx
=4woc
-----END PGP SIGNATURE-----
