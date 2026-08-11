#!/bin/bash
# Date : (2014-10-20)
# Distribution used to test : Linux Mint 18.3 Sarah 64-bit
# Author : AntuV
# Licence : GPLv3
# PlayOnLinux: 4.2.10
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
PREFIX="SIAP"
WINEVERSION="3.0"
TITLE="S.I.Ap"
EDITOR="A.F.I.P."
GAME_URL="http://www.afip.gob.ar"
AUTHOR="AntuV"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_System_TmpCreate "$PREFIX"

cd "$POL_System_TmpDir"
POL_Download "http://www.afip.gob.ar/aplicativos/siap/archivos/siap.zip" "3d4f630b77a8c32219400db84230e6e2"
unzip siap.zip
unzip Siap*.exe
INSTALLER_EXE="$POL_System_TmpDir/SETUP.EXE"

# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "winxp"

# Dependencies
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_FontsSmoothRGB

POL_Wine "$INSTALLER_EXE"

POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete
POL_Shortcut "siap.exe" "$TITLE"

POL_SetupWindow_Close
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNbfgAKCRDlMfrJqhPK
R963AJ46l86YpC7wHfM47PuDPXjOIFMYaQCfZaa+fDvz4B5HtvZ1urPQ/YQ2ENs=
=L4fy
-----END PGP SIGNATURE-----
