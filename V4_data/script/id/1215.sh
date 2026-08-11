#!/bin/bash
# Date : (2012-05-20 12-32)
# Last revision : (2014-02-16 17-42)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gabriel_knight_2_the_beast_within"
PREFIX="GabrielKnight2_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - Gabriel Knight 2: The Beast Within"
SHORTCUT_NAME="Gabriel Knight 2: The Beast Within"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1215
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sierra / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "72934b67ab65488450ec6464dd8a64b8" "47c9f990552caef28d94c2df6b66c306" "df906254b6ecd6cbf6c41dbd87627478"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


cat <<'_EOFCFG_' >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=8
cpu_core=normal
cpu_cycles=10000
mixer_prebuffer=40
_EOFCFG_
[ "$POL_OS" = "Linux" ] && echo "render_scaler=hq2x" >> "$WINEPREFIX/playonlinux_dos.cfg"

POL_Shortcut "SIERRA.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "resource.cfg" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Gabriel Knight 2 - The Beast Within/Manual.pdf"
# C:\GOG Games\Gabriel Knight 2 - The Beast Within\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMA71YACgkQ5TH6yaoTykdq+gCcCEPfG8tFkvETS9n+NWeNvuP2
d0oAoJsV6b8rJVrNxgmMzlpCy6H9yndQ
=G5DQ
-----END PGP SIGNATURE-----
