#!/bin/bash
# Date : (2013-02-10 16-42)
# Last revision : (2013-07-19 02-33)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="urban_chaos"
PREFIX="UrbanChaos_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Urban Chaos"
SHORTCUT_NAME="Urban Chaos"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1567
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Mucky Foot Productions / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "83531e6396084f231b196b661742db78"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

cd "$GOGROOT/Urban Chaos/text" || POL_Debug_Fatal "Unable to change directory"
# At least warn of the issue
cp lang_english.txt lang_english.txt.orig
sed -e 's/^Restart Level/Restart Level(crash)/' lang_english.txt.orig > lang_english.txt

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "fallen.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Urban Chaos/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHokEYACgkQ5TH6yaoTykd96wCfewcaYWT0UrHatxi4EEtc4+A6
49YAn3OzVAlwNEcyiW8kN8vr50H7K8IE
=pZOq
-----END PGP SIGNATURE-----
