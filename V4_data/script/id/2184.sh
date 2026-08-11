#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
POL_SetupWindow_Init
  
POL_SetupWindow_presentation "VideoScribe" "Sparkol" "http://www.videoscribe.co/" "Paradoxis" "MozillaFirefox"
  
POL_Wine_SelectPrefix "VideoScribe"
POL_Wine_PrefixCreate "1.7.22"
  
POL_System_TmpCreate "VideoScribe"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "VideoScribe"
    POL_SetupWindow_wait "Installation in progress." "VideoScribe installation"
    POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://cloud-files-cdn.sparkol.com/downloads/vs/20001/VideoScribe.msi"
    POL_SetupWindow_wait "Installation in progress." "VideoScribe installation"
    POL_Wine start /unix "$POL_System_TmpDir/VideoScribe.msi"
fi
  
POL_System_TmpDelete
  
POL_Shortcut "VideoScribeDesktop.exe" "VideoScribe"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPK/TIACgkQ5TH6yaoTykeWbQCfauF2zR6xQrUx+XzvlwQWG5iu
azUAn398UuClaun3RLPr6c2nAtbPgaHF
=RwWV
-----END PGP SIGNATURE-----
