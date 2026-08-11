#!/bin/bash
#Vérifier que PlayOnLinux est bien exécuté avant
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
TITLE="Dark Age of Camelot"
PREFIX="DAoC"
 
POL_SetupWindow_Init
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "Mythic" "http://www.darkageofcamelot.com/" "Tr4sK" "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  POL_SetupWindow_browse "Please select the installation file to run." "$TITLE"
  INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
  cd "$POL_System_TmpDir"
  POL_Download "http://www.darkageofcamelot.com/sites/daoc/files/downloads/DAoCSetup.exe"
  INSTALLER="$POL_System_TmpDir/DAoCSetup.exe"
fi

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win7"
POL_Wine_InstallFonts
POL_Call POL_Install_d3dx9

POL_SetupWindow_wait "Installation in progress…" "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "camelot.exe" "$TITLE"

POL_SetupWindow_Close 
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXVQmuQAKCRDlMfrJqhPK
R/w+AJ9fMohJpwzMlpYWk/PpCVmu77XBxACgljxl6UfGf/FXWF/g8kb0fJoZy4A=
=o6A7
-----END PGP SIGNATURE-----
