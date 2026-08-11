#!/usr/bin/env playonlinux-bash
# Date : 2020-09-16
# Last revision : 2020-09-16
# Wine version used : 5.7
# Distribution used to test : macOS Catalina 10.15.6 and PlayOnLinux 4.4.1
# Distribution used to test : Ubuntu 20.04 x86_64 5.4.0 and PlayOnLinux 4.3.4 and Wine 5.7
# Author : Andrea Denzler
source "$PLAYONLINUX/lib/sources"
 
TITLE="AndreaMosaic"
PREFIX="AndreaMosaic"
AUTHOR="Andrea Denzler"
APP_URL="http://www.andreaplanet.com/andreamosaic"
EDITOR="Andrea Denzler"
 
# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "$AUTHOR" "$APP_URL" "$EDITOR" "$PREFIX"
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
# Installation - Determine if user wants to download or use a local copy.
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_message "$(eval_gettext 'Please be sure to use the Portable version of AndreaMosaic!')" "$TITLE"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX" # Create temp folder
    cd "$POL_System_TmpDir"
    # Ask if Beta ora Stable version
    POL_SetupWindow_question "$(eval_gettext 'Do you want to try the Beta version?')" "$TITLE"
    if [ "$APP_ANSWER" = "TRUE" ]
    then
       DOWNLOAD_URL="http://www.andreaplanet.com/andreamosaic/download.php?version=portablebeta"
       DOWNLOAD_FILE="download.php?version=portablebeta"
    else
       DOWNLOAD_URL="http://www.andreaplanet.com/andreamosaic/download.php?version=portable"
       DOWNLOAD_FILE="download.php?version=portable"
    fi
    POL_Debug_Message "Download URL is $DOWNLOAD_URL"
    POL_Debug_Message "Download File is $DOWNLOAD_FILE"
    POL_Download "$DOWNLOAD_URL"
    # Sometimes you get a feature transfer error or wine doesn't start if you do not rename this file to an .exe
    mv "$DOWNLOAD_FILE" AndreaMosaicPortable.exe
    INSTALLER="$POL_System_TmpDir/AndreaMosaicPortable.exe"
fi
 
# Extract files from Portable version in silent mode. License is not shown.
POL_Debug_Message "Installer file is $INSTALLER"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER" -s -dC:\\AndreaMosaic\\
POL_Wine_WaitExit "$TITLE"
 
# Free downloaded file
POL_System_TmpDelete
 
# I need to show the license here because we installed the downloaded file in silent mode
LICENSE_FILE=$(find "$WINEPREFIX/drive_c/AndreaMosaic/" -name "license*.txt" | head -n 1)
POL_Debug_Message "License file is $LICENSE_FILE"
if [ -e "$LICENSE_FILE" ]; then
   POL_SetupWindow_licence "$(eval_gettext 'License')" "$TITLE" "$LICENSE_FILE"
fi
 
# Create Shortcut
POL_Shortcut "AndreaMosaicMenu.exe" "$TITLE" "" "" "Graphics"
 
# Exit
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX3C/rwAKCRDlMfrJqhPK
RwsFAKCsBn/JtkLVAfQaVDQ3p2hPF+omTwCY05MwO7Cf19f/XamyOmNsm+Y0fw==
=J30T
-----END PGP SIGNATURE-----
