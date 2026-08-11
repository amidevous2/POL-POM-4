#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-03-12 14:00 GMT-6) Wine 9.0 / Linux Mint 21.3 x86_64
  Update version wine: 8.6 --> 9.0
  Update version OS: win7 --> win10

[GuerrreroAzul] (2024-02-06 14:00 GMT-6) Wine 8.6 / Linux Mint 21.3 x86_64
  Creation of the script

REFERENCE
GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
GuerreroAzul: Link Download. - https://www.win-rar.com/download.html
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Winrar"
PREFIX="winrar"
CATEGORY="Accesories;"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="GuerreroAzul"
COMPANY="LABRAR®"
HOMEPAGE="https://www.win-rar.com/"
LOGO="https://i.imgur.com/fKDpsqH.png"
BANNER="https://imgur.com/2sJkq3I.png"
DOWNLOAD_URL="https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x32-700.exe"
FILE_INSTALL="winrar-x32-700.exe"
MD5_CHECKSUM="ec2c341f6c3d83620f63f614cfda8866"

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
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then 
  POL_Wine start /unix "$INSTALLER" /S
  POL_Wine_WaitExit "$INSTALLER"
else
  POL_Wine start /unix "$INSTALLER"
  POL_Wine_WaitExit "$INSTALLER"
fi

# Shortcut 
POL_Shortcut "$TITLE.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZhPlwgAKCRDlMfrJqhPK
R0pgAJ48Hi5RTILeA3kHAYejyhArC8LjQgCeITyhJ1HVa4rpgC3UZNsmEIfMaF4=
=4S1Z
-----END PGP SIGNATURE-----
