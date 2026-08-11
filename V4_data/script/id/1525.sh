#!/bin/bash
# Date : (2012-12-31 21-20)
# Last revision : (2014-06-10 20-41)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="spycraft_the_great_game"
PREFIX="Spycraft_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Spycraft: The Great Game"
SHORTCUT_NAME="Spycraft: The Great Game"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1525
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a24649fe50f528914fe7a00aee93e0d8"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=auto
mixer_rate=44100
mixer_blocksize=4096
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100
gus_gus=false
render_frameskip=1
_EOFCFG_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
REM mount C . -freesize 1024
mount D "$GOGROOT/SpyCraft/DATA/" -t cdrom
_EOFBAT_

POL_Shortcut "SPYDOS.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOXVmIACgkQ5TH6yaoTykclrACfTVQDHRAf2lPwS/fPD7tjBWKH
nHUAoJMYw9FL/Sn7nvlJMIkPBEEl/izd
=IF1L
-----END PGP SIGNATURE-----
