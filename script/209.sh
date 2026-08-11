#!/bin/bash
# Date : (2011-11-06 21-27)
# Last revision : (2013-06-21 22-17)
# Wine version used : 1.2.2
# Distribution used to test :
# Author : malownu & Tutul (update)

# CHANGELOG
# [SuperPlumus] (2013-06-21 22-17)
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Cadstd Lite 3.7.0"
PREFIX="Cadstdlite370"
WORKING_WINE_VERSION="1.2.2"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Apperson and Daughters" "http://www.cadstd.com/" "malownu" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

cd "$POL_System_TmpDir"
POL_Download "http://www.cadstd.com/binaries/cslte361.exe" ""
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "cslte361.exe"
POL_Wine_WaitExit "$TITLE"

POL_Wine_SetVideoDriver

POL_System_TmpDelete

POL_Shortcut "cadstd.exe" "$TITLE" "Cadstd.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHEtc0ACgkQ5TH6yaoTykf05gCeP2Y3kYtxmaq3AfR4eoEMjHic
ZwMAnjOshR/cRHIdOF1KCR/e9yAvahc8
=v81t
-----END PGP SIGNATURE-----
