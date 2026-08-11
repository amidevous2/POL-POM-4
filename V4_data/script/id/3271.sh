#!/usr/bin/env playonlinux-bash
# Date : 2017-11-26
# Last revision : 2017-11-26-2
# Wine version used : 1.7.55
# Distribution used to test : Ubuntu 10.04 LTS
# Author : rlarjsdn122
#
# CHANGELOG
# [rlatrjsdn122] (2019-05-10 20-36)
#   Initial writting.
# [Dadu042] (2019-05-23 09-58)
#   Disable file checksum checking because the game receive many updates. URL is dead (to repair).
# [Dadu042] (2020-01-03 22:11)
#   Update download URL.
#   Fix POL_Shortcut.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Tanki X"
PREFIX="tankix"
   
POL_SetupWindow_Init
  
POL_SetupWindow_presentation "$TITLE" "AlternativaPlatform" "https://www.tankix.com/" "rlarjsdn122" "$PREFIX"
  
POL_SetupWindow_Init
  
POL_SetupWindow_message "NOTE! : This script is NOT stable." "Welcome"
  
POL_System_TmpCreate "tankixtemp"
  
POL_Wine_SelectPrefix "$PREFIX"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
   POL_SetupWindow_browse "Select installation program" "File selection"
   INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
   cd "$POL_System_TmpDir"
   POL_Download "http://static.tankix.com/app/StandaloneWindows/master-48606/TankiXSetup.exe"
   INSTALLER="$POL_System_TmpDir/TankiXSetup.exe"
fi
  
POL_Wine_PrefixCreate
Set_OS "win7"

POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11
  
POL_Wine_OverrideDLL "" "d3d11"
  
POL_SetupWindow_wait "Please wait" "Installation in progress"
POL_Wine "$INSTALLER"
  
POL_System_TmpDelete
  
POL_Shortcut "tankix.exe" "Tanki X" "" "" "Game;ActionGame;"
  
POL_SetupWindow_message "Enjoy your tanks!."
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg+uOQAKCRDlMfrJqhPK
R7XCAJ9hiSh5HT+Ugkcf9AKywU2FmH3tPgCghObjP2XAc5hfOwSmH7F1MlCMYRA=
=HRPC
-----END PGP SIGNATURE-----
