#!/bin/bash
# Date : (2013-03-17 21-44)
# Last revision : (2014-08-25 23-12)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="carmageddon_max_pack"
PREFIX="Carmageddon_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Carmageddon Max Pack"
SHORTCUT_NAME1="Carmageddon"
SHORTCUT_NAME2="Carmageddon: Car Splat"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1627
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Stainless Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "8591b46a7b275f60051856bc5ca2818f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
render_aspect=false
render_frameskip=0
dosbox_memsize=63
cpu_core=dynamic
cpu_cputype=auto
cpu_cycles=max
#mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
#sblaster_oplrate=44100
gus_gus=false
render_scaler=normal2x
_EOFCFG_

cat <<_EOFBAT_ > "$GOGROOT/Carmageddon/CARMA/CARMA.BAT"
@ECHO OFF
imgmount D "GAME.DAT" -t cdrom -fs iso
VOODO2C.EXE -novoodoo
EXIT
_EOFBAT_

cat <<_EOFBAT_ > "$GOGROOT/Carmageddon/CARSPLAT/CARSPLAT.BAT"
@ECHO OFF
imgmount D "SPLAT.DAT" -t cdrom -fs iso
VOODO2C.EXE -novoodoo
EXIT
_EOFBAT_

POL_Shortcut "CARMA.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"

POL_Shortcut "CARSPLAT.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlP7r60ACgkQ5TH6yaoTykeWZwCcCLD+/wC1VttF0CL+W48tDHEm
ep8AnjghXkrcAUptdNUwRsKI/PwMMyFi
=W04V
-----END PGP SIGNATURE-----
