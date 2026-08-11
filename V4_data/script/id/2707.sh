#!/bin/bash
# Date : (2016-01-13)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Kubuntu 18.04 x64
# Author : Arcadien (arc@arcadien.net)
#
# CHANGELOG
# [Arcadien] (2016-01-13)
#   Initial script.
# [Dadu042] (2019-05-23)
#   Make use of POL's features gdiplus and flashplayer.
# [Dadu042] (2020-01-29 22:00)
#   Wine 1.9.24 (outdated) -> 3.0.3
#   Fix POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Dofus"
PREFIX="Dofus"
WORKING_WINE_VERSION="3.0.3"
  
# Start the script
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Ankama Game" "http://www.dofus.com/" "andykimpe" "$PREFIX"
  
# Dotnet20 cannot be installed on a 64 bit system
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_Install_dotnet40
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2010

cd "$POL_USER_ROOT/ressources/"


POL_Call POL_Install_gdiplus

cd "$WINEPREFIX/drive_c/Tmp"
  

# Overriding dlls
POL_Wine_OverrideDLL "native" "gdiplus"
#WINE=POL_Wine
#winetricks comctl32

POL_Call POL_Install_flashplayer

cd "$POL_System_TmpDir"
POL_Download "http://dl.ak.ankama.com/games/installers/dofus.exe"
INSTALLER="dofus.exe"
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
  
POL_Shortcut "Dofus.exe" "$TITLE" "" ""  "Game;"
POL_SetupWindow_Close
  
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH+YAAKCRDlMfrJqhPK
R1TcAJoCP1wA7z4a4AckqT7BTXhAUJz6FACfbKxteXHs51XwUMA4lXXAsEVszUk=
=5NDx
-----END PGP SIGNATURE-----
