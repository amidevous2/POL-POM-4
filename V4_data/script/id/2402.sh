#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Configuration
TITLE="RomCenter"
WEBSITE="http://www.romcenter.com"
DEVELOPER="Eric Bole-Feysot"
AUTHOR="Rob Loach"
PREFIX="romcenter"
WINE_VERSION="1.7.34"
DOWNLOAD="http://www.romcenter.com/download/rc_3_7_1.exe"
DOWNLOAD_MD5="9f15807707bd0895d46290e526cdb308"
DOWNLOAD_SETUP="rc_3_7_1.exe"
SHORTCUT="romcenter.exe"

# Start up PlayOnLinux
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "$WEBSITE" "$AUTHOR" "$PREFIX"

# Create the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINE_VERSION"

# Select the installation method
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  # Select and run the file
  POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
  POL_SetupWindow_wait "Installation in progress." "$TITLE installation"
  POL_Wine_WaitBefore "$TITLE"
  POL_Wine start /unix "$APP_ANSWER"
  POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
  # Create a temporary directory
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"

  # Download the program
  POL_Download "$DOWNLOAD" "$DOWNLOAD_MD5"
  POL_SetupWindow_wait "Installation in progress." "$TITLE installation"

  # Run the setup
  POL_Wine_WaitBefore "$TITLE"
  POL_Wine start /unix "$POL_System_TmpDir/$DOWNLOAD_SETUP"
  POL_Wine_WaitExit "$TITLE"
  POL_System_TmpDelete
fi

# Create the Shortcut to the program
POL_Shortcut "$SHORTCUT" "$TITLE"

POL_SetupWindow_Close
exit1

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg6DgwAKCRDlMfrJqhPK
R7HJAKCeEYa+HW3/vM9vfZD1WYrTDxwC+QCeIL/+vd831sYwow0GZAwAJEyGMuI=
=wU9F
-----END PGP SIGNATURE-----
