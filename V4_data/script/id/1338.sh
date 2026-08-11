#!/bin/bash
# Date : (2012-07-30 17-03)
# Last revision : (2014-08-23 17-02)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="duke_nukem_3d_atomic_edition"
PREFIX="DukeNukem3DAE_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Duke Nukem 3D Atomic Edition"
SHORTCUT_NAME="Duke Nukem 3D Atomic Edition"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1338
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "3D Realms Entertainment / Apogee Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5410a97d6b87e4e79ff6c56dd833e1fd"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=120
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
render_scaler=normal2x
_EOFCFG_

POL_Shortcut "DUKE3D.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Duke Nukem 3D/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlP4rtMACgkQ5TH6yaoTykfQhACfR+PseXXkvD1ANx/fly64yz10
JI4An14mM/x0869xsJkVZYHgMl+TjLFV
=5QcU
-----END PGP SIGNATURE-----
