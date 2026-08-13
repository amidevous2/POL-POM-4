#!/usr/bin/env playonlinux-bash
  
# Date : (2016-09-13 21-27)
# Last revision : (2016-09-12 22-17)
# Wine version used : 1.6.2
# Distribution used to test : Ubuntu 16.04 LTS
# Author : Tiago Arnold <contato at radaction.com.br>
# Contributor : Varlyakov 
   
# CHANGELOG
# Updated version to 3.36
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Winbox"
WORKING_WINE_VERSION="3.0.3"
EDITOR="contato@radaction.com.br"
EDITOR_URL="http://www.radaction.com.br"
PREFIX="Winbox"
   
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "RADACTION ROUTING FREEDOM" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
POL_Call POL_Install_corefonts
  
mkdir -p "$WINEPREFIX/drive_c/Program Files/Winbox"
cd "$WINEPREFIX/drive_c/Program Files/Winbox"
POL_Download "https://download.mikrotik.com/winbox/3.36/winbox.exe" "ae0b5a345570a1317798d5b4bf61b012"
  
   
POL_Shortcut "winbox.exe"  "$TITLE"
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYqim0gAKCRDlMfrJqhPK
R/zkAJ0SLwMJPX6wDF5hXl2t27LZP2NaKwCfQ8jH5K8+c7Ik/Kjfe+fP5q9ccmg=
=T0Sz
-----END PGP SIGNATURE-----
