#!/bin/bash
# Date : (2015-12-23 20-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Fedora 23
# PlayOnLinux: 4.2.9
# Author : andykimpe
#
#
# CHANGELOG:
# [andykimpe] (2015-12-23 20-00)
#   First script (Wine 1.4.1).
# [Dadu042] (2019-12-24)
#   Wine 2.0 -> 2.22
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Railroad Pioneer"
PREFIX="Railroad_Pioneer"
WORKING_WINE_VERSION="2.22"
 
# Start the script
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "JoWooD Entertainment." "https://wikipedia.org/wiki/JoWooD_Entertainment" "andykimpe" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
 
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "Setup.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$CDROM/Setup.exe"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_VMS "256"
Set_Managed "Off"
 
POL_Shortcut "Railroad.exe" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgI6owAKCRDlMfrJqhPK
RyD8AJ9d2ITFRGOmdybMKaJ6+N/rCqjPNwCfTYB3iaH8n+hAN13RJOHO/ROOEbY=
=r/jb
-----END PGP SIGNATURE-----
