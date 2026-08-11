#!/usr/bin/env playonlinux-bash

# CHANGELOG:
# theel0ja (2017-03-06)
#   First script.
# Dadu042 (2019-08-01)
#   Fix URL (dead). v4_3_10 -> v4_3_12.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
POL_SetupWindow_Init
  
POL_SetupWindow_presentation "LEGO Digital Designer" "The LEGO Group" "http://ldd.lego.com" "theel0ja" "LegoDigitalDesigner"
  
POL_System_TmpCreate "LegoDigitalDesigner"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "LEGO Digital Designer installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.lego.com/assets/franchisesites/ldd/installer/setupldd-pc-4_3_12.exe"
    INSTALLER="$POL_System_TmpDir/setupLDD-PC-4_3_12.exe"
fi
  
POL_Wine_SelectPrefix "LegoDigitalDesigner"
POL_Wine_PrefixCreate
  
POL_SetupWindow_wait "Installation in progress." "LEGO Digital Designer installation"
POL_Wine "$INSTALLER"
  
POL_System_TmpDelete
  
POL_Shortcut "LDD.exe" "LEGO Digital Designer"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUROtgAKCRDlMfrJqhPK
R0IoAJ92eJd9yzh6s8D2uEVAeU3cn0q25QCfWNBC++BKZLlHmWwM9UI54FU2c+c=
=bxut
-----END PGP SIGNATURE-----
