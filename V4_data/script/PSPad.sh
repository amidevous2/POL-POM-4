#!/bin/bash
# Date : (2018-09-30 10-08)
# Last revision : (2018-09-30 10-08)
# Author : Kaavi.98
     
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
TITLE="PSPad"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "PSPad" "Radim Fiala" "http://www.pspad.com" "Kaavi.98" "PSPad"

POL_System_TmpCreate "PSPad"
     
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
     
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "PSPad Installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://pspad.poradna.net/release/pspad500_setup.exe"
    INSTALLER="$POL_System_TmpDir/pspad500_setup.exe"
fi
     
POL_Wine_SelectPrefix "PSPad"
POL_Wine_PrefixCreate
     
POL_SetupWindow_wait "Installation in progress." "PSPad Installation"
POL_Wine "$INSTALLER"
     
POL_System_TmpDelete
     
POL_Shortcut "PSPad.exe" "PSPad"
     
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRhK+wAKCRDlMfrJqhPK
R2g2AJwKIDK9UUFDDDweDV8Hjv9x7VKzlACfQfIHfen3yepG+X5+QNOmBc4q8a4=
=pTz2
-----END PGP SIGNATURE-----
