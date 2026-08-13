#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: Fekir And GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-04-25 09:41 GMT-6) Wine 9.0 x64 / Linux Mint 21.3 x86_64
  The following features have been updated:
    + Wine version 1.7.31 - 9.0
    + System version: Windows XP - Windows 7
  Added the following features: 
    + Category: Graphics
[Fekir] (2014-12-25 22:21) Wine 1.7.31 x64 / Debian 8 Jessie x86_64
  Script creation:
    + Wine version: 1.7.31 
    + System version: Windows XP
    + Architecture: 32bits

REFERENCE
GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/topic-12649-script_Photoscape.html
GuerreroAzul: Link Download. - http://photoscape.org/ps/main/download.php
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="Photoscape"
PREFIX="photoscape"
CATEGORY="Graphics;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="Fekir And GuerreroAzul"
COMPANY="Mooii Tech"
HOMEPAGE="http://photoscape.org/"
LOGO="https://i.imgur.com/nUMPqGI.png"
BANNER="https://i.imgur.com/Di6W76j.png"
DOWNLOAD_URL="https://archive.org/download/photo-scape-setup-v-3.7_202202/PhotoScapeSetup_V3.7.exe"
FILE_INSTALL="PhotoScapeSetup_V3.7.exe"
MD5_CHECKSUM="b7cc1eb9650ff6a6a3cb5260efd7226f"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init
POL_Debug_Init

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
POL_Wine_reboot

# Shortcut
POL_Shortcut "$TITLE.exe" "$TITLE" "" "" "$CATEGORY"
POL_Shortcut_QuietDebug "$TITLE"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZit1yQAKCRDlMfrJqhPK
RwENAJ9uLQusda6pKkSVWLtsLHTASLAjigCgomWC6KRUPnoFzVMN2di2c+GofNQ=
=t9wg
-----END PGP SIGNATURE-----
