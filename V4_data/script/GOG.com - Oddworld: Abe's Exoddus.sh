#!/bin/bash
# Date : (2012-04-08 16-43)
# Last revision : (2013-12-13 20-58)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="oddworld_abes_exoddus"
PREFIX="AbesExoddus_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Oddworld: Abe's Exoddus"
SHORTCUT_NAME="Oddworld: Abe's Exoddus"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1115
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Oddworld Inhabitants" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "91fe864e761e6d389d7eb332214c72a6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# "16-bit SVGA"
POL_SetupWindow_VMS "2"

# http://www.playonlinux.com/fr/topic-9443-Probleme_daffichage_et_de_lancement_sur_Oddword_Abe_Exodus_.html
[ "$POL_OS" = "Mac" ] && Set_Desktop "On" "640" "480"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Exoddus.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Abe's Exoddus/manual.pdf"
# C:\GOG Games\Abe's Exoddus\README.TXT

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKrarwACgkQ5TH6yaoTykcrMACeJvT769OsapoZY4PrXm2EOJ/1
+OAAoJNWE0V3wFlg7qmz7UPnsxKJ+Szm
=qrXP
-----END PGP SIGNATURE-----
