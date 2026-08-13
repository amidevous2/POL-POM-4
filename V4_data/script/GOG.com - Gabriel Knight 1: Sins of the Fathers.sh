#!/bin/bash
# Date : (2012-04-26 23-18)
# Last revision : (2014-02-08 17-53)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend : Timidity daemon on port midi 128:0 (recommended)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gabriel_knight_sins_of_the_fathers"
PREFIX="GabrielKnight1_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Gabriel Knight 1: Sins of the Fathers"
SHORTCUT_NAME="Gabriel Knight 1: Sins of the Fathers"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1147
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "124ea26af47fd399d4ee5d47ed7a687b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=8
cpu_core=normal
cpu_cycles=10000
mixer_prebuffer=40
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

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Gabriel Knight - Sins of the Fathers/GK1.GOG" -t iso
_EOFAE_

POL_Shortcut "SIERRA.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Gabriel Knight - Sins of the Fathers/Manual.pdf"
# C:\GOG Games\Gabriel Knight - Sins of the Fathers\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL2ZfIACgkQ5TH6yaoTykdSgwCglkxwM0XInS3HAmpXDMDfT0fy
hV4An3IE/yli3Pk2TTK3NJ9V4Ad2BnMd
=ZsCu
-----END PGP SIGNATURE-----
