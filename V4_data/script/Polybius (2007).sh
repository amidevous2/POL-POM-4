#!/bin/bash
# Date : (2019-11-08)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : KUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: 2007
#
# Middlewares used by this software : .
#
# CHANGELOG
# [Dadu042] (2019-11-08)
#   First script. Health altered.
# [Dadu042] (2019-11-11)
#   Fix download issue.
#
# KNOWN ISSUES:
#  - Wine amd64 3.0.3: Huge log file ('Found ...').
#
  
  
# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="Polybius (2007)"
PREFIX="Polybius_2007"
EDITOR="SINNESLOSCHEN"
GAME_URL="http://www.sinnesloschen.com"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
SHORTCUT_FILENAME="POLYBIUS 6-1.EXE"
SOFTWARE_CATEGORIES="Game;ArcadeGame;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
     
# Starting the script
POL_SetupWindow_Init
         
# Starting debugging API
POL_Debug_Init
        
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
      
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
      
POL_SetupWindow_message "$(eval_gettext 'WARNING:\n
This game uses strobe, auditory, and visual effects that 
could potentially cause seizures, nausea, motion sickness. 
DO NOT PLAY THIS GAME IF YOU HAVE SEIZURES, HEART PROBLEMS 
OR RHYTHM DISTURBANCES, PREGNANCY, OR ARE ON ANY PSYCHO-
ACTIVE MEDICINES.).\n\nMore details in README.TXT file.')" "$TITLE"
 
# POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"
 
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
        
# Determine Architecture
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
   
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
Set_OS "win7"
     
# Installing mandatory dependencies
  
# POL_Call POL_Install_riched30
# POL_Call POL_Install_phzysx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
  
  
# Useful for Salamander NG + Wine 3.0.3 (no need with Wine 4.0.2)
# Sound problem fix - pulseaudio related
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
  
  
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
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
      
elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
      
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
  
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
     
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
      
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
  
        cd "$WINEPREFIX/drive_c"
        # cd "$POL_System_TmpDir"
        POL_Download "http://www.sinnesloschen.com/POLYBIUS%20v6-1.zip"
        cp 'POLYBIUS%20v6-1.zip' POLYBIUS_v6-1.zip
        # SETUP_EXE="$APP_ANSWER"
        # cd "$POL_System_TmpDir"
         
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "POLYBIUS_v6-1.zip" -d "$WINEPREFIX/drive_c/"
            
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
        POL_Shortcut_Document "$TITLE" "README.TXT"
  
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        APP_ANSWER=".EXE"
           
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
   
        # Restore screen resolution (game's default is 1024x768)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
   
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "README.TXT"
   
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
        POL_Shortcut_Document "$TITLE" "README.TXT"
               
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
#      GPU     #
################
   
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
  
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
   
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
  
  
   
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file (and eventually create a black hole), you should type \ninto Debug flags : fixme-all')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcldggAKCRDlMfrJqhPK
R1gyAJwM7VnMCEHBxzrgy44meDKXJ55LyACePahfS3Qb3f4xx+Y6ZYK5JkqLUYo=
=z69P
-----END PGP SIGNATURE-----
