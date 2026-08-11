#!/usr/bin/env playonlinux-bash
# Date : (2016-06-06 12-00)
# Last revision : (2016-06-06 12-00)
# Wine version used : 1.9.7
# Distribution used to test : Mint 17
# Author : Alsitair Leslie-Hughes

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Enterprise Architect"
PREFIX="EnterpriseArchitect"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Sparx Systems" "http://www.sparxsystems.com" "Sparx Systems" "$PREFIX"

POL_System_TmpCreate "$PREFIX"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "Enterprise Architect installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.sparxsystems.com/bin/codeweavers-static/easetup.msi"
    INSTALLER="$POL_System_TmpDir/easetup.msi"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_Call POL_Install_corefonts
POL_Call POL_Install_msxml3

# WORKAROUND the fact that msxml4 and msxml6 doesn't override the DLL before/after installing.
POL_Wine_OverrideDLL "native" "msxml4"
POL_Call POL_Install_msxml4

POL_Wine_OverrideDLL "native" "msxml6"
POL_Call POL_Install_msxml6

POL_Call POL_Install_mdac28

Set_OS "winxp"

POL_SetupWindow_wait "Installation in progress." "Enterprise Architect installation"
POL_Wine msiexec /i "$INSTALLER"

POL_Shortcut "EA.exe" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNXU2gAKCRDlMfrJqhPK
R7ZpAJ9x/6tIpvdZpNBaB1Vp9bOqGQ7ihwCcCKbpnrybq4KDSSDfVCbqF57vm2U=
=ncHK
-----END PGP SIGNATURE-----
