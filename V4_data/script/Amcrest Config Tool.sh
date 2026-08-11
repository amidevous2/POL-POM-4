#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-04-13 12:00 GMT-6) Wine 9.0 x64 / Linux Mint 21.3 x86_64
  Creation of the script

REFERENCE
GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
GuerreroAzul: Link Download. - https://support.amcrest.com/hc/en-us/categories/201939038-All-Downloads
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Amcrest IP Config"
PREFIX="amcrestipconfig"
CATEGORY="Accesories"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="GuerreroAzul"
COMPANY="© Amcrest"
HOMEPAGE="https://support.amcrest.com/hc/en-us"
LOGO="https://i.imgur.com/rKUYWaI.png"
BANNER="https://i.imgur.com/Di6W76j.png"
DOWNLOAD_URL="https://s3.amazonaws.com/amcrest-files/Amcrest_ConfigTool_Eng_V3.20.10.T.180715.exe"
FILE_INSTALL="Amcrest_ConfigTool_Eng_V3.20.10.T.180715.exe"
MD5_CHECKSUM="3430e0f7f86d6ea2453d6a44736ceebc"


#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init

# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"

# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"

# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

#Dependencies

# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"
  POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"
  INSTALLER="$POL_System_TmpDir/$FILE_INSTALL"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
fi

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

# Shortcut
POL_Shortcut "$TITLE.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZiDYkAAKCRDlMfrJqhPK
RyzYAKCfCT+VolC7FcavssTNRGxJOo1ekACfUwFN5Wr6lpWFmzhFqZ6zV8/KB08=
=avQa
-----END PGP SIGNATURE-----
