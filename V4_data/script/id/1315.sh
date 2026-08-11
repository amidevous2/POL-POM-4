#!/bin/bash
# Date : (2012-07-15 10-34)
# Last revision : (2014-05-10 09-54)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_underworld_1_2"
PREFIX="UltimaUnderworld_1_2_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Ultima Underworld 1 and 2"
SHORTCUT_NAME1="Ultima Underworld 1"
SHORTCUT_NAME2="Ultima Underworld 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1315
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Blue Sky Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6946e7042e4994e07c9a6ab2c84068ee"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Game expects itself at the root directory of C:\
mv "$WINEPREFIX/drive_c/GOG Games/Ultima Underworld 1 and 2/Ultima Underworld 1/UNDEROM1" "$WINEPREFIX/drive_c/"
mv "$WINEPREFIX/drive_c/GOG Games/Ultima Underworld 1 and 2/Ultima Underworld 2/UNDEROM2" "$WINEPREFIX/drive_c/"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=16
cpu_core=auto
cpu_cycles=max
mixer_rate=22050
mixer_blocksize=2048
mixer_prebuffer=240
sblaster_sbtype=sbpro1
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
sblaster_oplrate=22050
render_aspect=true
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Ultima Underworld 1 and 2/game.gog" -fs iso
_EOFAE_

# Enable SBPro support 
# http://www.gog.com/forum/ultima_series/sound_in_ultima_underworld_is_playing_music/post8
if type -t POL_unbase64 > /dev/null; then
    for dir in UNDEROM1 UNDEROM2; do
	POL_unbase64 <<-'_EOFCFG_' > "$WINEPREFIX/drive_c/$dir/DATA/UW.CFG"
	NCAtMSAtMSAtMSBzb3VuZA0NCjIgNyAyMjAgMSBzcGVlY2gNDQowIGN1dHMNDQoNCg==
	_EOFCFG_
    done
fi

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/UU1.BAT"
@ECHO OFF
D:
UW.BAT
EXIT 
_EOFBAT_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/UU2.BAT"
@ECHO OFF
D:
UW2.BAT
EXIT 
_EOFBAT_

POL_Shortcut "UU1.BAT" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Ultima Underworld 1 and 2/Ultima Underworld 1/Ultima_Underworld-Manual.pdf"

POL_Shortcut "UU2.BAT" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Ultima Underworld 1 and 2/Ultima Underworld 2/Ultima_Underworld_II-Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNt4SQACgkQ5TH6yaoTyke0zwCeM+iMTdTx6/hMEZA2xHfAy8ZR
wvYAn2GzN8f1nONLGdQY9FkWV+SZo7nS
=MxJ4
-----END PGP SIGNATURE-----
