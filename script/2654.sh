#!/bin/bash
# Date : (2015-11-03)
# Last revision : (2015-11-03)
# Wine version used : 1.7.54
# Distribution used to test : Linux Mint 17.1 Rebecca
# Author : NiK (http://hldm.org)
# PlayOnLinux:  playonlinux-4.1.9

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Vegas Pro 8.0"
PREFIX="VegasPro8"
WORKING_WINE_VERSION="1.7.54"
PUBLISHER="Sony Creative Software"
GAME_URL="http://www.sonycreativesoftware.com/"
AUTHOR="NiK"

# Setup
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_SetArch "x86"
Set_OS "win7"

# Components
POL_Call "POL_Install_dotnet30"
POL_Call "POL_Install_vcrun2005"

# Download QuickTime
POL_Download "https://secure-appldnld.apple.com/QuickTime/031-08466.20141022.Xwlnm/QuickTimeInstaller.exe"
POL_Wine "QuickTimeInstaller.exe"

# Download msvfw32 and msvideo from http://www.dlldump.com/
cd "$WINEPREFIX/drive_c/windows/system32"
POL_Download "http://www.dlldump.com/zip/dllfiles/M/msvfw32.zip"
unzip msvfw32.zip && rm msvfw32.zip
POL_Download "http://www.dlldump.com/zip/dllfiles/M/msvideo.zip"
unzip msvideo.zip && rm msvideo.zip

POL_Wine_OverrideDLL "native" "msvfw32" "msvideo"

# Installation
POL_SetupWindow_browse "$(eval_gettext "Please select the install file.")" "$TITLE"
SETUP_PATH="$APP_ANSWER"
POL_SetupWindow_wait "$(eval_gettext 'PlayOnLinux is installing your application...')" "$TITLE"
POL_Wine "$SETUP_PATH"
POL_Wine_WaitExit
POL_Shortcut "vegas80.exe" "Vegas Pro 8"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlY9GYMACgkQ5TH6yaoTykeyegCgiA14Af81BWFU1yvBLLEiFdnZ
ligAnRCHdQyzyoZ7t8eIBQn4j2znLhBG
=XOtw
-----END PGP SIGNATURE-----
