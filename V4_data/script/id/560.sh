#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2011-12-02 20-58)
#   Conversion v3 -> v4
# [Quentin PÂRIS] (2012-04-28 22-39)
#   Using dosbox instead of wine
# [Quentin PÂRIS] (2012-04-28 23-05)
#   Auto-closing dosbox
# [Quentin PÂRIS] (2012-04-29 17-41)
#   Fix CD-ROM Problems
# [Quentin PÂRIS] (2012-08-08 11-02)
#   Check PlayOnLinux version
# [SuperPlumus] (2013-12-08 18-53)
#   Update gettext messages

# Date : (2010-01-19 18-00)
# Last revision : (2013-12-08 18-53)
# Wine version used :
# Distribution used to test : N/A
# Author : Quentin PÂRIS

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Theme Hospital"
PREFIX="ThemeHospital"
WORKING_WINE_VERSION="1.4-dos_support_0.5"
export WINEDEBUG="-all"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions" "" "Wanama" "$PREFIX"

POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.18"


POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "CD"

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "autoset.exe"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"

    POL_Call POL_Install_DosboxDrive

    cd "$CDROM/DOSSETUP"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "SETUP.EXE"
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
fi

POL_Shortcut "HOSPITAL.EXE" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKks/QACgkQ5TH6yaoTykcu8ACgnfaLYZyzDkLdPK2I1GqDKPGG
OqsAoIW+ErcKMurYoawB/7fI/mrhzOhG
=H9w3
-----END PGP SIGNATURE-----
