#!/bin/bash
# Date : (2012-01-04 23-55)
# Last revision : (2014-03-02 16-54)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="last_express_the"
PREFIX="LastExpress_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - The Last Express"
SHORTCUT_NAME="The Last Express"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1125
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Smoking Car Productions / Phoenix Licensing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "46632a6a17f6e7fffe6dc4abc82cd4e7"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=32
cpu_core=auto
cpu_cputype=auto
cpu_cycles='max 95% limit 33000'
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# Use drives from W downward
cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
mount W "$GOGROOT/The Last Express/data" -t cdrom
_EOFAE_

POL_Shortcut "EXPRESS.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Last Express/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMTbtQACgkQ5TH6yaoTykfWqQCdEaR8dQf3HVdDKyid7DH/FWPc
F2sAnA52nJZDXh5Z6mXh/CSH9eonTYMD
=jcFi
-----END PGP SIGNATURE-----
