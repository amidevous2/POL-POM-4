#!/bin/bash
# Date : (2014-01-29 ??-??)
# Wine version used : 4.0.2
# Distribution used to test : Ubuntu 19.04 amd64
# PlayOnLinux : 4.2.12
# Author : Joseph Hersey
  
# CHANGELOG
# [Joseph Hersey] (2014-01-29)
#   First script. Used Wine 1.7.11 x86
# [Dadu042] (2019-10-27)
#   Repaired the installer
#   Architecture x86 -> auto
#   REQ POL v4.3.4+
#   Wine system -> 4.0.2

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="Pirate101-t"
TITLE="Pirate 101"
EDITOR="KingsIsle Entertainment, Inc."
GAME_URL="https://www.pirate101.com"
AUTHOR="Joseph Hersey"
WORKING_WINE_VERSION="4.0.2"

# Initialization
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1935
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"

# Determine Architecture
POL_System_SetArch "auto"
# POL_System_SetArch "x86"

POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_gecko

# Installation - Determine if user wants to download or use a local copy.
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD" # Choose method of installation
 if [ "$INSTALL_METHOD" = "LOCAL" ]
   then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE" # Browse for File
  
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER" # Install Application
  
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"  # Create temp folder
    cd "$POL_System_TmpDir"
    POL_Download "https://www.pirate101.com/downloadGame/OtherDownload" # Download installer
    mv OtherDownload InstallPirate101.exe # Setup will give a feature transfer error if not named InstallPirate101.exe 
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "InstallPirate101.exe" # Install Application
  
    POL_System_TmpDelete
fi
  
# Create Shortcuts
POL_Shortcut "Pirate101.exe" "$TITLE" "" "" "Game;RolePlaying;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXboTgwAKCRDlMfrJqhPK
R/wTAJwPdNAK7m/FAx0pHUoj16IutCQcewCeOo85kVTMt0LTjt7bthfGSX5z/wI=
=aolZ
-----END PGP SIGNATURE-----
