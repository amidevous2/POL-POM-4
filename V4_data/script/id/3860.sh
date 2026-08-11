#!/bin/bash
# Date : (2020-01-26)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : Ubuntu 18.04 64 bits
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions:  v1.4007
#
# Middlewares used by this software : vcrun2013, Direct X (9 and 10), DotNet 4.0, OpenAL (2009 v 2.0.9.0 ), Xvid codec .
#
# CHANGELOG
# [Dadu042] (2020-01-26 15:40)
#   Initial script.
# [Dadu042] (2020-01-27 13:00)
#   Little changes. Game still fail to run.
# [Dadu042] (2020-02-08 06:00)
#   Apply infos found on Lutris, from a unknown author.
#   POL_Install_dotnet461 Does not stop, must be stopped manually.
#
#
# KNOWN ISSUES:
#  - Wine 5.0: POL_Install_dotnet461 Does not stop, must be stopped manually.

#  - Intel HD Graphics 530 + Wine x86 4.0.3, 4.21: 'Your video card doesn't meet game requirements. Try to lower game settings.'. Fix: ?
#  - Wine x86 4.0.3, 4.21, 5.0: when clicking the tab 'Mods' the launcher does crash (my game is installed in Optimized, and Basic mode).
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 4.0.3, 4.21: 'CLR error: 80004005' (log: 0009:fixme:wer:WerRegisterRuntimeExceptionModule (L"C:\\windows\\Microsoft.NET\\Framework\\v4.0.30319\\mscordacwks.dll", 0x79140000) stub! ). Caused by Dotnet40. Fix: Dotnet461 (instead of Dotnet40).

  
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="S.T.A.L.K.E.R. - Lost Alpha"
PREFIX="stalker_lost_alpha"
EDITOR="Dezowave"
GAME_URL="https://www.moddb.com/mods/lost-alpha"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME="Lost Alpha Configurator.exe"
SOFTWARE_CATEGORIES="Game;ActionGame;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="manual.pdf"
 
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
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
        
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "5.0.3"
  
POL_System_TmpCreate "$PREFIX"
  
Set_OS "win7"
  
#######################################
#  Installing mandatory dependencies  #
#######################################
 

POL_Call POL_Install_d3dx9
POL_Call POL_Install_vcrun2013
POL_Call POL_Install_xvid


# POL_Call POL_Install_mdac28
# POL_Call POL_Install_dotnet40

# To avoid the game error message:  platform not supported
# Set_OS "win7"


# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43


# POL_Call POL_Install_directmusic
# POL_Call POL_Install_dsound
 
# POL_Call POL_Install_dotnet20
# POL_Call POL_Install_dotnet40
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_dsound
# POL_Call POL_Install_riched30
# POL_Call POL_Install_physx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210
      
      
################
#      GPU     #
################
  
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
   
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
    
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
      
      
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
   
# POL_SetupWindow_message "Warning: do not install DirectX." "$TITLE"

POL_SetupWindow_message "\nWARNING, do not install (when asked):\n- Visual C++ 2013 redistribuable\n - Xvid\n- Direct X\n\nNote: please do install Open AL !." "$TITLE"
   
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
    
        # POL_SetupWindow_check_cdrom "music/ambush.aud"
        POL_Wine start /unix "$CDROM/setup.exe"
          
        POL_Wine_WaitExit "$TITLE"
       
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
          
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
   
   
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
  
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the v1.01 .')" "$TITLE"
        POL_Download "http://redux.dune2k.com/down/R3v1p01.zip"
  
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "R3v1p01.zip" -d "$WINEPREFIX/drive_c/game/"
  
        # Extract without sub-folder.
        # unzip "acespeeder2.zip" -j -d "$WINEPREFIX/drive_c/"
  
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
   
        # cd  "$WINEPREFIX/drive_c/game/"
        # POL_Wine "RollingMadness3D-Installer.exe" # "/SILENT"
        # POL_Wine_WaitBefore "$TITLE"
        # rm RollingMadness3D-Installer.exe
  
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
  
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
       
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
  
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        APP_ANSWER=".EXE"

if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        
        # Restore screen resolution (game's default is 640x480 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
        
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        # POL_Shortcut_QuietDebug "$TITLE"
  
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
       
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
  
        POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name !.')" "$TITLE"
  
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
 
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
fi
fi
  
# Seems useless (and seems to not copy right):
# cp "$WINEPREFIX/drive_c/windows/system32/msvcp120.dll" "$WINEPREFIX/drive_c/Program Files/S.T.A.L.K.E.R. - Lost Alpha DC/bins/"
# cp "$WINEPREFIX/drive_c/windows/system32/msvcr120.dll" "$WINEPREFIX/drive_c/Program Files/S.T.A.L.K.E.R. - Lost Alpha DC/bins/"

POL_SetupWindow_message "\n\nIf DotNet 4.61 does never stop installing after more 30 min, please close it." "$TITLE"

POL_Call POL_Install_dotnet461

################
   
# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
  
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
   
# Fail ?
# POL_SetupWindow_message "$LNG_FIN" "$TITLE"
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX+PAhwAKCRDlMfrJqhPK
Ry+tAJ0UYnmRAUefULWtjaByN/tQdlnOZACeIBm6znZHSc1LKPRO2JbMXo19mhw=
=kJSC
-----END PGP SIGNATURE-----
