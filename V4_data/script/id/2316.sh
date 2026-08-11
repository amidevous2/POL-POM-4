#!/usr/bin/env playonlinux-bash
# Date : (2014-10-20)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# CHANGELOG
# [Ronin Dusette] (2014-10-20)
#   First script.
# [Dadu042] (2019-05-20)
#   Change Wine version (easier for newbies, because 4.0 is the latest available from POL 4.2.12)
#   Warn POL version.
# [Dadu042] (2019-05-17)
#   Wine 4.0 -> 3.21 (I fix my mistake because POL 4.2.12 does not support Wine 4)
# [Dadu042] (2019-11-28)
#   Standardize Changelog.
#   POL_RequiredVersion 4.2.12 (support Wine 3.0.3 max) -> 4.3.4
#   Remove useless msxml3 (because msxml6 is also installed).
#   Fix app categories.
# [Dadu042] (2020-02-01 11:00)
#   Wine 3.21 -> 3.20 (I fix my mistake because POL 4.2.x does not support Wine v3.21)
#   POL_RequiredVersion 4.3.4 -> 4.1.0
#   Standardize POL_Install_AdobeAir

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
          
PREFIX="PhotoshopCS6"
WINEVERSION="3.20"
TITLE="Adobe Photoshop CS6"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="Ronin Dusette, Dadu042"
 
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_SetID 2316
          
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Dependencies
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
    
   
# Installation Adobe Air

POL_Call POL_Install_AdobeAir

    
# Installation

POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error saying that the installation failed, wait at least 5 minutes before closing it. PlayOnLinux will finish the install, even though it crashed.')" "$TITLE"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
# Create Shortcuts
POL_Shortcut "photoshop.exe" "$TITLE" "" "" "Graphics;RasterGraphics;"
    
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"

POL_System_TmpDelete

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYDJRSQAKCRDlMfrJqhPK
R1KrAJ9Ka2RJB9qXz6mAr4OZrLwwuZ5HDQCgiBpfwGkA66/GU3qJLCRPveoSnGY=
=9uud
-----END PGP SIGNATURE-----
