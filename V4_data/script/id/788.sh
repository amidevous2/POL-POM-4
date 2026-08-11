#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2012-04-29 18:25)
#   Update to v4.0

# PlayOnLinux API
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Infos
TITLE="Huckel 95"
PREFIX="Huckel95"
EDITEUR="Jean-Yves Magna"
EDITEUR_URL="http://www.jymagna.com/"
AUTEUR="Quentin PÂRIS"

# On est parti
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITEUR" "$EDITEUR_URL" "$AUTEUR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.2.3"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

POL_Download "http://chimiepclamartin.nos-actus.fr/Sur%20le%20Net/huc.exe" f9b3a0fc0cc46a014ea0e59802880dc3
POL_Wine_WaitBefore "$TITLE"
POL_Wine "huc.exe"

POL_System_TmpDelete
POL_Shortcut "Huckel95.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwO4MYACgkQ5TH6yaoTykekJQCfU5EoZPSCuq9U5RG/amckrsyp
9LQAn177D1m9qAGZbobn5izr6NhqF/JQ
=0uDR
-----END PGP SIGNATURE-----
