#!/bin/bash
# Date : (2012-05-17 13-41)
# Last revision : (2014-07-06 15-05)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="realms_of_arkania_3"
PREFIX="RealmsOfArkania3_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Realms of Arkania 3"
SHORTCUT_NAME="Realms of Arkania 3: Shadows Over Riva"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1206
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Attic Entertainment / Fantasy Productions" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "8377b88228e5017d31cc1ce1d7d0c053"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# "VGA"?
POL_SetupWindow_VMS "1"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
cpu_core=auto
cpu_cputype=auto
cpu_cycles='fixed 35000'
render_frameskip=1
mixer_rate=44100
mixer_blocksize=2048
mixer_prebuffer=80
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=44100
render_aspect=true
render_scaler=normal2x
_EOFCFG_

# 3D viewing: Far (any reason not to?)
if type -t POL_unbase64 > /dev/null; then
	cp "$WINEPREFIX/drive_c/GOG Games/Realms of Arkania 3/DATA/RIVA.CFG" "$WINEPREFIX/drive_c/GOG Games/Realms of Arkania 3/DATA/RIVA.CFG.orig"
	POL_unbase64 <<-_EOF_ > "$WINEPREFIX/drive_c/GOG Games/Realms of Arkania 3/DATA/RIVA.CFG"
	FQABAWQAAAFQQAEBAgIAAQEBAAB/AAABAAIAAwAEAAUABgAHAAgACQAKAAsADAANAA4ADwAQABEA
	EgATABQAFQA=
	_EOF_
fi


# Don't know why the cd is necessary, but it sucks
cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
@ECHO OFF
C:                                                                          
cd \GOGGAM~1\REALMS~1                                                       
imgmount D "$GOGROOT/Realms of Arkania 3/game.inst" -t iso -fs iso
_EOFAE_

POL_Shortcut "RIVA.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Realms of Arkania 3/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO5S5UACgkQ5TH6yaoTykemAQCfY3KAfLJJI96OpwCaSCQzXHSU
D9sAnAhiGqMW0kBHRi47VnO5UFL9df5t
=EExx
-----END PGP SIGNATURE-----
