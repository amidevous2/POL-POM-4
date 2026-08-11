#!/bin/bash
# Date : (2019-08-21)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with success): - retail DVD-ROM (2010-06, folders date mean that it is v1.0).
#                        - GOG v2.0.0.5 (fail to run once installed)
#
# Middlewares used by this software : DirectX 9, vcrun2008.
# Game engine used : Unreal engine 3.
#
# CHANGELOG
# [Dadu042] (2019-08-21)
#   First script.
# [Dadu042] (2020-01-08)
#   Wine 4.0.1 -> 4.0.3
#   Arch: amd64 -> x86
#   Try fix audio speech with: POL_Install_dxfullsetup
#   Fix POL_SetupWindow_VMS location.
# [Dadu042] (2020-01-08)
#   Wine 4.0.3 -> 4.21 (does fix Audio rendering).
# [Dadu042] (2020-06-07)
#   Fix final message.
#
#
# KNOWN ISSUES (GOG release):
# - Wine 4.0.4, 4.21, 5.0.1, 5.10: Game fail to start as soon as started.
#
# KNOWN ISSUES:
# - Wine amd64 4.0.1 : wrong resolution when launched (the desktop is overwritten on the top left of the screen, 800x600, there the intro videos appears). Fix: Virtual desktop.
# - Wine amd64 4.0.1 : 3D view of the player often fail (block) to rotate 360°. Explanation: occurs when the mouse get out of the Wine's virtual desktop.
# - Wine amd64 4.8, 4.14 : crash as soon as launched (0009:err:module:LdrInitializeThunk Importing dlls for L"C:\\Program Files (x86)\\Activision\\Singularity(TM)\\Binaries\\Singularity.exe" failed).
# - Wine amd64 3.0.3 : game fail to start (freeze on black screen as soon launched).
#
# KNOWN ISSUES FIXED:
# - Wine amd64 4.0.1, 4.0.3, 4.0.4, 3.21 : sound rendering is wrong (ie: volume of voices is too low, ambient stays high). Tried: winetricks xact, directmusic, amstream, directplay. Fix: Wine 4.21 and 5.0
#
#
#
# Ideas to improve this script: ask to select the archive file, then decide what is the file extension (ie: RAR or ZIP or 7Z...).
  
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Singularity"
PREFIX="Singularity"
EDITOR="ActiVision"
GAME_URL="https://en.wikipedia.org/wiki/Singularity_(video_game)"
AUTHOR="Dadu042"
STEAM_ID="42670"
WORKING_WINE_VERSION="4.21"
GAME_VMS="512"
SHORTCUT_FILENAME="Singularity.exe"
SOFTWARE_CATEGORIES="Game;ActionGame;"
     
# Starting the script
POL_SetupWindow_Init
     
# Starting debugging API
POL_Debug_Init
    
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
   
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Determine Architecture
POL_System_SetArch "x86"
    
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
Set_OS "win7"
  
# Fix sound issues ?
# POL_Call POL_Install_dxfullsetup
# POL_Call POL_Install_xact
  
  
# POL_Call POL_Install_corefonts
     
# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11
  
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
    
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,DVD,STEAM"
  
POL_SetupWindow_message "$(eval_gettext 'Note: please do not install DirectX if asked to.')" "$TITLE"
  
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
  
elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Activision(R).msi"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine "VHSetup.exe" "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
   
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
  
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
#        POL_Shortcut_Document "$TITLE" "Readme.txt"
           
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
           
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
fi
fi
  
  
#######################################
# Create a 'virtual desktop' (window) #
#######################################
    
# Workaround to fix the "No mouse nor keyboard on main menu":
    
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1368x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
      
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
    
Set_Desktop "On" "$WIDTH" "$HEIGHT"
    
Set_WineWindowTitle "$TITLE"
  
  
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
  
POL_SetupWindow_message "$(eval_gettext 'Installation is finished !')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXukjqAAKCRDlMfrJqhPK
R/fKAJ4sxvrv4Ew+tw/nUAZJVilOg5Ng2QCfdBcB/rnAGjX1HYwCXaV0OzzYCD4=
=h6/6
-----END PGP SIGNATURE-----
