#!/bin/bash
# Date : (2013-02-28 22-02)
# Last revision : (2013-05-18 19-23)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="duke_nukem_12"
PREFIX="DukeNukem_1_2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Duke Nukem 1 and 2"
SHORTCUT_NAME11="Duke Nukem 1E1: Shrapnel City"
SHORTCUT_NAME12="Duke Nukem 1E2: Mission: Moonbase"
SHORTCUT_NAME13="Duke Nukem 1E3: Trapped in the Future"
SHORTCUT_NAME2="Duke Nukem 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1601
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "3D Realms Entertainment" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "d45367b2e5a74330f41a1c73b4d96ed0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cycles=max
render_aspect=true
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=40
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
ipx_ipx=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 1+2/NUKEM2.BAT"
@ECHO OFF
CONFIG -set "cpu cycles=8000"
NUKEM2
EXIT
_EOFBAT_

POL_Shortcut "DN1.EXE" "$SHORTCUT_NAME11" "$SHORTCUT_NAME11.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME11" "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 1+2/manual.pdf"
# C:\GOG Games\Duke Nukem 1+2\hintsheet.pdf

POL_Shortcut "DN2.EXE" "$SHORTCUT_NAME12" "$SHORTCUT_NAME12.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME12" "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 1+2/manual.pdf"

POL_Shortcut "DN3.EXE" "$SHORTCUT_NAME13" "$SHORTCUT_NAME13.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME13" "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 1+2/manual.pdf"

POL_Shortcut "NUKEM2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 1+2/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGXu0sACgkQ5TH6yaoTykc18QCePXiG9cs86f0ZP6CdGifX8mKM
lDYAoKhpqBWTW29wzk7eu3QQqgJv9Z85
=TEmy
-----END PGP SIGNATURE-----
