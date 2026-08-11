#!/bin/bash
# Date : (2014-09-18 00:12)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits
# Author : med_freeman
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions:  CD v1.3 .
#
# Middlewares used by this software : DirectX 6.
#
#
# CHANGELOG
# [med_freeman] (2014-09-18 00:12)
#   Initial script.
# [Dadu042] (2020-03-31 23-00)
#   Brand new script (add: install from local file).
#   Remove POL_Call POL_Install_dsound
#   Wine 1.7.28 -> 3.0.3
# [Dadu042] (2020-03-31 23-00)
#   Add compatibility with the GOG release (v2.0.0.3)
#   Wine 3.0.3 -> 5.0 (for the GOG release).
#   
#
# KNOWN ISSUES
#  - Wine x86 3.0.3 + GOG release (v2.0.03) : crash when launched (the game. The launcher does run fine).
#  - Wine x86 3.20 + GOG release (v2.0.03) : in the main menu impossible to type a new user name.
#  - Wine x86 3.0.3, 4.0.3, 4.21, 5.5: game does need the CD (and does not see the ISO mounted). I found a NoCD but it fail to install.
#
# KNOWN ISSUES (FIXED):
#
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
          
TITLE="Star Wars : Rogue Squadron 3D"
PREFIX="RogueSquadron3D"
EDITOR="LucasArts / Factor 5"
GAME_URL="http://www.starwars.com/games-apps"
AUTHOR="med_freeman"
STEAM_ID=""
GAME_VMS="128"
SHORTCUT_FILENAME="ROGUE.EXE"
SOFTWARE_CATEGORIES="Game;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="r*.txt"
         
# Starting the script
POL_SetupWindow_Init
                      
# Starting debugging API
POL_Debug_Init
     
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
   
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (ie: Intel HD Graphics 4440 is not enough).')" "$TITLE"
   
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
         
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
     
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "5.0"
   
POL_System_TmpCreate "$PREFIX"
          
Set_OS "win98"
          
#######################################
#  Installing mandatory dependencies  #
#######################################
 
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_directmusic
# POL_Call POL_Install_dsound
# POL_Call POL_Install_quartz
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_wininet
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_dotnet30sp1
# POL_Call POL_Install_mono5.20
# POL_Call POL_Install_dotnet20
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
          
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
           
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
            
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
 [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
 [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
           
          
#######################################
#  Main part of this script           #
#######################################
              
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL,CD"
   
POL_SetupWindow_message "Warning: do not install DirectX (nor icons)." "$TITLE"
# POL_SetupWindow_message "Warning: do not install Visual C++ 2013 redistribuable\n nor Direct X." "$TITLE"
           
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
                   
elif [ "$INSTALL_METHOD" == "CD" ]; then
        POL_SetupWindow_cdrom
                   
        # POL_Call POL_Function_NoCDWarning
        POL_SetupWindow_check_cdrom "rogue"
        POL_Wine start /unix "$CDROM/SETUP.EXE"
                  
        POL_Wine_WaitExit "$TITLE"
               
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                  
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
           
           
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
          
        POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the demo (from Archive.org).')" "$TITLE"
        POL_Download "https://ia800802.us.archive.org/14/items/StarWarsRogueSquadron3dDemo/ROGUEDEMO.EXE"
        
        mv ROGUEDEMO.EXE GameInstaller.exe
        # mv Teacher%20Simulator.rar gameinstaller.rar        
        # mv Facewound.zip gameinstaller.zip
        
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "gameinstaller.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        # POL_System_unzip "gameinstaller.zip" -d "$WINEPREFIX/drive_c/game/"
          
        # Extract without sub-folder.
        # unzip "gameinstaller.zip" -j -d "$WINEPREFIX/drive_c/"
          
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
           
        cd  "$WINEPREFIX/drive_c/game/"
        POL_Wine "setup.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
  
        # rm GameInstaller.exe
        rm gameinstaller.zip
          
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
          
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
               
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
        
          
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.EXE GOG')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # APP_ANSWER=".EXE"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.MSI')~$(eval_gettext '.EXE')" "~"
        
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
          
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"

elif [ "$APP_ANSWER" == ".EXE GOG" ]; then
	Set_OS "win7"

        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
                
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                
        POL_Shortcut "Rogue Squadron.EXE" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
          
        POL_Shortcut_Document "$TITLE" "*.pdf"
   
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
          
        POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name !.')" "$TITLE"
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
     
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Yes')" "~"    
          
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
           
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
     
# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
           
# Fail ?
# POL_SetupWindow_message "$LNG_FIN" "$TITLE"
          
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXoR0YgAKCRDlMfrJqhPK
R7trAKCIRkrNrn6qinxGpCtKUhijxoVb+QCZAQzkOA9V/ATUPzFyIp3EwbMLeEs=
=sq5a
-----END PGP SIGNATURE-----
