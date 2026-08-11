#!/bin/bash
 
# Date : (2015-11-09 22-49)
# Last revision : (2019-06-02 10-29)
# Wine version used :
# Distribution used to test : Debian Jessie
# Author : Majenko Technologies
 
POL_Debug_Init
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="4D Workshop"
PREFIX="4DWorkshop"
  
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "4D Systems" "http://www.4dsystems.com.au/product/4D_Workshop_4_IDE/" "Majenko Technologies" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
POL_System_TmpCreate "$PREFIX"
POL_Call POL_Install_gdiplus
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file to run.')" "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.4dsystems.com.au/downloads/Software/4D-Workshop4-IDE/WORKSHOP4%20INSTALLER.4.5.0.17b.exe"
    POL_Wine start /unix "$POL_System_TmpDir/WORKSHOP4%20INSTALLER.4.5.0.17b.exe"
    POL_Wine_WaitExit "$TITLE"
fi
POL_System_TmpDelete
 
POL_Shortcut "WORKSHOP4.exe" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPOI5wAKCRDlMfrJqhPK
R4umAJ45B5nxe1Rd18OFUQ2o+TqmIE/tsQCfeNFIOOEsv5ANcTxS7O8ofx0uOuQ=
=qmJM
-----END PGP SIGNATURE-----
