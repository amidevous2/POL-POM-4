#!/bin/bash
# Date : (2012-05-03 22-02)
# Last revision : (2013-05-14 22-23)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="theme_hospital"
PREFIX="ThemeHospital_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Theme Hospital"
SHORTCUT_NAME="Theme Hospital"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1162
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "88806c2c2f9376b696dc282939afd8cf"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# "640x480 256 colors"
POL_SetupWindow_VMS "2"

cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=auto
cpu_cputype=auto
cpu_cycles=auto
render_frameskip=1
mixer_rate=44100
mixer_prebuffer=240
sblaster_sbtype=sb16
sblaster_sbbase=220
sblaster_irq=7
sblaster_dma=1
sblaster_hdma=5
sblaster_sbmixer=true
sblaster_oplmode=auto
sblaster_oplemu=default
sblaster_oplrate=44100

speaker_pcspeaker=false
speaker_tandy=off
speaker_disney=false
joystick_joysticktype=none
midi_mpu401=none
gus_gus=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

# Set real install path
cat <<'_EOFCFG_' | perl -pe 's/\n/\r\n/' > "$WINEPREFIX/drive_c/GOG Games/Theme Hospital/HOSPITAL.CFG"
INSTALL_PATH=c:\GOGGAM~1\THEMEH~1\
INSTALL_TYPE=MAX
LANGUAGE=ENG
_EOFCFG_

POL_Shortcut "HOSPITAL.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Theme Hospital/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGSp3gACgkQ5TH6yaoTykc9AgCgkmUImArs1CHZzNZPbQ4Sq2fc
qSMAoIslXq4VGYolL9Ax2kbmvXSutwd+
=477n
-----END PGP SIGNATURE-----
