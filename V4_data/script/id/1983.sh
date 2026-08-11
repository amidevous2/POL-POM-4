#!/bin/bash
# Date : (2013-03-30)
# Last revision : (2013-03-30)
# Distribution used to test : Ubuntu-gnome 64
# Author : Massawi33
# Licence : GPLv3
# PlayOnLinux:  playonlinux-4.2.2


# CHANGELOG:
# [max252] (2014)
#   Initial write ?.
# [Dadu042] (2020-01-09) (not tested)
#   Wine 1.17.12 -> 4.21
#   Add GPU setting.
# [Dadu042] (2020-01-09 19:55)
#   Wine 4.21 -> 4.0.3 (more economical because this script is not tested).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="WorldOfWarplanes"
PREFIX="WOWarplanes"
WORKING_WINE_VERSION="4.21"
PUBLISHER="BigWorld Technology"
GAME_URL="http://worldofwarplanes.com/"
AUTHOR="Massawi33"
GAME_VMS="128"

# Setup
POL_SetupWindow_Init
POL_SetupWindow_SetID 1983
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$TITLE will not work with $APPLICATION_TITLE $VERSION\nPlease upgrade."

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Components
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9_36
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_dxdiag
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_corefonts
POL_Call POL_Install_msxml3
POL_Call POL_Install_wininet
POL_Call POL_Install_ie8

################
#      GPU     #
################
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx


####################
# DOWNLOAD GAME    #
####################

#Select which version
POL_SetupWindow_menu "$(eval_gettext 'Which region version of World of Warplanes would you like to install?')" "$TITLE" "North America~Europe~Russia" "~"
[ "$APP_ANSWER" = "North America" ] && REGION="na"
[ "$APP_ANSWER" = "Europe" ] && REGION="eu"
[ "$APP_ANSWER" = "Russia" ] && REGION="ru"
# Download
cd "$WINEPREFIX/drive_c"
POL_Download "http://dl.wargaming.net/wowp/$REGION/files/WoWP_internet_install_$REGION.exe"

POL_SetupWindow_message "$(eval_gettext 'Attention:After installation is complete, the patcher will load. After, go to the top right of the patcher and click the wrench, then un-check the box for "Allow Torrent", if this is not done the patcher will crash after 1 minute. When finished with this, please close the patcher before logging in or finish updating to complete the installation. After this, you can run "$TITLE" when setup is done.')" "$TITLE"

#Installation
POL_Wine start /unix "$WINEPREFIX/drive_c/WoWP_internet_install_$REGION.exe"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts

POL_Shortcut "WOWpLauncher.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhd3hAAKCRDlMfrJqhPK
R3pUAJ0ZyiCe9kgw0KSPUTnQHAkDSadrdgCdHbHf0r8ZZ4EOdm1VMK4YqgzUQwo=
=9Q5G
-----END PGP SIGNATURE-----
