#!/bin/bash
# Date : (2012-04-08 14-46)
# Last revision : (2013-12-13 01-32)
# Wine version used : 1.5.15, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="oddworld_abes_oddysee"
PREFIX="AbesOddysee_gog"
WORKING_WINE_VERSION="1.6.1"

TITLE="GOG.com - Oddworld: Abe's Oddysee"
SHORTCUT_NAME="Oddworld: Abe's Oddysee"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1114
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Oddworld Inhabitants" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "c22a44d208e524dc2760ea6ce57829d5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# "16-bit SVGA"
POL_SetupWindow_VMS "2"

# http://www.playonlinux.com/fr/topic-9443-Probleme_daffichage_et_de_lancement_sur_Oddword_Abe_Exodus_.html
[ "$POL_OS" = "Mac" ] && Set_Desktop "On" "640" "480"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "AbeWin.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Abe's Oddysee/manual.pdf"
# C:\GOG Games\Abe's Oddysee\README.TXT

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKqY1AACgkQ5TH6yaoTykcRxQCgrOpMpV19IQ0AF5d4xYPK6KxX
kQYAoK+2/I+xMO5rnqYogJL+JcPsr9zi
=0Nyk
-----END PGP SIGNATURE-----
