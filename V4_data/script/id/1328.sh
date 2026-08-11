#!/bin/bash
# Date : (2012-07-21 11-57)
# Last revision : (2014-05-19 23-39)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tex_murphy_the_pandora_directive"
PREFIX="TexMurphyTPD_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Tex Murphy: The Pandora Directive"
SHORTCUT_NAME="Tex Murphy: The Pandora Directive"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1328
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Access Software / Worldplay LLC" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "f9456466f28c4536a26a81453df01d14" "09f3258112beff87e10ecb1008513a46" "354a4000838b395bb7ec3136076d36cc" "29573ac2ff92cee6ea2f4b6818f9f11f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$POL_USER_ROOT/tmp" || POL_Debug_Fatal 'Temporary directory not found!'
POL_Download "http://files.playonlinux.com/empty.iso.gz" "ba835afa9c5b7d0202bc595ed0231275"
zcat empty.iso.gz > "$WINEPREFIX/drive_c/empty.iso"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
render_frameskip=1
cpu_core=auto
cpu_cputype=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
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
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# Switch to SB16 music synthesis
cd "$GOGROOT/The Pandora Directive" || POL_Debug_Fatal "Could not find game directory"
cp CONFIG.INI CONFIG.INI.orig
perl -pe 'if(/^\[(.*)\]/) { $section = $1 } if ($section eq "DIGI_CONFIG") { s/^Int=\d+/Int=7/; } if($section eq "MIDI_CONFIG") { s/^BoardNum=\d+/BoardNum=3/; s/^IoAddr=0x[0-9A-F]+/IoAddr=0x388/i; }' CONFIG.INI.orig > CONFIG.INI

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/empty.iso" -t iso
set dos4gvm=
_EOFAE_

POL_Shortcut "TEX4.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Pandora Directive/readme.txt"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOE7DsACgkQ5TH6yaoTykcs7wCfdGnvLtuOQUXe6+6NqFOkaYaP
KhYAoIaBGdVK0yLDcDr7YAF4dyswZ3xl
=oTsR
-----END PGP SIGNATURE-----
