#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2012-05-08 10-31)
#   Initial release
# [SuperPlumus] (2013-12-08 18-43)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Geoplan Geospace"
PREFIX="GeoplanGeospace"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "GeoplanGeospace" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "$PREFIX"

cd "$POL_System_TmpDir"
POL_Download "$SITE/divers/installer_geoplan-geospace.exe" "e114c0ef1d9bcf8100cab110cc409c05"
POL_Call POL_Install_LunaTheme
POL_Wine_WaitBefore "$TITLE"
POL_Wine "installer_geoplan-geospace.exe"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "GeoplanGeospace.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKksK0ACgkQ5TH6yaoTykfmGQCcDCxthfeJipHjvFHrTGYyick7
UC8AniHLQubSIZ1pSKkREbjNOfAUYM2/
=9k8V
-----END PGP SIGNATURE-----
