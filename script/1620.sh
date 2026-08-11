#!/bin/bash
# Date : (2013-03-13 20-29)
# Last revision : (2013-11-14 19-50)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="wing_commander_privateer"
PREFIX="WingCommanderPrivateer_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Wing Commander: Privateer"
SHORTCUT_NAME1="Wing Commander: Privateer"
SHORTCUT_NAME2="$SHORTCUT_NAME1 - Righteous Fire"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1620
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "53c77040cba69a642ec1302b5cf231b5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
render_aspect=true
render_frameskip=0
cpu_core=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=40
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
if [ "$POL_OS" = "Linux" ]; then
	# use pmidi -l or aconnect -o list to check your (emulated) midi device
	# 128:0 is just default software emulation port (usually Timidity)
	cat <<-'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
	render_scaler=hq2x
	midi_mididevice=alsa
	midi_midiconfig=128:0
	_EOFCFG_
fi
if [ "$POL_OS" = "Mac" ]; then
	cat <<-'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
	midi_mididevice=coreaudio
	_EOFCFG_
fi

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
imgmount d "$WINEPREFIX/drive_c/GOG Games/Wing Commander Privateer/GAME.GOG" -t iso -fs iso
_EOFBAT_

POL_Shortcut "PRIV.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Wing Commander Privateer/manual.pdf"
# C:\GOG Games\Wing Commander Privateer\reference_guide.pdf

POL_Shortcut "PRIV.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME1.png" "r" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Wing Commander Privateer/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKFImYACgkQ5TH6yaoTyke9aQCghFIgzitFrmb4K1SJY58i6Myy
diIAn0RYSe4jN7c98gvzN9t0JhDW3VbU
=mfok
-----END PGP SIGNATURE-----
