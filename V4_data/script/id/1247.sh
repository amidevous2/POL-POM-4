#!/bin/bash
# Date : (2012-06-06 22-14)
# Last revision : (2013-04-11 22-51)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="alone_in_the_dark"
PREFIX="AloneInTheDark2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Alone in the Dark 2"
SHORTCUT_NAME="Alone in the Dark 2"

# hash 6597966a34543dc506447b6afdf4f925
INSTALLBIN="setup_alone_in_the_dark2_2.0.0.7.exe"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1247
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infogrames Europe SA / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

if [ "$POL_SELECTED_FILE" ]; then
    POL_GoG_location="$POL_SELECTED_FILE"
else
    POL_Call POL_GoG_setup "$GOGID" --alternate 'alone_in_the_dark_2_3' 1056 --bonus "b3be7275c5638c6ddcc2d7bede4bb030"
    if [ "$POL_GoG_downloaded" = "True" ]; then
        ARCHIVE="$(POL_Config_Read GOG_REPO)/alone_in_the_dark_2_3_pc.zip"
        mv "$POL_GoG_location" "$ARCHIVE"

        # unzip archive
        unzip -j "$ARCHIVE" -d "$(POL_Config_Read GOG_REPO)" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"
        rm "$ARCHIVE"

        POL_GoG_location="$(POL_Config_Read GOG_REPO)/$INSTALLBIN"
    fi
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
cpu_core=simple
cpu_cputype=486_slow
cpu_cycles=19000
mixer_rate=44100
mixer_blocksize=1024
mixer_prebuffer=240
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
imgmount D "$WINEPREFIX/drive_c/GOG Games/Alone in the Dark 2/GAME.INST" -t iso
_EOFAE_

POL_Shortcut "AITD2.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Alone in the Dark 2/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFnJRcACgkQ5TH6yaoTyke9DgCgpmkRk+MC1Pz3SNHv5a7KZBLo
g6gAoK+zWwk5p5q8TmQhlO+ZrTT2XGQf
=EGaP
-----END PGP SIGNATURE-----
