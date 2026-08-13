#!/bin/bash
# Date : (2013-05-18 23-00)
# Last revision : (2013-06-29 14-41)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="magic_carpet_2_the_netherworlds"
PREFIX="MagicCarpet2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Magic Carpet 2: The Netherworlds"
SHORTCUT_NAME="Magic Carpet 2: The Netherworlds"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1696
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "1" "27dd1808b633360d56c258104bbcea20"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# The game expects itself at the root directory of C:
mv "$WINEPREFIX/drive_c/GOG Games/Magic Carpet 2/GAME/NETHERW" "$WINEPREFIX/drive_c/"

# Dosbox config
cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
sdl_output=overlay
render_aspect=true
mixer_prebuffer=100
_EOFCFG_

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Magic Carpet 2/MC2.cfg" -fs iso
_EOFAE_

cat <<_EOFBAT_ > "$WINEPREFIX/drive_c/MagicCarpet2.bat"
@ECHO OFF
D:
NETHERW.exe
EXIT
_EOFBAT_

POL_Shortcut "MagicCarpet2.bat" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Magic Carpet 2/Magic Carpet 2 - Manual.pdf"
# $WINEPREFIX/drive_c/GOG Games/Magic Carpet 2/Magic Carpet 2 - Quick Reference Card.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHO2DkACgkQ5TH6yaoTykf7WwCeKa7piIhIrbcXwFTMpL6uGu3/
pNkAnR6V/q38REqT+Sd/Evc/iX4JCv6t
=JBrO
-----END PGP SIGNATURE-----
