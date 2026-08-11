#!/bin/bash
# Date : (2013-08-20 22-37)
# Last revision : (2013-00-03 23-19)
# Wine version used : 1.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Use Wine 1.5.27+ (bug #29499 with DirectPlay)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="moonbase_commander"
PREFIX="MoonbaseCommander_gog"
WORKING_WINE_VERSION="1.6"

TITLE="GOG.com - Moonbase Commander"
SHORTCUT_NAME="Moonbase Commander"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1815
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Humongous Entertainment / Rebellion" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3e5a0b82d6532832d901fa7152013788"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Call POL_Install_directplay

# GoG work!
Set_OS winxp

# 640x480x16bpp?
POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "moonbase.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Moonbase Commander/Manual.pdf"
# C:\GOG Games\Moonbase Commander\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlImU0YACgkQ5TH6yaoTykedXgCfXTuxrSZKRr3QlMucJjgdB1pb
NFoAn3AAfSYKvC0UGEdAgpV6EJe4SkE0
=CDdp
-----END PGP SIGNATURE-----
