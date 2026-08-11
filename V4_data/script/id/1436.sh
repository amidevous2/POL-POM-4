#!/bin/bash
# Date : (2012-10-17 18-02)
# Last revision : (2014-05-10 11-21)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="torins_passage"
PREFIX="TorinsPassage_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Torins Passage"
SHORTCUT_NAME="Torin's Passage"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1436
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a7398abdb6964bf6a6446248f138d05e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


SCALER=normal2x
[ "$POL_OS" = "Linux" ] && SCALER=hq2x

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=dynamic
cpu_cputype=auto
cpu_cycles=max
render_frameskip=1
render_scaler=$SCALER
mixer_prebuffer=40
sblaster_type=sb16
sblaster_base=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050

speaker_pcspeaker=false
speaker_tandy=off
speaker_disney=false
joystick_joysticktype=none
midi_mpu401=none
gus_gus=false
_EOFCFG_

POL_Shortcut "SIERRAH.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Torin's Passage/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNt9yAACgkQ5TH6yaoTykcCEgCgpbbejgO8VVo1JeFQy6K3b8Ez
A0sAn0FwFJYbuJ5xvlC4CncUxzpy2Roz
=So2p
-----END PGP SIGNATURE-----
