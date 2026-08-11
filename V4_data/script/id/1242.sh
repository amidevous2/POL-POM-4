#!/bin/bash
# Date : (2012-06-03 11-12)
# Last revision : (2013-05-17 00-17)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_4"
PREFIX="Ultima4_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Ultima 4"
SHORTCUT_NAME="Ultima 4: Quest of the Avatar"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1242
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "4b228ddce2c3969770c9298f04f3fa4a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# Game expects itself at the root directory of C:\
mv "$WINEPREFIX/drive_c/GOG Games/Ultima 4 - Quest of the Avatar/"* "$WINEPREFIX/drive_c/"

# Does it have any music?
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
cpu_core=auto
cpu_cycles=500
dosbox_memsize=16
sblaster_sbtype=sbpro1
sblaster_sbbase=220
sblaster_irq=5
sblaster_dma=1
sblaster_hdma=5
sblaster_mixer=true
sblaster_oplmode=auto
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/ultima4.bat"
@ECHO OFF
ultima.com
EXIT
_EOFBAT_

POL_Shortcut "ultima4.bat" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/manual.pdf"
# C:\GOG Games\Ultima 4\readme.rtf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGVXncACgkQ5TH6yaoTykc4/wCglt3y7jMyzrfi++ozgJGAq+Lg
44oAn1T1UlP7ty48nwyYpgndPeoKF8xu
=qNtt
-----END PGP SIGNATURE-----
