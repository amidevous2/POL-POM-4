#!/bin/bash
# Date : (2013-07-07 22-44)
# Last revision : (2013-12-27 19-26)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="catacombs_pack"
PREFIX="Catacombs_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Catacombs Pack"
SHORTCUT_NAME1="The Catacombs"
SHORTCUT_NAME2="Catacomb 3D: Descent"
SHORTCUT_NAME3="Catacomb Abyss"
SHORTCUT_NAME4="Catacomb Armageddon"
SHORTCUT_NAME5="Catacomb Apocalypse"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1767
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ID Software, Softdisk Publishing / Flat Rock Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "aeeb470a835678d226f502578e2cfb26"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cycles=auto
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=120
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_oplmode=auto
sblaster_oplrate=22050
gus_gus=false
ipx_ipx=false
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "CATACOMB.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Catacombs Pack/Catacomb/readme.txt"

POL_Shortcut "CAT3D.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Catacombs Pack/Cat3D/readme.txt"

POL_Shortcut "CATABYSS.EXE" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$GOGROOT/Catacombs Pack/Abyss/readme.txt"

POL_Shortcut "CATARM.EXE" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME4" "$GOGROOT/Catacombs Pack/Armageddon/readme.txt"

POL_Shortcut "CATAPOC.EXE" "$SHORTCUT_NAME5" "$SHORTCUT_NAME5.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME5" "$GOGROOT/Catacombs Pack/Apocalypse/readme.txt"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlK8dzwACgkQ5TH6yaoTykfyigCfb3hRlON47TGleH1Zmu1heshM
5zIAnik/5FdaOmMiQozQNlWEV4HkMH7h
=cwfl
-----END PGP SIGNATURE-----
