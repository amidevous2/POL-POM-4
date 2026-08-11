#!/bin/bash
# Date : (2018-11-13 01:00)
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Wine version used : 3.1
# Distribution used to test : Kubuntu 16.04 LTS
# Author : der Papst
# Licence : GPLv3
  
TITLE="W3D Hub Launcher installer"
PREFIX="w3d"
EDITOR="W3D"
GAME_URL="https://w3dhub.com/#/home"
AUTHOR="der Papst"
WORKING_WINE_VERSION="3.1"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_Install_dotnet461
 
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
POL_Wine "$APP_ANSWER"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlv5NnMACgkQ5TH6yaoTykd4cgCglf4Yx0Jt01IjxuGstPf8qsJ+
sSkAn20BvUIDlj4kPFkDWYp9H1lyI154
=Wh9o
-----END PGP SIGNATURE-----
