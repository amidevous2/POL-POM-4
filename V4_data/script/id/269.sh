#!/usr/bin/env playonlinux-bash
# Date : (2010-01-03 10-00)
# Last revision : (2019-12-14 07-04)
# Wine version used : 4.0.3
# Distribution used to test : Linux Mint 19.2
# Author : Tinou ,congelli501, NSLW

# CHANGELOG
# [SuperPlumus] (2013-07-08 11-01)
#   Update POLv3 -> POLv4
# [Yaotl] (2019-12-14 07-04)
#   Fix invalid URL
#   Update Wine to 4.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Inno Setup"
PREFIX="InnoSetup"
WINEVERSION="4.0.3"

POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/inno_setup/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 269
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "JR Software" "http://www.jrsoftware.org/isinfo.php" "Tinou" "$PREFIX"

POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://www.jrsoftware.org/download.php/is.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "is.exe" /SILENT /DIR="C:\Program Files\Inno Setup"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "Compil32.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfSSogAKCRDlMfrJqhPK
Rx9zAJ4tKkbcCupvPTnEYKNEvoteAHgJCwCcDlGD4+vGAJPCL7lkpUd/k3QJBIo=
=4ud5
-----END PGP SIGNATURE-----
