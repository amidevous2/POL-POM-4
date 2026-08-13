#!/bin/bash
# Date : (2012-05-16 23-39)
# Last revision : (2014-06-18 22-37)
# Wine version used : 1.4-dos_support_0.6, 1.6.2-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dragonsphere"
PREFIX="Dragonsphere_gog"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"

TITLE="GOG.com - Dragonsphere"
SHORTCUT_NAME="Dragonsphere"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1203
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microprose / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "de60b8167934faab186f93107c94aa18"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
manual_mount=true
dosbox_memsize=30
render_aspect=true
cpu_core=dynamic
cpu_cycles=8000
render_frameskip=1
render_scaler=normal2x
_EOFCFG_

cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
imgmount D "$WINEPREFIX/drive_c/GOG Games/Dragonsphere/GAME.INST" -t iso
_EOFAE_

# VGA 256 colors
POL_SetupWindow_VMS "1"

POL_Shortcut "MAINMENU.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-p" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Dragonsphere/answers.txt"
# C:\GOG Games\Dragonsphere\manual.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOiEGkACgkQ5TH6yaoTykdCwwCgoxTgZKuXV1mO/nym5mS2tiR/
WoAAn1KySWJxwx4cpchBhkMKB/be+1SS
=CIJU
-----END PGP SIGNATURE-----
