#!/bin/bash
# Date : (2010-03-27 12-00)
# Last revision : (2010-10-25 18-39)
# Wine version used : 1.1.43
# Distribution used to test : Fedora 12, Snow Leopard
# Author : NSLW, Tinou
# Licence : Retail
# Depend : ImageMagick

# Changelog
# [Quentin PÂRIS] (2012-05-12)
#	- Update for PlayOnLinux 4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Rocket Reader"
PREFIX="RocketReader"
WINEVERSION="1.4"

POL_SetupWindow_Init

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Rocket Reader" "http://www.rocketreader.com/" "Quentin PÂRIS" "$PREFIX"


POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_Call POL_Install_LunaTheme

#downloading Rocket Reader
cd "$WINEPREFIX/drive_c"
POL_Download "ftp://rocketreader.com/rocketreaderv83.exe"

#installing Rocket Reader
POL_Wine_WaitBefore "$TITLE"
POL_Wine "rocketreaderv83.exe"

#creating shortcut for Rocket Reader
POL_Shortcut "RocketReader.exe"  "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlESIPAACgkQ5TH6yaoTykffpwCdHqfgqt2amz5XucZp+k6Yzz1u
PgQAn3vNjdpdeVaUZixQkHpVAs0h+Xxc
=FnCy
-----END PGP SIGNATURE-----
