#!/usr/bin/env playonlinux-bash
# Date : (2015-6-10)
# Last revision : (2015-6-10)
# Wine version used :1.7.44
# Distribution used to test : Ubuntu 14.04 LTS
# Author : dhancock

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Photomatix Pro 5"
PREFIX="PhotomatixPro5"
WINEVERSION="1.7.44"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "HDR Soft" "http://www.hdrsoft.com/" "DHancock" "$TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_dotnet20
POL_Call POL_Install_gecko

POL_System_TmpCreate "photomatix"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "Photomatix installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://photomatix-en.s3.amazonaws.com/PhotomatixPro505ax32.exe"
    INSTALLER="$POL_System_TmpDir/PhotomatixPro505ax32.exe"
fi

POL_SetupWindow_wait "$(eval_gettext 'Installation in progress.')" "$TITLE installation"
POL_Wine "$INSTALLER"

POL_System_TmpDelete

POL_Shortcut "PhotomatixPro.exe" "PhotomatixPro"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlV5B2cACgkQ5TH6yaoTykfppgCeNrfqkwFHK4JNET0pCIEeP80v
WUYAoIYsnzQmh2AXmIFc0Icvt20qWyzu
=uRRd
-----END PGP SIGNATURE-----
