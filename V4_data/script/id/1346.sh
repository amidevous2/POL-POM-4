#!/bin/bash
# Date : (2012-08-04 18-10)
# Last revision : (2013-12-27 00-16)
# Wine version used : 1.5.5, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-08-04 18-10)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.1 -> 2.22
#   Force Arch x86.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="darkstone"
PREFIX="Darkstone_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Darkstone"
SHORTCUT_NAME="Darkstone"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1346
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Delphine Software International / VectorCell" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "aa49088df618fc83b9d25ff72ec387a2"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# native devenum => black screen!
POL_Call POL_Install_quartz
POL_Call POL_Install_amstream
POL_Call POL_Install_wmp9

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Darkstone.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-32bit" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Darkstone/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwmkgAKCRDlMfrJqhPK
RwPVAJ9X5dU3ncptwb3gOwxXx82c7ybgwACfQRrSILHFEi29I1cObZV6bHs8OmQ=
=6dv1
-----END PGP SIGNATURE-----
