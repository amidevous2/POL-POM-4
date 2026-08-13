#!/bin/bash
# Date : (2013-01-05 12-53)
# Last revision : (2013-12-24 19-28)
# Wine version used : 1.5.13, 1.5.20, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="puddle"
PREFIX="Puddle_gog"
WORKING_WINE_VERSION="1.6.1"

TITLE="GOG.com - Puddle"
SHORTCUT_NAME="Puddle"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1528
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Neko Entertainment" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5880a9b921b5627d664c65a2bfb950ee"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Needed by launcher, doesn't work with Mono
POL_Call POL_Install_dotnet20sp2

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# Really?
POL_SetupWindow_VMS "512"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;Simulation;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlK52WkACgkQ5TH6yaoTykeGBwCfYRYsr4ldQvmLA4eqrQbNduyC
IKoAniXOqpX74F44oAC7vb8UrjOfULiP
=kEEI
-----END PGP SIGNATURE-----
