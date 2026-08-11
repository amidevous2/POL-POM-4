#!/bin/bash
# Date : (2020-03-07)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: - 'Version of 04.03.2020' (wrote on the Game Center window).
#                  - local file WarfaceMyGamesLoader_ecc989d12230045ca0917f4f02bba407_.exe (2019-12)
#                  - local file WarfaceMyGamesLoader_ecc989d12230045ca0917f4f02bba407_.exe (2019-12)
#                  -            WarfaceMyGamesLoader_6d1f751e65366e3bf72b6171ecf6b71e_.exe (2020-06)
#
#
# Middlewares used by this software : Chrome (3.3538.1848), 7z, Discord, .
#
#
# CHANGELOG
# [Jimy Byerley] (2016-05-23 12:12)
#    First version.
# [Dadu042] (2019-08-02 20:33)
#    Wine 1.9.9 -> 2.22 (more common)
# [Dadu042] (2019-12-23 11:28)
#    Add install from local source file.
#    Script rewrote.
#    Disable xact, xinput, d3dx9 (were used in 2016).
# [Dadu042] (2020-03-07 22:00)
#   Script updated, more notes. Game does still fail to launch (IGP Intel HD 4400).
# [Dadu042] (2020-06-08 22:00)
#   Wine 5.2-staging -> 5.7. Now the game start downloading (20 GB !).
#
# KNOWN ISSUES:
#  - Wine amd64 5.2-staging: when trying to launch the game from the game center, the window 'STARTING UP' does appear but also a window titled 'Game start error' containing 'General failure. <OK>'. In the log file there is some lines 'fixme:bcrypt:BCryptCreateHash ignoring object buffer'. I tried to launch the two binaries provided 32bits and 64bits (menu Game Settings: '[ ] Use the 64-bit version of the client if possible').?
#  - Wine x86 4.0.3, 4.21, 5.0-rc1 + release 2019-12: The installer stops because it thinks the OS is Windows XP or Vista. Tried: Set_OS "win7", Set_OS "win10", dotnet40.  Ref: https://pc.warface.com/en/news/1216393.html
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0, 5.2: Game does download and install, but once in the gamecenter it seems impossible to run it, in the tab 'Area' the network ping test shows none value ('- ms').  Tried: wininet. Fix: Wine 5.2-staging. 
#  - Wine amd64 5.0: some texts missing on the main screen of the Game Center. Fix: POL_Install_corefonts.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
        
TITLE="Warface"
PREFIX="Warface"
EDITOR="My"
GAME_URL="https://store.my.games/"
AUTHOR="Dadu042"
STEAM_ID="291480"
GAME_VMS="256"
SHORTCUT_FILENAME="GameCenter.exe"
SOFTWARE_CATEGORIES="Game;Shooter;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE=""
       
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
POL_Wine_PrefixCreate "5.7"
        
POL_System_TmpCreate "$PREFIX"
        
Set_OS "win7"
        
#######################################
#  Installing mandatory dependencies  #
#######################################
   
   
POL_Call POL_Install_corefonts
 
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
POL_SetupWindow_VMS $GAME_VMS
         
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
          
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
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
         
# POL_SetupWindow_message "Warning: do not install DirectX (nor icons)." "$TITLE"
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
          
        POL_SetupWindow_check_cdrom "install.exe"
        POL_Wine start /unix "$CDROM/install.exe"
                
        POL_Wine_WaitExit "$TITLE"
             
        # Restore screen resolution (game's default is 800x600 ?)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
   
        # POL_Shortcut "Setup.exe" "$TITLE - Setup" "" "" "$SOFTWARE_CATEGORIES"
         
         
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
        
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the beta v0.5 .')" "$TITLE"
        POL_Download "https://static.gc.my.games/WarfaceMyGamesLoader.exe"
      
        mv WarfaceMyGamesLoader.exe GameInstaller.exe
      
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "CastlevaniaTheLecardeChronicles.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        # POL_System_unzip "spelunky_1_1.zip" -d "$WINEPREFIX/drive_c/game/"
        
        # Extract without sub-folder.
        # unzip "acespeeder2.zip" -j -d "$WINEPREFIX/drive_c/"
        
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
         
        # cd  "$WINEPREFIX/drive_c/game/"
        POL_Wine "GameInstaller.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        # rm GameInstaller.exe
        
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
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
              
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
   
        # POL_Shortcut "Setup.exe" "$TITLE - Setup" "" "" "$SOFTWARE_CATEGORIES"
             
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
   
# POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"      
        
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXt50AQAKCRDlMfrJqhPK
R+FyAJ4gAHBpo0cdgFYMrZynkTj4vpzmRQCfXAyN9K2xQwKoIzZ+/GIYgEwZR2U=
=N7QV
-----END PGP SIGNATURE-----
