#!/bin/bash
# Date : (2012-07-29 23-13)
# Last revision : (2013-05-19 17-37)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ultima_worlds_of_adventure_2_martian_dreams"
PREFIX="UltimaWorldsOfAdventure2MD_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Ultima Worlds of Adventure 2: Martian Dreams"
SHORTCUT_NAME="Ultima Worlds of Adventure 2: Martian Dreams"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1336
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Origin Systems / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3709cf8a85087aae8b09e6605fcfc5e5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cputype=auto
cpu_cycles=5000
render_aspect=true
sdl_autolock=false
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "MARTIAN.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Worlds of Ultima - Martian Dreams/secret answers.txt"
# C:\GOG Games\Martian Dreams\Mysteries of the Red Planet - manual.pdf
# C:\GOG Games\Martian Dreams\Use of the Orb of the Moons - manual.pdf
# C:\GOG Games\Martian Dreams\reference card.pdf

POL_SetupWindow_message "$(eval_gettext 'The codes needed to start a new game can be found in the\ndocumentation;\nRight-click the game icon, "Read the manual".')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJa0rUACgkQ5TH6yaoTykf6KACgo3kFke/+t0se3LIQXlIsCu2E
VNYAnjM3sze9Z1LUznYf8rzRKCfLli8h
=Gmp5
-----END PGP SIGNATURE-----
