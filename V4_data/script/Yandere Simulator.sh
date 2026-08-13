#!/usr/bin/env playonlinux-bash
# Date : (2017-02-22 09-08)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Kubuntu 20.04 amd64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
#
#
# Software is based on: Unity 3D engine 2017, DirectX 11.
#
# Known issues:
# - Wine 4.8: game is slow, character does not move in the room, no mouse cursor displayed.
#             Downloading then unzip does not work with the current script.
#
#
# CHANGELOG
# [Beanow] (2017-02-22 09-08)
#   Initial script.
# [Dadu042] (2019-05-18)
#   Standardized, updated, tried to fix the download function (without success, perhaps because the website is now https).
# [Dadu042] (2020-03-21). Tested with build 2020-03-15.
#   Wine 4.8 (outdated) -> 5.0
#   POL_Shortcut improved
#   Note: 'virtual desktop' is perhaps not required anymore.
# [Dadu042] (2020-07-07). Tested with YandereSimulator-July-02.zip (2020)
#   Wine 5.0.1
#   Arch 32bits -> 64bits (now required by the game)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Yandere Simulator"
PREFIX="Yandere_Simulator"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Beanow"
EDITOR="YandereDev"
GAME_URL="https://yanderesimulator.com/"
APP_ID="3133"
GAME_VMS="128"
 
DL_SITE="http://dl.yanderesimulator.com/"
DL_FILE="latest.zip"
FONT_NAME="msyh.ttf"
FONT_DL_SITE="http://db.onlinewebfonts.com/t/"
FONT_DL_NAME="e63653407669814f5b0eb9bbdc175f77.ttf"
FONT_DL_MD5="e63653407669814f5b0eb9bbdc175f77"
#Weren't expecting that md5, were you? ^
  
# Initialization
# POL_System_SetArch "x86"
POL_System_SetArch "amd64"
POL_SetupWindow_Init
POL_SetupWindow_SetID $APP_ID
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
# POL_Wine_PrefixCreate
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "win7"

################
#      GPU     #
################
        
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
         
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
          
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx

#######################################
#  Main part of this script           #
#######################################
 
# Offer local file installation, since it's >700MB to download and
# you might want a different version than latest.


# Disabled because does not work yet
# POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
POL_SetupWindow_InstallMethod "LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the ZIP file of a build of the game.\nNote: The installer package (.EXE) will NOT work here. If unsure, cancel then use the download option instead."
    ZIP_FILE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
#    POL_SetupWindow_browse "The file to download: SITE$DL_FILE."
#    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Downloading the game.')" "$TITLE"
# File downloaded goes into .playonlinux/tmp
    POL_Download "$DL_SITE$DL_FILE"
 
    ZIP_FILE="$POL_System_TmpDir/$DL_FILE"
fi
  
  
# Get a build of the game then unzip.
[ -z "$WINEPREFIX" ] && POL_Debug_Fatal "WINEPREFIX not set"
TARGET_DIR="$WINEPREFIX/drive_c/YandereSimulator"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"
# POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
# 'POL_System_7z' was perhaps supported in 2017, but not in 2019.
# POL_System_7z x -y "$ZIP_FILE"
unzip "$ZIP_FILE"
[ "$INSTALL_METHOD" = "DOWNLOAD" ] && POL_System_TmpDelete
  
# Get the required font: MS YaHei
FONT_DIR="$WINEPREFIX/drive_c/windows/Fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
POL_Download "$FONT_DL_SITE$FONT_DL_NAME" "$FONT_DL_MD5"
mv "$FONT_DL_NAME" "$FONT_NAME"
  
# Create Shortcut
POL_Shortcut "YandereSimulator.exe" "$TITLE" "" "" "Game;"
 
 
#######################################
# Create a 'virtual desktop' (window) #
#######################################
  
# Workaround to TRY to fix the "No mouse cursor appear."
  
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge debug log file, you must type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYsQDmwAKCRDlMfrJqhPK
R8gRAJwP/n2rwxXsKdkVO4LdQNWJhrKp9ACeNSw2ps0Vn7lPdTk+Hmy1dM2AMag=
=FGZb
-----END PGP SIGNATURE-----
