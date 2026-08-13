#!/bin/bash
# Date : (2019-09-03)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED : DDV v2.0.0.3 (from GOG.com. It's a 2009 game). ZombieShooter2.exe's file Version: 2,5,0,1. Readme.txt : "v1.0"
#
# Middlewares used by this software : DirectX 9.
#
# CHANGELOG
# [Dadu042] (2019-09-03)
#   First script (game fail to run).
# [Dadu042] (2020-03-18)
#   POL_Install_directx9 (thanks to Booman).
#
#
# KNOWN ISSUES:
#  - Wine amd64 4.0.2, 3.21: black screen, then back to the desktop: game crash before launching. Tried: install d3dx9_43 + compiler, gdiplus. Fix: directx9.
#                      0009:fixme:d3dcompiler:compile_shader Compilation target "fx_2_0" not yet supported
#                      0009:fixme:d3dx:d3dx9_effect_init Failed to parse effect, hr 0x8876086c.
#  - Wine amd64 4.0.2, 4.15: game crash before launching. Fix: directx9.
#                      0009:err:winediag:wined3d_get_user_override_gpu_description Invalid GPU override 8086:041e specified, ignoring.
#                      0009:fixme:d3dcompiler:compile_shader Compilation target "fx_2_0" not yet supported
#
# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Zombie Shooter 2"
PREFIX="zombie_shooter_2"
EDITOR="Sigma Team"
GAME_URL="http://www.sigma-team.net"
AUTHOR="Dadu042"
STEAM_ID="33180"
WORKING_WINE_VERSION="5.0"
GAME_VMS="128"
SHORTCUT_FILENAME="ZombieShooter2.exe"
SOFTWARE_CATEGORIES="Game;Shooter;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="Readme.txt"
  
# Starting the script
POL_SetupWindow_Init
          
# Starting debugging API
POL_Debug_Init
         
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
       
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
       
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (ie: Intel HD Graphics 4440 is not enough).')" "$TITLE"
        
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
         
# Determine Architecture
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
    
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
       
Set_OS "win7"
  
#######################################
#  Installing mandatory dependencies  #
#######################################

# POL_Call POL_Install_directx9

# POL_Call POL_Install_dsound
# POL_Call POL_Install_riched30
# POL_Call POL_Install_phzysx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
  
  
################
#      GPU     #
################
    
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
   
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
    
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
  
  
#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
  
  
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL"
POL_SetupWindow_InstallMethod "LOCAL"
   
# POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"
      
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
       
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
   
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
      
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
       
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
        POL_SetupWindow_message "$(eval_gettext 'This script will download the free release (ads supported) from Gametop.com .')" "$TITLE"
        POL_Download "https://cdn.gametop.com/free-games-download/Zombie-Shooter2.exe"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        POL_Wine "Zombie-Shooter2.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        # POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
   
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
   
        POL_Shortcut "engine.exe" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
  
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # APP_ANSWER=".EXE"
  
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
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
   
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
  
################
# Patch update #
################
  
# POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?\n (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
    
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
  
  
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
  
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a big useless POL/POM log file, you should type \ninto Debug flags : fixme-all.')" "$TITLE"
       
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnJ5/AAKCRDlMfrJqhPK
R7n2AJ0dPJB4jtB6mp5/TBXxiOci3xFL6gCeI5ds5uTCOO1oykergLYfbgypbKs=
=KqkY
-----END PGP SIGNATURE-----
