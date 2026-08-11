#!/bin/bash
# Date : (2013-02-01)
# Last revision : (2013-02-01)
# Distribution used to test : Kubuntu 12.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9
  
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="GuitarRig5"
WINEVERSION="1.5.20"
TITLE="Guitar Rig 5"
  
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "Native Instruments" "http://www.native-instruments.com" "RoninDusette" "$PREFIX"
  
# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
  
#Dependencies
  
# Configuration
Set_OS "winxp"
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"
  
# Installation
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file. During installation, uncheck all extra drivers it wants to install:')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
GC_DONT_GC=1 POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
  
# Create Shortcuts
POL_Shortcut "Guitar\ Rig\ 5.exe" "$TITLE"
  
POL_SetupWindow_message "$(eval_gettext 'NOTICE: For low-latency audio, look into WineASIO.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRL+dkACgkQ5TH6yaoTykcBrACeKor38IYwRd3uHTXfeYFYqX+b
v0AAnjVpKydSqpcWCTpUlw/SdBIpskjc
=y1Q2
-----END PGP SIGNATURE-----
