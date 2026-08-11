#!/bin/bash
# Date : (2015-08-29 23-30)
# Distribution used to test : Linux Mint 17 Cinnamon 32-bit
# Author: Vladislav Khomenko
# Licence : GPLv3
# Wine version used: 2.22


# CHANGELOG
# [Vladislav Khomenko] (2015-08-29 23-30)
#   First script.
# [Dadu042] (2019-11-28)
#   Wine 1.7.48-staging -> 2.22
#   + App categories

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="PhotoshopCC2014"
# Wine Version in which the installation runs without errors
WINE_FOR_INSTALL="2.22"
# Wine Version in which Photoshop starts and runs successfully
WINE_FOR_RUNNING="2.22"
TITLE="Adobe Photoshop CC 2014"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="Vladislav Khomenko"
 
 
  
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/PhotoshopCS6/top.jpg" "http://files.playonlinux.com/resources/setups/PhotoshopCS6/left.jpg" "$TITLE"
POL_SetupWindow_Init
         
POL_Debug_Init
 
 
         
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Do not click the "Launch now" at the end of the installation. It is not going to work.')" "$TITLE"
  
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_FOR_INSTALL"
POL_System_TmpCreate "$PREFIX"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "http://download.adobe.com/pub/adobe/photoshop/win/cc/AdobePhotoshop2014-32bit-mul.zip" "586f2c7f8cf5e87cbaf46b3115d0a43d"
        POL_System_unzip AdobePhotoshop2014-32bit-mul.zip -d $POL_System_TmpDir/photoshop
        INSTALLER="$POL_System_TmpDir/photoshop/Set-up.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
fi
 
# Configuration
Set_OS "win7"
  
  
#Dependencies
POL_Call POL_Install_atmlib
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_FontsSmoothRGB
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_gecko
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
  
 
 
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

#Select the version wine fo running. We perform the same steps that POL_Wine_PrefixCreate,
# but avoid the window with the message that prefix already exists
POL_Wine_InstallVersion "$WINE_FOR_RUNNING"
POL_Wine_SetVersionPrefix "$WINE_FOR_RUNNING"
POL_Wine_AutoSetVersionEnv
POL_Debug_InitPrefix
wine wineboot
POL_LoadVar_PROGRAMFILES
[ -e "$POL_USER_ROOT/configurations/post_prefixcreate" ] && \
source "$POL_USER_ROOT/configurations/post_prefixcreate"
 
  
POL_System_TmpDelete
   
# Create Shortcuts
POL_Shortcut "photoshop.exe" "$TITLE" "" "" "Graphics;RasterGraphics;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeDoxAAKCRDlMfrJqhPK
R+O8AJ99/maAJ2X6Zymc9pagOuLMMb5EpACfV6RS2kGJftonWOj+MG2GqWV7Bvg=
=eP2N
-----END PGP SIGNATURE-----
