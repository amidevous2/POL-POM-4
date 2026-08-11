#!/usr/bin/env playonlinux-bash       
 
# Date: 2020-06-18
# Last Revision: see changelog
# Wine version used 5.3
# Author: Samuel Greiner
# Script License: MIT
# Program License: proprietary
 
# References
# https://appdb.winehq.org/objectManager.php?sClass=version&iId=38454
#
# CHANGELOG
# [Samuel Greiner] (2020-06-18)
#   Initial script.
 
# ---------------------------------------------------------------------------------------------------------
 
# Initialization
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Buhl - WISO steuer:Sparbuch"
PREFIX="SteuerSparbuch2020"
WINEVERSION="5.3"
OSVERSION="win7"
 
POL_GetSetupImages "https://i.imgur.com/QXJA48Q.png" "https://i.imgur.com/8ipmM3A.png" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID
 
POL_SetupWindow_presentation "$TITLE" "Buhl Data Service" "http://www.buhl.de" "Samuel Greiner" "$TITLE"
 
POL_Debug_Init
 
 
# ---------------------------------------------------------------------------------------------------------
# Setup
 
POL_System_SetArch "x86"
POL_SetupWindow_InstallMethod "LOCAL"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run!')" "$TITLE"
SetupIs="$APP_ANSWER"
 
# ---------------------------------------------------------------------------------------------------------
 
# Prepare resources for installation
 
# NOTE: Install wine version if isn't available. This is necessary because
# even though "POL_Wine_PrefixCreate" solves this, we end up having
# problems when the required version is not available and it tries to
# install it! Questor
# [Ref.: https://github.com/PlayOnLinux/POL-POM-4/blob/master/lib/wine.lib]
POL_Wine_InstallVersion "$WINEVERSION"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
  
Set_OS "$OSVERSION"
 
POL_Install_corefonts
 
# ---------------------------------------------------------------------------------------------------------
# Install
POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"
 
# Create starter
POL_Shortcut "firefox.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully!\n\nThanks!\nBy Samuel Greiner')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXu38CQAKCRDlMfrJqhPK
R9VZAKClV06b8qUVx2CcM/h1QlYGyPXJEwCgmt0wWHiCzl3qH+ZxjD48AEn2Emo=
=TDA5
-----END PGP SIGNATURE-----
