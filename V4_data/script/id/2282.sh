#!/bin/bash
# Last revision : (2014-09-24)
# Wine version used : 1.6.2, 2.22
# Author : almukantarat
# License : GNU/GPL v3

# CHANGELOG
# [almukantarat] (2014)
#   First script.
# [Dadu042] (201x)
#   Wine 1.6.2 -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Guide 9"
PREFIX="guide9"
WORKING_WINE_VERSION="2.22"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Project Pluto" "http://www.projectpluto.com/" "almukantarat" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_SetupWindow_InstallMethod "LOCAL"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup.exe file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine $SETUP_EXE

POL_Shortcut "guide9.exe" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXc1uGAAKCRDlMfrJqhPK
R4iiAJ9lZ/kIToclu+hGf0DWkijM3JUr3gCgg6bo9eLFPFJPaz1t6YhyN+6tsUM=
=q6EM
-----END PGP SIGNATURE-----
