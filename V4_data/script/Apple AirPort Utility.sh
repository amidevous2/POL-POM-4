#!/usr/bin/env playonlinux-basho
#
# Date : (2015-26-05 18-47)
# Last revision : (2015-26-05 18-47)
# Wine version used : 1.7.17
# Distribution used to test : Ubuntu 14.04
# Author : endorama
   
# CHANGELOG
# [endorama] (2015-26-05 16-06)
#    First implementation

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="AppleAirPortUtility"
TITLE="Apple AirPort Utility"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Apple" "https://support.apple.com/kb/DL1547" "Edoardo Tenani" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'For more information see') https://appdb.winehq.org/objectManager.php?sClass=version&iId=27711&iTestingId=84252" "$TITLE"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    cd "$POL_System_TmpDir"
    POL_Download "https://support.apple.com/downloads/DL1547/en_US/AirPortSetup.exe" "1b7a3379b0e4097419b55465dd35aa57"
    INSTALLER="$POL_System_TmpDir/AirPortSetup.exe"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate

Set_OS "win7"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"

POL_System_TmpDelete
 
POL_Shortcut "APUtil.exe" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVkpEIACgkQ5TH6yaoTykc4FQCcDOnn0/xow2jhEjAnUHvPYPDs
hYwAniZ4PF8aFd3XJAkxGb8KqXUWqQtY
=Qlkz
-----END PGP SIGNATURE-----
