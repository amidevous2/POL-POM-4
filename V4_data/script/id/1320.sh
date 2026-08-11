#!/bin/bash
# Date : (2012-07-16 19-55)
# Last revision : (2013-05-09 07-46)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="worlds_of_ultima_the_savage_empire"
PREFIX="WorldsOfUltimaTSE_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Worlds of Ultima: The Savage Empire"
SHORTCUT_NAME="Worlds of Ultima: The Savage Empire"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1320
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3798cf8c505a8e79c08efee85e7c4f84"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=5000
sdl_autolock=false
_EOFCFG_
# aspect correction does not look necessary
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "SAVAGE.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Worlds of Ultima - The Savage Empire/secret answers.txt"
# C:\GOG Games\Worlds of Ultima - The Savage Empire\Ultimate Adventures - manual.pdf
# C:\GOG Games\Worlds of Ultima - The Savage Empire\reference card.pdf

POL_SetupWindow_message "$(eval_gettext 'The codes needed to start a new game can be found in the\ndocumentation;\nRight-click the game icon, "Read the manual".')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJaz+8ACgkQ5TH6yaoTykdbkgCfTPQNlA4qlGOc/LseClAZuDJ2
SCwAnRwh2bltXRRNZyF7JvjXX4UAf5iw
=3ObU
-----END PGP SIGNATURE-----
