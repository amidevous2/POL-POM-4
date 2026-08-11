#!/bin/bash
# Date : (2012-06-24 21-47)
# Last revision : (2013-06-29 22-42)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="normality"
PREFIX="Normality_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Normality"
SHORTCUT_NAME="Normality"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1280
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Gremlin Interactive Ltd. / Funbox Media" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "54c2f59917e5f23e683b7d02604ab0a3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
render_aspect=true
render_frameskip=1
cpu_core=auto
cpu_cputype=auto
cpu_cycles=auto
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=120
sblaster_sbtype=sb1
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=44100
gus_gus=false
ipx_ipx=false
_EOFCFG_

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
rem mount C "." -freesize 1024
imgmount D "$GOGROOT/Normality/NORMAL.GOG" -t iso -fs iso
copy normal.bat maps\silly.das >NUL
del maps\*.das
_EOFAE_

POL_Shortcut "NORM.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Normality/Manual.pdf"
# C:\GOG Games\Normality\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHPSrEACgkQ5TH6yaoTykflTgCfZrSk6Nt1PdxqxHJGcmXIA6W3
m2oAn0jpu19iZ1E+sSyTmA8/fALvMQXQ
=Vtui
-----END PGP SIGNATURE-----
