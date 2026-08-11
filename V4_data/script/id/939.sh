#!/bin/bash
# Wine version used : 1.2
# Author : Tinou

#
# CHANGELOG:
# [Dadu042] (2000 ?)
#   First script.
# [Dadu042] (2019-12-24)
#   Add shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rayman 2 - The Great Escape"
PREFIX="Rayman2"

POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Ubisoft" "" "Tinou" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
cd $CDROM
POL_Call POL_Install_dinput
POL_Wine "$CDROM/setup.exe"
POL_Wine_WaitExit
 
POL_Shortcut "Rayman2.exe" "Rayman 2 - The Great Escape" "" "" "Game;"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgI90gAKCRDlMfrJqhPK
R+1OAJkBjnoLI2UVIJiCie3MTiiSoVvd8gCgnOMyY9PjCYaqBLghaMTnGteJTeE=
=IARC
-----END PGP SIGNATURE-----
