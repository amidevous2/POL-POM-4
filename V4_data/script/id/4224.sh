#!/bin/bash
# Date : (2014-01-20)
# Last revision : (2014-04-05)
# Wine version used : 1.6.2
# Distribution used to test : Mac OS X 10.9.2
# Author : Marking
 
# CHANGELOG
# [Marking] (2014-01-20).
#   Initial script.
# [Dadu042] (2020-09-25 10-00).
#   Wine 1.6.2 (outdated) -> 3.0.3 (laters might not support the components required)
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setup some needed variables
TITLE="Sono Hanabira ni Kuchizuke wo 12 - Atelier no Koibito-tachi"
PREFIX="SonoHana_12"
WINEVERSION="3.0.3"
EDITOR="Yurin Yurin"
GAME_URL="http://yurinyurin.com/"
AUTHOR="Marking"
SHORTCUT_NAME="????????????? 12 ???????????"
 
# Download images for installation script
POL_GetSetupImages "http://images.markinglifestyle.com/sonohana_mac/script_icons/SonoHana_12-64x64.png" "images.markinglifestyle.com/sonohana_mac/script_banners/SH_12.jpg" "$TITLE"
 
# Initialize the script and debugging
POL_SetupWindow_Init
POL_Debug_Init
  
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    # Ask user to find "Setup.exe"
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program (Setup.exe)')" "$TITLE"
    POL_SetupWindow_message "$(eval_gettext 'Close the visual novel when it appears to continue installation. Click Next to begin installation.')" "Installation instructions"
    POL_Wine_WaitBefore "$TITLE"
    LANG="ja_JP.UTF-8" POL_Wine "$APP_ANSWER" /sp- /verysilent
     
elif [ "$INSTALL_METHOD" = "DVD" ]
then
    # Launches the installation program from CD/DVD
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "Setup.exe"
    POL_SetupWindow_message "$(eval_gettext 'Close the visual novel when it appears to continue installation. Click Next to begin installation.')" "Installation instructions"
    POL_Wine_WaitBefore "$TITLE"
    LANG="ja_JP.UTF-8" POL_Wine "$CDROM/Setup.exe" /sp- /verysilent
fi
     
# Create a shortcut for easy access
POL_Shortcut "ATELIER.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png"
# Insert a command to run as a Japanese application
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "LANG=ja_JP.UTF-8"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX25fZwAKCRDlMfrJqhPK
R9mdAJ9LPJhiSZYSJbq0yCj6BurLpz5QsgCgpEbs8YFa2to2cSZwsxhcUgXb4h0=
=FvwP
-----END PGP SIGNATURE-----
