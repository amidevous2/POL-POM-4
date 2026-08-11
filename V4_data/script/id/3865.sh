#!/bin/bash
# Date: (2011-16-02 08:37)
# Last version: see changelog
# Distribution used to test: Gentoo (x64)
# Author: redevizer
# License: Retail
#
# CHANGELOG
# [redevizer] (2011-16-02 08:37)
#   Initial script.
# [Dadu042] (2020-01-29 21:00)
#   Wine 1.3.12 -> 3.20
#   Disable POL_Install_vcrun2008
#   Demo v1.2 tested with success.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Need For Speed: Carbon"
PREFIX="NFS_Carbon"
WORKING_WINE_VERSION="3.20"
  
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "EA Games" "" "N/A" "$PREFIX"
  
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp"

POL_System_TmpCreate "$PREFIX"

   
# Fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
    
# Choose between DVD and Digital Download version
POL_SetupWindow_menu "What version do you have?" "Actions" "DVD~Digital Download~Demo" "~"

VERSION_INSTALLED="$APP_ANSWER"
  
if [ "$VERSION_INSTALLED" == "DVD" ]; then
	GAME_MEDIAVERSION="DVD"
else
	GAME_MEDIAVERSION="DD"
fi

# Installing mandatory dependencies 
POL_Call POL_Install_vcrun2005
# POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dotnet20
POL_Call POL_Install_d3dx9

################
#      GPU     #
################
   
# Asking about memory size of graphic card
POL_SetupWindow_VMS "128"
    
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
     
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx

#######################################
#  Main part of this script           #
####################################### 
  
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
# Asking for CDROM and checking if its correct one
POL_SetupWindow_message "Please insert $TITLE media into your DVD drive\\nif not already done."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "AutoRun.exe"
wine start /unix "$CDROM/AutoRun.exe"
POL_SetupWindow_message "Click on \\"Next\\" ONLY when the game installation is finished\\nor you will have to redo the installation." "$TITLE"
else
# Asking then installing DDV of the game
cd $HOME
POL_SetupWindow_browse "Please select your $TITLE Digital Download executable" "$TITLE"
SETUP_EXE="$APP_ANSWER"
wine start /unix "$SETUP_EXE"
POL_SetupWindow_message "Click on \\"Next\\" ONLY when the game installation is finished\\nor you will have to redo the installation." "$TITLE"
fi
  
  
  
# Widescreen question
POL_SetupWindow_question "Do you want to play with widescreen resolution?\\n(if yes, Universal Widescreen Patcher will be downloaded).\\n\\n\\nWidescreen How-To:\\n * unzip is required\\n * Select $TITLE location\\n * Enter desidered resolution\\n * In game select 640x480 resolution - it will be your desidered resolution" "Widescreen"
if [ $APP_ANSWER == "TRUE" ]; then
POL_SetupWindow_message "Please wait while Universal Widescreen Patcher is being downloaded (~300kb)." "$TITLE"
mkdir -p $WINEPREFIX/drive_c/windows/temp
cd $WINEPREFIX/drive_c/windows/temp
wget http://www.widescreengamingforum.com/downloads/uniws.zip
unzip uniws.zip
echo -e "THE INI IS BELOW \\n[Apps] \\nversion=1.03 \\n\\na0=Need For Speed Carbon\\n\\n\\n[Need For Speed Carbon] \\ndetails=Select the 640x480 resolution in game to use your custom resolution. \\ncheckfile=nfsc.exe \\nmodfile=nfsc.exe \\nsig=80020000C701E0010000 \\nsigwild=0000110000 \\nxoffset=0 \\nyoffset=6 \\noccur=1\\n" > patches.ini
wine start /unix uniws.exe
POL_SetupWindow_message "Widescreen How-To:\\n * unzip is required\\n * Select $TITLE location (DO NOT CHOOSE: FIND IT FOR ME\\n                         it might detect the nfsc.exe that is located on your DVD)\\n * Enter desidered resolution\\n * In game select 640x480 resolution - it will be your desidered resolution" "Widescreen"
fi
  
# Delete temporary files
rm -rf $WINEPREFIX/drive_c/windows/temp/*
  

# Making shortcut

if [ "$VERSION_INSTALLED" == "Demo" ]; then
	POL_SetupWindow_auto_shortcut "$PREFIX" "nfsc_demo.exe" "$TITLE (demo)" "" "" "Game;"
else
	POL_SetupWindow_auto_shortcut "$PREFIX" "nfsc.exe" "$TITLE" "" "" "Game;"
fi

POL_SetupWindow_message "$TITLE has been installed successfully.\\nHope it works...\\nGood luck with the game ;)\\n\\nIf the game does not work, try applying NO-CD patch." "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH0MgAKCRDlMfrJqhPK
R4lfAKCTmgar9reu5yWGsenIBLrsmQShFwCgsXyKokKkrgmIg52MmNaZOsjJ95A=
=cfHD
-----END PGP SIGNATURE-----
