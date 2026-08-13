#!/bin/bash
# Date : (2020-09-19)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits (Linux kernel v5.4.0). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: PlayStationNow-11.2.2.exe (2020-09)
#
# Middlewares used by this software : QtWebEngine, AGL.EXE (Application Layer Gateway, requires DirectX 11)
#
#
#
# CHANGELOG
# [Dadu042] (2020-09-19 20-00)
#   Initial script. Fail to run (details in Known issues).
# [Dadu042] (2020-09-22 10-00)
#   "5.8-staging" -> "" (I hope a later Wine version will let it work).
# [Dadu042] (2020-09-22 21-00)
#    POL_System_SetArch "auto" -> "x86". Required for vcrun2013
# [Dadu042] (2020-09-24 21-00)
#    Some changes to try to match the Lutris script. Now I reach the PS log + Playstation text below. However QtWebEngineProcess.exe does crash.
#    Win10 -> Win7
#    Hack a config file.
#
#
# KNOWN ISSUES :
#  - Wine amd64 4.21-staging, 5.0.2 (OS: 'win7', software v11.2.2, + d3dx11): black window with the blue logo + the 'PlayStation' text below, then freeze.
#  - Wine amd64 4.21-staging, 5.0.2, 5.11-staging, 5.16 (OS: 'win10'/'win7'/'win8', software v11.2.2): installer does crash (rundll32.exe). Workaround: Wine 5.8-staging
#  - Wine amd64 5.8-staging (OS: 'win10', software v11.2.2): installer does crash without error message. Tried: DXVK_171 (to retry without d3dx11).
#
#
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 4.21-staging, 5.0.2, 5.11-staging, 5.16, 5.17 (OS: 'win8.1', software v11.2.2, + d3dx11): black window with the blue logo, then crash without any message, then the app automatically restarts. Seems related to a 'XamlParseException' issue. Fix: win10 -> win7
#  - Wine amd64 5.0.2: class {7ab36653-1796-484b-bdfa-e74f1db7c1dc} not registered. Fix: Wine 5.12
#  - Wine amd64 5.0.2, 5.8-staging (OS: 'win7'/'win8', software v11.2.2): 'PlayStation Now cannot be installed on the following Windows versions ...'. Workaround: Set_OS "win8.1"
#  - Wine amd64 5.0.2 (OS: 'win8.1', software v11.2.2): crash after that the blue Playsation logo appears. Fix: vcrun2013
#  - Wine amd64 5.0.2 (OS: 'win8.1', software v11.2.2): black window with the blue logo, then AGL.EXE does crash. Tried: disable d3d11, workaround: install function d3dx11.
#  - Wine amd64 5.8-staging (OS: 'win10', software v11.2.2): installer does crash (psnowlauncher.exe). Fix: vcrun2013
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="PlayStation Now"
PREFIX="PlayStation_Now"
EDITOR="Sony"
GAME_URL="https://www.playstation.com/"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME="psnowlauncher.exe"
SOFTWARE_CATEGORIES="Game;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="Readme.txt"
 
 
# Starting the script
POL_SetupWindow_Init
                          
# Starting debugging API
POL_Debug_Init
         
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
############################################
#  Choose architecture: 32 bits or 64 bits #
############################################
 
# POL_SetupWindow_menu "$(eval_gettext 'What architecture do you want to use ?')" "$TITLE" "$(eval_gettext '64 bits (recommended)')~$(eval_gettext '32 bits')" "~"
  
# if [ "$APP_ANSWER" == "32 bits" ]; then
#         POL_System_SetArch "x86"
# elif [ "$APP_ANSWER" == "$(eval_gettext '64 bits (recommended)')" ]; then
#         POL_System_SetArch "amd64"
# fi
 
POL_System_SetArch "x86"
 
# Download Wine if necessary then create prefix
POL_Wine_PrefixCreate "5.0.2"
 
# POL_System_TmpCreate "$PREFIX"
              
Set_OS "win7"
 
#######################################
#  Hacks                              #
#######################################
 
 
#######################################
#  Installing mandatory dependencies  #
#######################################

POL_Call POL_Install_vcrun2013
 
# POL_Call POL_Install_d3dx11
 
# Useless because AGL.EXE does requires it.
# POL_Wine_OverrideDLL "" "d3d11"
 
 
################
#      GPU     #
################
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Minimum memory size requiered for the graphic card.
POL_SetupWindow_VMS $GAME_VMS
 
# Asking about memory size of graphic card
# POL_SetupWindow_menu_list "How much memory does your graphics board have?" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
# VRAM="$APP_ANSWER"
# POL_Wine_Direct3D "VideoMemorySize" "$VRAM"
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
 
#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
 
#######################################
#  Main part of this script           #
#######################################
                  
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL"
 
# POL_SetupWindow_message "Warning: do not install Punk Buster nor DirectX." "$TITLE"
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
                
        POL_SetupWindow_check_cdrom "setup.exe"
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
        POL_Download ""
            
        mv stinger32.exe GameInstaller.exe
        # mv Teacher%20Simulator.rar gameinstaller.rar
        # mv Lemms.zip gameinstaller.zip
            
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
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.MSI')~$(eval_gettext '.EXE')" "~"
            
        APP_ANSWER=".EXE"
      
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


#######################################
#  Hacks                              #
#######################################

# Disable the auto update because it prevent the app to start and quit
# cd "$PREFIX/drive_c/Program Files (x86)/PlayStationNow/"  # if arch 64bits
cd "$PREFIX/drive_c/Program Files/PlayStationNow/"          # if arch 32bits
sed -i "s/URL.*/URL=/" unidater.ini


         
POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"
         
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
              
# POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2z7lgAKCRDlMfrJqhPK
RzU8AKCGby4swXj1CN6vPfihpyjCQsXTlACgiTKh10sqQa67LAwZxHqTeCWW5+8=
=Zesr
-----END PGP SIGNATURE-----
