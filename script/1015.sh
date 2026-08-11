#!/bin/bash
# Date : (2011-12-01 22-38)
# Last revision : (2013-05-26 17-46)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="starflight_1_2"
PREFIX="Starflight_1_2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Starflight 1 and 2"
SHORTCUT1_NAME="Starflight 1"
SHORTCUT1_CODEWHEEL="$SHORTCUT1_NAME - $(eval_gettext 'Code wheel')"
SHORTCUT2_NAME="Starflight 2"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1015
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Binary Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "d00ac6d5c07bc44a698359e8024568a1"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$POL_USER_ROOT/tmp"
POL_Download "http://files.playonlinux.com/starflight_batches.tgz" "2ad24333904d2e875736ec3995f0e3aa"
tar xzvf starflight_batches.tgz

# Doesn't hurt ;)
POL_Wine_reboot

cd "$WINEPREFIX/drive_c/GOG Games/Starflight 1 and 2" || POL_Debug_Fatal "Game not installed in standard path?"

# Problem with shortizing "Starflight 1" and "Starflight 2" subdirectories side-by-side :(
STARFLT1="STARFLT1"
STARFLT2="STARFLT2"
mv "Starflight 1" "$STARFLT1"
mv "Starflight 2" "$STARFLT2"

# Create for Starflight 1 what has been done for Starflight 2: batch file to save/restore games
cp "$STARFLT2/MMAIN.EXE" "$STARFLT1/STARFLT/PLAY/"
cp "$STARFLT2/DPUT.EXE" "$STARFLT1/STARFLT/PLAY/"
cp "$POL_USER_ROOT/tmp/SF1.BAT" "$STARFLT1/STARFLT/PLAY/SF1.BAT"

# "file" doesn't recognize MSDOS batch files as such if they don't start with @ECHO OFF or end with ^Z
# + fix typo in original (GAMEB8 instead of GAME.B8 in one place)
cp "$POL_USER_ROOT/tmp/SF2.BAT" "$STARFLT2/SF2.BAT"

cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_cycles='fixed 5000'
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"


POL_Shortcut "SF1.BAT" "$SHORTCUT1_NAME" "$SHORTCUT1_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT1_NAME" "$WINEPREFIX/drive_c/GOG Games/Starflight 1 and 2/$STARFLT1/manual.pdf"
# C:\GOG Games\Starflight 1 and 2/Starflight 1/map.pdf

POL_Shortcut "Starflight_codes_by_gog.exe" "$SHORTCUT1_CODEWHEEL" "" "" "Game;RolePlaying;"

POL_Shortcut "SF2.BAT" "$SHORTCUT2_NAME" "$SHORTCUT2_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT2_NAME" "$WINEPREFIX/drive_c/GOG Games/Starflight 1 and 2/$STARFLT2/manual.pdf"
# C:\GOG Games\Starflight 1 and 2\Starflight 2\map.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGiLrYACgkQ5TH6yaoTykfLsACfbMK7XmQh3RkIcollWycnfiWc
g0YAnR1LhV8hv6qV7INxtaqAvhH/U4ZY
=M0zv
-----END PGP SIGNATURE-----
