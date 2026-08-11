#!/bin/bash
# Date : (2012-06-18 19-00)
# Last revision : (2014-02-03 23-11)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# FIXME: no support for 3DFX LOL2, requires DOSBOX with Glide patch

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="lands_of_lore_1_2"
PREFIX="LandsOfLore_1_2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Lands of Lore 1 and 2"
SHORTCUT_NAME1="Lands of Lore 1: The Throne of Chaos"
SHORTCUT_NAME2="Lands of Lore 2: Guardians of Destiny"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1262
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Westwood Studios / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ca368d819015b2508be877a53eb4dd51"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2" || POL_Debug_Fatal "Game not installed in standard path?"

# Problem with shortizing "Lands of Lore 1" and "Lands of Lore 2" subdirectories side-by-side :(
LOL1="LOL1"
LOL2="LOL2"
mv "Lands of Lore 1" "$LOL1"
mv "Lands of Lore 2" "$LOL2"


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
render_aspect=true
sdl_autolock=false
cpu_core=auto
cputype=auto
cycles=max
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=opl3
sblaster_oplemu=default
sblaster_oplrate=44100
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2/$LOL1/LOL1.BAT"
@ECHO OFF
imgmount D "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2/$LOL1/GAME.DAT" -t iso -fs iso
CONFIG -set "sblaster opl_emu=old"
LOLCD.EXE
EXIT
_EOFBAT_

perl -pe 's/^DeviceIRQ=5/DeviceIRQ=7/' "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2/$LOL2/LOLSETUP.INI"

POL_Shortcut "LOL1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2/$LOL1/manual.pdf"

POL_Shortcut "LOLG.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "-CD ." "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Lands Of Lore 1 and 2/$LOL2/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLwGAoACgkQ5TH6yaoTyke9lwCfVQ34wyFvzdGyaX/2qqsw9HTA
xOcAnj/xttvGFxOLZwPj3tVJ/9WuEujA
=+m2x
-----END PGP SIGNATURE-----
