#!/bin/bash
# Date : (2014-01-20)
# Last revision : (2014-04-05)
# Wine version used : 1.6.2
# Distribution used to test : Mac OS X 10.9.2
# Author : Marking

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Setup some needed variables
TITLE="Sono Hanabira ni Kuchizuke wo 13 - Tenshi no Akogare"
PREFIX="SonoHana_13"
WINEVERSION="1.6.2"
EDITOR="Yurin Yurin"
GAME_URL="http://yurinyurin.com/"
AUTHOR="Marking"
SHORTCUT_NAME="その花びらにくちづけを 13 ～天使のあこがれ～"

# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

# Initialize the script, debugging, and set required version
POL_SetupWindow_Init
POL_RequiredVersion "4.1.6" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.6 is required to install $TITLE"
POL_SetupWindow_SetID 1924
POL_Debug_Init

# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Installs components needed to run game and movie
POL_Call POL_Install_d3dx9
POL_Call POL_Install_quartz
POL_Call POL_Install_amstream

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

# Install the movie patch provided by developers
POL_SetupWindow_message "$(eval_gettext 'An update patch was released on July 17th, 2013 to fix movie issues. This script will now install it. Click Next to continue.')" "Installing patch update"
SONO_UPDATE="tenshinoakogare_patch.zip"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/ゆりんゆりん/その花びらにくちづけを～天使のあこがれ～/"
POL_Download "http://124.39.252.42/sozai/soft/support/tenshinoakogare_patch.zip"
POL_System_unzip $SONO_UPDATE
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/ゆりんゆりん/その花びらにくちづけを～天使のあこがれ～/tenshinoakogare_patch/"
mv "$WINEPREFIX/drive_c/$PROGRAMFILES/ゆりんゆりん/その花びらにくちづけを～天使のあこがれ～/tenshinoakogare_patch/patch.xp3" "$WINEPREFIX/drive_c/$PROGRAMFILES/ゆりんゆりん/その花びらにくちづけを～天使のあこがれ～/patch.xp3"

# Create a shortcut for easy access
POL_Shortcut "AKOGARE.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png"
# Insert a command to run as a Japanese application
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "LANG=ja_JP.UTF-8"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNdaV8ACgkQ5TH6yaoTykey3ACfSPIjG7zIo0u7EDeuDl5eZe9S
A3EAoJdAPXDYD8Iwk/wF93Xnx8bT+iK3
=4IP7
-----END PGP SIGNATURE-----
