#!/bin/bash
# Date : (2014-10-20)
# Distribution used to test : Arch Linux 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.8
#
# CHANGELOG
# [RoninDusette] (2014-10-20)
#   First script.
# [Dadu042] (2019-12-30)
#   Wine "1.7.46-staging" -> 3.0.3
#   Fixes.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
PREFIX="IndesignCS6"
WINEVERSION="3.0.3"
TITLE="Adobe InDesign CS6"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="RoninDusette"
       
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2316
       
POL_Debug_Init
       
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "winxp"
 
#Dependencies
POL_Call POL_Install_AdobeAir
POL_Call POL_Install_atmlib
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error saying that the installation failed, wait at least 5 minutes before closing it. PlayOnLinux will finish the install, even though it crashed.')" "$TITLE"
 
 
# Installation
Set_OS "win7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
# Create Shortcuts
POL_Shortcut "indesign.exe" "$TITLE" "" "" "Graphics;"
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsxlgAKCRDlMfrJqhPK
R7yFAJ9IlSi4p/yen8NndzdX7odZwmjNbwCfZsw/AJeP5gFvbO3nIASk/h+sRbA=
=8cuS
-----END PGP SIGNATURE-----
