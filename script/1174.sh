#!/bin/bash
# Date : (2012-05-09 13-03)
# Last revision : (2013-05-23 00-05)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="stonekeep"
PREFIX="Stonekeep_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Stonekeep"
SHORTCUT_NAME="Stonekeep"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1174
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a97ef922eee204686874a4d2bc46b4bc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_SetupWindow_VMS "1"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cycles=auto
render_aspect=true
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Stonekeep/STONKEEP.GOG" -t iso -fs iso
set dos4gvm=
_EOFAE_

cat <<'_EOFBAT_' > "$WINEPREFIX/drive_c/GOG Games/Stonekeep/SK.BAT"
@ECHO OFF
D:\data\SK.EXE %1
EXIT
_EOFBAT_

POL_Shortcut "SK.BAT" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Stonekeep/manual.pdf"
# C:\GOG Games\Stonekeep\readme.TXT

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOV5YIACgkQ5TH6yaoTykeqiQCgjDZ9nj6f78ziMvRyhIeorTFy
D1kAnj6d5FOV/3xKkfwEsOqwotFndhim
=7i9n
-----END PGP SIGNATURE-----
