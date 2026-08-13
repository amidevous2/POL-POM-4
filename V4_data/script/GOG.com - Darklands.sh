#!/bin/bash
# Date : (2012-12-10 10-53)
# Last revision : (2013-11-03 12-04)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="darklands"
PREFIX="Darklands_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Darklands"
SHORTCUT_NAME="Darklands"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1512
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "MPS Labs / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e5f81838016a1c3512c3249799dc71ba"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=10000
mixer_rate=44100
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
sblaster_oplrate=44100
gus_gus=false
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# SoundBlaster-only configuration, see README.TXT
cd "$GOGROOT/Darklands/DARKLAND" || POL_Debug_Fatal "Could not find game directory"
cp PSOUND.DC PSOUND.DLC
cp PSOUND.DB PSOUND.DLB
cp ASOUND.DC ASOUND.DLC
cp ASOUND.DB ASOUND.DLB

POL_Shortcut "DARKLAND.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Darklands/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJ2kWQACgkQ5TH6yaoTykeP5QCeP35V70l9zW8TIcnXzkcCv/we
CLEAniuGuWYe8z9bnWNorWeCL8rrhgV2
=wnAb
-----END PGP SIGNATURE-----
