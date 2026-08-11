#!/bin/bash
# Date : (2016-10-28)
# Distribution used to test : Ubuntu 16.04 x64
# Author : TheNets.org
# Licence : GPLv3
# PlayOnLinux: 4.2.10
#
# CHANGELOG
# [TheNets.org] (2016)
#   First script base on Ronin Dusette's script for CS6.
# [Dadu042] (2019-11-28)
#   Wine "1.7.41-PhotoshopBrushes" -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
PREFIX="PhotoshopCC"
WINEVERSION="2.22"
TITLE="Adobe Photoshop CC 2015"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="TheNets.org"

# Based on RoninDusette's script
# from https://www.playonlinux.com/en/app-2316-Adobe_Photoshop_CS6.html
       
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2316
       
POL_Debug_Init
       
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "winxp"
 
#Dependencies
POL_Call POL_Install_atmlib
POL_Call POL_Install_corefonts
POL_Call POL_Install_FontsSmoothRGB
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6
POL_Call POL_Install_tahoma2
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_vcrun2012
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error saying that the installation failed, wait at least 5 minutes before closing it. PlayOnLinux will finish the install, even though it crashed.')" "$TITLE"
 
 
# Installation
Set_OS "win7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
# Create Shortcuts
POL_Shortcut "photoshop.exe" "$TITLE" "" "" "Graphics;RasterGraphics;"
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeDqXAAKCRDlMfrJqhPK
R79UAJ0Xz+m9srb8BD4k7T6ZXSnV8dFNSACgpmKf7nxHdaYULHRStyD4H3P7/Ug=
=AKck
-----END PGP SIGNATURE-----
