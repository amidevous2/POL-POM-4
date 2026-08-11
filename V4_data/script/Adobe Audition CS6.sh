#!/bin/bash
# Date : (2019-04-29)
# Version: 1.0
# Distribution used to test : Arch Linux (Manjaro w. DDE) 64-bit
# Author : oovyxd
# Licence : GPLv3
# PlayOnLinux: 4.2-1
  
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
        
PREFIX="AuditionCS6"
WINEVERSION="4.6"
TITLE="Adobe Audition CS6"
EDITOR="oovyxd"
GAME_URL="http://www.oovy.dev"
AUTHOR="oovyxd"
        
#Initialization
POL_GetSetupImages "http://rozn.yt/pol-resources/anyinstaller/top.jpg" "http://rozn.yt/pol-resources/anyinstaller/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2316
        
POL_Debug_Init
Set_OS "win7"
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies
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
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
  
# Create Shortcuts
POL_Shortcut "Adobe Audition CS6.exe" "$TITLE"
  
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and any 3D services do not work. If you want to update your install, you will need to download the update manually and install it in this virtual drive.')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlzNb1sACgkQ5TH6yaoTyke1BwCeLRYgYW7rgyOWrcTsJS7xbJcc
p/8AnjNTm0qhx0dO/FfIRYrDK6dreJzN
=0ky3
-----END PGP SIGNATURE-----
