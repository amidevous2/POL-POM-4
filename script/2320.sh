#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
 
cfg_check
 
TITLE="Moebius"
PUBLISHER="Fa. Ellen Hoche, Lehr- und Lernmittel"
WEBSITE="http://www.mintext.de/"
AUTHOR="ramon1611"
PREFIX="moebius"
 
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$WEBSITE" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.6"
 
POL_System_SetArch "x86"
POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
POL_Wine_Direct3D "Multisampling" "enabled"
POL_Wine_X11Drv "Managed" "Y"
Set_OS "winxp" "sp2"
 
POL_Call POL_Install_gdiplus
POL_Call POL_Install_LunaTheme
POL_Call POL_Install_corefonts
 
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_question "Do you have downloaded the moebius installation file?" "Download?"
    if [ "$APP_ANSWER" = "FALSE" ]
    then
        POL_Browser "$WEBSITE"
    fi
     
    POL_SetupWindow_browse "Select Moebius installation file!" "File selection"
    SetupFile="$APP_ANSWER"
     
    POL_Wine start /unix "$SetupFile"
    POL_Wine_WaitExit "$TITLE"
#elif [ "$INSTALL_METHOD" = "CD" ]
#then
#    POL_SetupWindow_cdrom
#    POL_SetupWindow_check_cdrom "moeb-setup.exe"
#    
#    POL_SetupWindow_wait "Installation in progress." "$TITLE installation"
#    POL_Wine start /unix "$CDROM/moeb-setup.exe"
fi
 
POL_Shortcut "Program Files/Moebius/moebius.exe" "$TITLE"
 
POL_SetupWindow_reboot
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPPFvwAKCRDlMfrJqhPK
R7aFAJwNIrc2bQntoGDJCuUjX/7BeMrSGQCfVSfmNf+bZA/bFjH8V/OWVrpJCDg=
=T1+N
-----END PGP SIGNATURE-----
