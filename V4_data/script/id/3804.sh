#!/bin/bash
# Date : (2020-01-13 11-30)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: 2004.
#
# Middlewares used by this software : GameMaker.
#
# CHANGELOG
# [Dadu042] (2020-01-13 11-30)
#   Initial script.
#
# KNOWN ISSUES:
#  - Wine amd64 3.0.3: X
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 3.0.3: X

      
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="Gridrunner Remake 2003"
PREFIX="gridrunner-remake-2003"
EDITOR="Idigicon"
GAME_URL=""
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="64"
SHORTCUT_FILENAME="gridrunner.exe"
SOFTWARE_CATEGORIES="Game;ArcadeGame;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="read*.txt"
    
# Starting the script
POL_SetupWindow_Init
            
# Starting debugging API
POL_Debug_Init
           
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
         
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
         
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (ie: Intel HD Graphics 4440 is not enough).')" "$TITLE"
          
POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
     
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
           
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
      
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "3.0.3"

POL_System_TmpCreate "$PREFIX"

Set_OS "winxp"
    
#######################################
#  Installing mandatory dependencies  #
#######################################

# POL_Call POL_Install_dsound
 
# POL_Call POL_Install_dotnet40
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_dsound
# POL_Call POL_Install_riched30
# POL_Call POL_Install_phzysx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
    
    
################
#      GPU     #
################
 
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
  
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
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
# POL_SetupWindow_message "Warning: do not install DirectX." "$TITLE"
 
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
  
        POL_SetupWindow_check_cdrom "TQ Launcher.dbd"
        POL_Wine start /unix "$CDROM/setup.exe" "/SILENT"
        POL_Wine_WaitExit "setup.exe"
     
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
        
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
 
 
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"

        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the demo.')" "$TITLE"
        POL_Download "https://archive.org/download/gridrunner/gridrunner.exe"

	mv gridrunner.exe gridrunner_remake.exe

        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unzip "grdpc.zip" -d "$WINEPREFIX/drive_c/game/"

 
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
 
        POL_Wine "gridrunner_remake.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"

	POL_Shortcut_QuietDebug "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"

        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
     
        # POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
    
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.EXE')~$(eval_gettext '.RAR')" "~"
        # APP_ANSWER=".EXE"
    
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
      
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
      
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        # POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
     
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"

        POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name (otherwise: unzip error 9).')" "$TITLE"

        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
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
fi
fi
    
################
# Patch update #
################

# POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?\n (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"

if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
 
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
 
# Fail ?
# POL_SetupWindow_message "$LNG_FIN" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjfb1QAKCRDlMfrJqhPK
R/PSAJ4kKOU05vQjvnJomsvSEjdcxgrpcwCfaMNZTJL4GqmGAPLS3EEvr6Om1LY=
=Vre5
-----END PGP SIGNATURE-----
