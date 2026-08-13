#!/bin/bash
# Date : (2009-10-29 16-30)
# Last revision : (2013-05-14 19-18)
# Wine version used : 1.5.24
# Distribution used to test : N/A
# Author : thib25

# CHANGELOG
# [SuperPlumus] (2013-05-14 19-18)
#   Rewrite script
#   Update Wine version to 1.5.24
# [Dadu042] (2020-02-16)
#   Wine 1.5.24 -> system
# [Dadu042] (2020-02-27)
#   Hide old Wine version.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="rFactor"
PREFIX="rFactor"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ISI Simulation" "http://www.rfactor.net/" "thib25" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_Wine_PrefixCreate
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"


POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

POL_System_TmpDelete

POL_Shortcut "rFactor.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_message "$(eval_gettext "The CD protection of this game does not work correctly with Wine (2013).")" "$TITLE"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlfuVgAKCRDlMfrJqhPK
R88kAKCNrrevKLGvg+Zn9vYNtPNwQQSW4wCgkC0xFPEZo6ZW2ExNzoAP5huE+80=
=mWMw
-----END PGP SIGNATURE-----
