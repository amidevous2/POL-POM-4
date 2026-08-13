#!/bin/bash
# Date : (2020-08-20)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : KUbuntu 20.04 64 bits (Linux kernel v5.4). GPU: Intel HD 530
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: local file
#
# Middlewares used by this software : Unity 2017, DirectX 11
#
#
#
# CHANGELOG
# [Dadu042] (2020-08-20 20-00)
#   Initial script.
#
# KNOWN ISSUES :
#  - Wine amd64 5.0.1, 5.12: X
# 
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.1: X
  
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Donut County"
PREFIX="donut-county"
EDITOR=""
GAME_URL=""
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="256"
SHORTCUT_FILENAME="DonutCounty.exe"
SOFTWARE_CATEGORIES="Game;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE=""
             
# Starting the script
POL_SetupWindow_Init
                          
# Starting debugging API
POL_Debug_Init
         
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
 
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Determine Architecture
POL_System_SetArch "auto"
# POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
 
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "5.0.2"
 
# POL_System_TmpCreate "$PREFIX"
              
Set_OS "win7"
 
#######################################
#  Hacks                              #
#######################################
 
 
#######################################
#  Installing mandatory dependencies  #
#######################################
 
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_vcrun2010
# POL_Call POL_Install_dsound
# POL_Call POL_Install_directmusic
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_quartz
# POL_Call POL_Install_wininet
# POL_Call POL_Install_dotnet30sp1
# POL_Call POL_Install_mono5.20
# POL_Call POL_Install_dotnet40
# POL_Call POL_Install_dotnet472
# POL_Call POL_Install_dsound
# POL_Call POL_Install_riched30
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
                  
                  
################
#      GPU     #
################
 
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
# POL_SetupWindow_menu_list "How much memory does your graphics board have?" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
# VRAM="$APP_ANSWER"
# POL_Wine_Direct3D "VideoMemorySize" "$VRAM"
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
 
#############################################
#  Sound problem fix - pulseaudio related   #
#############################################1
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
 
#######################################
#  Main part of this script           #
#######################################
                  
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL"
       
# POL_SetupWindow_message "Warning: do not install DirectX (nor the icons)." "$TITLE"
# POL_SetupWindow_message "Warning: do not install Visual C++ 2013 redistribuable\n nor Direct X." "$TITLE"
# POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
 
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
                       
elif [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_cdrom
                       
        # POL_Call POL_Function_NoCDWarning
                
        POL_SetupWindow_check_cdrom "engine32.cab"
        POL_Wine start /unix "$CDROM/setup.exe"
                      
        POL_Wine_WaitExit "$TITLE"
                   
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                      
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
               
               
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
              
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the demo .')" "$TITLE"
        POL_Download "http://files.myplaycity.com/files_downloader_temp/paradisebeach_setup.exe"
            
        mv paradisebeach_setup.exe GameInstaller.exe
        # mv Teacher%20Simulator.rar gameinstaller.rar
        # mv doomrl-win-0997.zip gameinstaller.zip
            
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "gameinstaller.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        # POL_System_unzip "gameinstaller.zip" -d "$WINEPREFIX/drive_c/game/"
              
        # Extract without sub-folder.
        # unzip "gameinstaller.zip" -j -d "$WINEPREFIX/drive_c/"
              
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
          
        # cd  "$WINEPREFIX/drive_c/game/"
        # POL_Wine "GameInstaller.exe" # "/SILENT"
        # POL_Wine_WaitBefore "$TITLE"
      
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: do NOT install DirectX.')" "$TITLE"
   
        # cd "$WINEPREFIX/drive_c"
        # rm GameInstaller.exe
        # rm GameInstaller.exe
              
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
              
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                   
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
              
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.MSI')~$(eval_gettext '.EXE')" "~"
            
        # APP_ANSWER=".EXE"
      
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file (.EXE)')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
    
        # POL_SetupWindow_message "Note: please answer NO to all the questions that will appear." "$TITLE"
    
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                  
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                    
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
   
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
          
elif [ "$APP_ANSWER" == "$(eval_gettext '.MSI')" ]; then
       # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine msiexec /i  "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                    
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                    
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
              
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
       
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
              
        # POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name !.')" "$TITLE"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/game/"
            
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
              
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
            
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
             
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
fi
fi
     
################
# Patch update #
################
    
# POL_SetupWindow_menu "$(eval_gettext 'Do you have a official patch-update to install ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Yes')" "~"      
              
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
               
POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"
              
# POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXz7XdAAKCRDlMfrJqhPK
R8maAJ0XTUmy4Q/RJsFcI1fPZE1KzNmo7gCcDazJfTo3/7dkyaL1TmeIF++MfYc=
=jsmM
-----END PGP SIGNATURE-----
