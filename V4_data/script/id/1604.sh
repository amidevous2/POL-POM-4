#!/bin/bash
# Date : (2013-03-02 17-04)
# Last revision : (2013-05-19 17-13)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="cannon_fodder"
PREFIX="CannonFodder_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Cannon Fodder"
SHORTCUT_NAME="Cannon Fodder"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1604
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sensible Software / Codemasters" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "02731242e9bc4f5ef0652beb09708b7e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
ipx_ipx=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$GOGROOT/Cannon Fodder/CANNON.BAT"
@ECHO OFF
INTRO.EXE
CF_ENG.EXE /f
EXIT
_EOFBAT_

POL_Shortcut "CANNON.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ArcadeGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Cannon Fodder/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGY8RwACgkQ5TH6yaoTykdURwCeNKYaTbcQbIJqwNP1K5KYS4mk
so0AoIwSE/PV+uZdbbneJoU3AOWPYoPF
=RbL0
-----END PGP SIGNATURE-----
