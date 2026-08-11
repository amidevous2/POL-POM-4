#!/bin/bash
# Date : (2015-10-01 18-14)
# Wine version used : 1.6.2
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Gray Matter"
PREFIX="GrayMatter"
WORKING_WINE_VERSION="1.6.2"
SHORTCUT_NAME="Gray Matter"
GOGID="gray_matter"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2394
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "WizarBox Production" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "ca7105b641603da758579592351985d4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# DirectX is essential
POL_Call POL_Install_dxfullsetup

POL_Wine_reboot

POL_Shortcut "Game.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlSxkkwACgkQ5TH6yaoTykd4ZQCgoBwQuzbXSDgpgNy8isxBoioQ
oCAAn3Dsv+ch1t2P4mdqMvqC0S+pEyyQ
=v/Iq
-----END PGP SIGNATURE-----
