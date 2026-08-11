#!/bin/bash
# Date : (2012-09-04 21-50)
# Last revision : (2014-03-23 17-55)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="master_of_magic"
PREFIX="MasterOfMagic_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Master of Magic"
SHORTCUT_NAME="Master of Magic"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1389
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "SimTex / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9ea9f54550f36028926db5044ecdac61"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GOG's cpu_cycles=auto (aka 3000) is a bit low
cat <<EOF >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_type=auto
cpu_cycles=5000
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
render_frameskip=1
sdl_autolock=false
EOF
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "magic.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Master of Magic/manual.pdf"
# C:\GOG Games\Master Of Magic\README.TXT
# C:\GOG Games\Master Of Magic\spellbook.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNT2PEACgkQ5TH6yaoTykdS6ACgo+8PfYWe/zuoPowBUlhGHJ1S
I/wAnj7k/rYb4PaNmUe9h3YubOiSuFBS
=eZMr
-----END PGP SIGNATURE-----
