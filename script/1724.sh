#!/bin/bash --login
# Date : (2014-10-28 14:30)
# Last revision : see changelog
# Distribution used to test : Xubuntu 18.04 amd64 (kernel 5.3), GPU AMD.
# Author : MaxHeadroom2000 < at > gmail.com
# License : GNU/GPL v3
#
#
# CHANGELOG
# [luyz25] (2014-10-28 14:30)
#   Initial writing.
# [MaxHeadroom2000 < at > gmail.com] (2016-08-25 00:00)
#   Edits.
# [Dadu042] (2019-05-23)
#   Little improvements: Remove MD5 checkum of the downloader. Disable download. Update wine version. Disable xaudio.
# [Dadu042] (2020-06-08)
#   Wine 4.0.1 -> 4.0.4
#   Add POL_RequiredVersion
#
#
# KNOWN ISSUES :
# - Wine x86 4.0.1, 4.0.4, 4.21, 5.0, 5.7: and the end of its installation, the Tera installer v1.1 (files date: 2019-05-16) does crash (but stay open in the task bar). Tried: + POL_Install_vcrun2010
#
# KNOWN ISSUES (FIXED):

[ "$PLAYONLINUX" = "" ] && exit 1
source "$PLAYONLINUX/lib/sources"
   
TITLE="Tera Online"
PREFIX="TERA"
EDITOR="EN MASSE Entertainment"
GAME_URL="http://tera.enmasse.com/"
AUTHOR="see changelog"
WORKING_WINE_VERSION="5.7"
 
# Starting the script
POL_SetupWindow_Init
POL_SetupWindow_SetID 1724
   
# Starting debugging API
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
   
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
# Create TMP directory
POL_System_TmpCreate "$PREFIX"
   
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
   
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Fix Installer crash (2016)
Set_OS "win7"
 
# Isolation
POL_Install_PrivateUserDirs

  
#######################################
#  Installing mandatory dependencies  #
#######################################
	
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43

# POL_Call POL_Install_d3dx9
POL_Call POL_Install_corefonts
POL_Call POL_Install_xact
   
# Needed for Tera game
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_vcrun2013

# Was in 2016, function unknown as of 2019-05-22
# POL_Call POL_Install_xaudio
  
# Make game run (graphics), 2016
# POL_Wine_Direct3D "UseGLSL" "enabled"
# POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
# POL_Wine_Direct3D "OffscreenRenderingMode" "fbo"
# POL_Wine_Direct3D "Multisampling" "disabled"
# POL_Wine_Direct3D "StrictDrawOrdering" "enabled"
 
# Installing mandatory dependencies
POL_Call POL_Install_winhttp

#######################################
#  Main part of this script           #
#######################################

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Downloading client
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/TERA"
        POL_Download "https://eme01.enmasse-game.com/installers/eme/EnMasse-Minimal-Installer.exe"
        SETUP_EXE="$PWD/EnMasse-Minimal-Installer.exe"
else
        # Asking for client exe
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
fi
 
# Run the installer
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$SETUP_EXE"
# POL_Wine $SETUP_EXE
POL_Wine_WaitExit "$TITLE"
 
  
# Fix The Mouse Bug (2016)
# cd "$WINEPREFIX/drive_c/$PROGRAMFILES/TERA/Client/S1Game/Config/"
# mv S1Engine.ini S1Engine.ini.bkp
#
# URL down as of 2019-05-22:
# POL_Download "https://dl.dropboxusercontent.com/u/64225173/S1Engine.ini" "955be01c4c34445d7dde2c2b5e13cda6"
   
# Deleting temp files
POL_System_TmpDelete
  
# Making shortcut
POL_Shortcut "TERA-Launcher.exe" "Tera Online" "" "" "Game;RolePlaying;"
   
# Closing POL
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXt5c+AAKCRDlMfrJqhPK
R8vHAJ4zEygEceVg/BeGjg/EvOHa2J/e0wCgrHmto1W2mu2CbXIp4lT8Ri6Dtcc=
=zPfl
-----END PGP SIGNATURE-----
