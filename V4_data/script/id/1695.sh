#!/bin/bash
# Date : (2013-05-18 23-00)
# Last revision : (2013-05-18 23-00)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="magic_carpet"
PREFIX="MagicCarpet_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Magic Carpet"
SHORTCUT_NAME="Magic Carpet"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1695
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ebeee30afad4c1c56a7102253c3aa4e4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# The game expects itself at the root directory of C:
mv "$WINEPREFIX/drive_c/GOG Games/Magic Carpet/CARPET.CD" "$WINEPREFIX/drive_c/"

# Dosbox config
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_output=overlay
render_aspect=true
cpu_cycles=25000
cpu_cycleup=2000
cpu_cycledown=2000
mixer_prebuffer=50
_EOFCFG_

# Enable Sound Blaster Pro support
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOFINF_' > "$WINEPREFIX/drive_c/CARPET.CD/SNDSETUP.INF"
U09VTkRGWCA9IFNCMTYgMjIwIDUgMQ0KTVVTSUMgPSBTQlBSTyAzODggMCAwIA0K
_EOFINF_
	POL_unbase64 <<-'_EOFDAT_' > "$WINEPREFIX/drive_c/CARPET.CD/SNDSETUP.DAT"
U0IxNgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABTb3VuZGJsYXN0ZXIgMTYAAAAAAAAAAAAAAAAAAAAAAFNCUFJPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAU291bmRibGFzdGVyIHBybyBmbQAAAAAAAAAAAAAAAAAyMjAAAAAAAAAAMjIwAAAAAAAAADUAAAAAAAAAAAA1AAAAAAAAAAAAMQAAAAAAAAAAADEAAAAAAAAAAAAzODgAAAAAAAAAMzg4AAAAAAAAAA==
_EOFDAT_
fi

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/CARPET.CD/GAME.GOG" -fs iso
_EOFAE_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/MagicCarpet.bat"
@ECHO OFF
D:
cd CARPET
CARPET.EXE
EXIT
_EOFBAT_

POL_Shortcut "MagicCarpet.bat" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Magic Carpet/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGZPy0ACgkQ5TH6yaoTykdp/QCdEZW4dAEQjlOYWQCEGGUNQqGL
dwUAn27PKKB50tnE8DsMEYVzgXPYgzBU
=h2nu
-----END PGP SIGNATURE-----
