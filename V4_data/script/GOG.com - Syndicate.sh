#!/bin/bash
# Date : (2012-05-21 21-20)
# Last revision : (2013-09-28 10-35)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="syndicate"
PREFIX="Syndicate_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Syndicate"
SHORTCUT_NAME="Syndicate Plus"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1219
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "16f8a77ac40f82bfee4a946da1ab242e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=8000
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
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

POL_Shortcut "synd.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Syndicate/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJGn6oACgkQ5TH6yaoTykeTngCdH7tC2/0fp7/bc60F6CSavJu9
lzoAnjWkvpiAXLlZ7pCGXpjRZL5OESpH
=YRcE
-----END PGP SIGNATURE-----
