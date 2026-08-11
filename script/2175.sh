#!/bin/bash
# Date : (2014-07-17 10-23)
# Last revision : (2014-07-17 18-26)
# Wine version used : 1.9.4
# Distribution used to test : Ubuntu 14.04 LTS
# Author : saimor
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Evolution 4"
PREFIX="Evolution4"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Evolution_4/top.png" "http://files.playonlinux.com/resources/setups/Evolution_4/left.png" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Evolution.it" "http://www.evolution.it/" "saimor" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.9.4"
   
POL_System_TmpCreate "$PREFIX"
   
POL_SetupWindow_InstallMethod "DOWNLOAD"
  
Set_OS "win7"
POL_Call POL_Function_FontsSmoothRGB
POL_Call POL_Install_vcrun6  
POL_Call POL_Install_gdiplus
POL_Call POL_Install_gecko
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml4
POL_Call POL_Install_msxml6
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
  
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    cd "$POL_System_TmpDir"
    POL_Download "http://evolution.it/files/SetupEvo4.exe"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
    POL_Wine "$POL_System_TmpDir/SetupEvo4.exe"
    POL_SetupWindow_wait "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"
fi
   
POL_System_TmpDelete
   
POL_Shortcut "evolution.exe" "$TITLE"
  
POL_SetupWindow_Close
  
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb6owgAKCRDlMfrJqhPK
R0pZAJ9ka+Ho06OuGOgJtDlEUQLgENBAtQCgsrx9ws8ucyf2tHwxRfCbNtcPRiw=
=45HZ
-----END PGP SIGNATURE-----
