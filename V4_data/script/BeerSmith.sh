#!/usr/bin/env playonlinux-bash
# Date : (2018-10-25 17-37)
# Last revision : (2018-10-25 17-37)
# Wine version used :
# Distribution used to test : Fedora
# Author : etrunko

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="BeerSmith"
PREFIX="$TITLE"
VERSION="3_0_8"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bradley J Smith" "http://beersmith.com" "etrunko" "$PREFIX"

POL_Wine_SelectPrefix "$TITLE"
POL_Wine_PrefixCreate

cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
POL_Download "https://s3.amazonaws.com/beersmith-3/BeerSmith$VERSION.exe"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "BeerSmith$VERSION.exe"

POL_Shortcut "BeerSmith3.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXO8AUQAKCRDlMfrJqhPK
R9tLAJoCnFro/gWac9SM1+w16G31QKq8SQCgqezZdMfbhaFBdw+6KldaMv9hryQ=
=0o3r
-----END PGP SIGNATURE-----
