#!/bin/bash
# Date : (2013-03-01)
# Last revision : (2014-04-27 16-52)
# Wine version used : 1.6, 1.6.2, 1.7.3
# Distribution used to test : Mac OS X 10.8.4
# Author : Marking
#
# CHANGELOG
# [Marking] (2013-03-01).
#   Initial script.
# [Dadu042] (2020-09-26 10-00).
#   Wine 1.6.2 (outdated) -> 3.0.3 (laters might not support the components used)
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Setup some needed variables
TITLE="Starlight Resonance (????????)"
PREFIX="SeisaiReson"
WINEVERSION="3.0.3"
EDITOR="Yatagarasu"
GAME_URL="http://www.yatanootori.com/yatagarasu/"
AUTHOR="Marking"
SHORTCUT_NAME="????????"

# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

# Initialize the script, debugging, and set required version
POL_SetupWindow_Init
POL_Debug_Init

# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Installs components needed to run VN, play OP movie, support (Xbox 360) controllers, and render 3D graphics properly
POL_Call POL_Install_d3dx9
POL_Call POL_Install_quartz
POL_Call POL_Install_xinput

# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    # Ask user to find "Resonance.msi"
    POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program in Data folder (Resonance.msi)')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    LANG="ja_JP.UTF-8" POL_Wine msiexec /qn /i "$APP_ANSWER"

elif [ "$INSTALL_METHOD" = "DVD" ]
then
    # Launches the installation program from CD/DVD
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "launcher.exe"
    POL_Wine_WaitBefore "$TITLE"
    LANG="ja_JP.UTF-8" POL_Wine msiexec /qn /i "$CDROM"/data/Resonance.msi
fi

# Create a shortcut for easy access
POL_Shortcut "?????????.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png"
# Insert a command to run as a Japanese application
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "LANG=ja_JP.UTF-8"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX28kagAKCRDlMfrJqhPK
R2FDAKCxr7lrkjQcRwdYHALdHpcYZmCh7QCfU8GwvAeLfRp34Bu8+HeyMN8aR/o=
=nRpO
-----END PGP SIGNATURE-----
