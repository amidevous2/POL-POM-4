#!/bin/bash
# Date : (2013-02-01)
# Last revision : (2013-02-01)
# Distribution used to test : Kubuntu 12.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="ImgBurn"
WINEVERSION="1.4.1"
TITLE="ImgBurn"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Lightning UK!" "http://www.imgburn.com" "RoninDusette" "ImgBurn"

# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies

# Configuration
Set_OS "winxp"
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Installation
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file. DO NOT CHECK RUN IMGBURN AT END OF INSTALLATION:')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
GC_DONT_GC=1 POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "imgburn.exe" "ImgBurn"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: POL does not condone piracy. Please use $TITLE in a respectable manner')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRL+fUACgkQ5TH6yaoTykf9WgCeJG6SOcP4TccJqiRdSfvTZ+So
+ZwAn3dy6CSbjpdoHH8eotk/cp226xEc
=s8Vv
-----END PGP SIGNATURE-----
