#!/bin/bash
# Date : (2020-08-12)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits (Linux kernel v5.4). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: v2.4.6.3072 (2017 ?)
#
# Middlewares used by this software : FlashPlayer (for playing 'Live TVs').
#
#
#
# CHANGELOG
# [Dadu042] (2020-08-12 14-00)
#   Initial script.
#
# KNOWN ISSUES :
#  - Wine x86 4.0.4: the default skin GUI is poor. Workaround: change it in the tab Skin ('General' -> 'OsThemes'). Tried: scritp should edit registry (does not work...).
#  - Wine x86 4.0.4, 5.0.1, 5.13: network seems to fail to connect: 'err:wininet:open_http_connection create_netconn failed: 12029'. Tried: Wininet,  open port number (random) 16967, crypt32, winhttp.
#               (same issue with Wine 2.22 and 3.0.3)
#  - Wine x86 4.0.4: network seems to fail to connect: 'err:hnetcfg:get_typeinfo GetTypeInfoOfGuid({04244c8d-e483-fff0-71fc-5589e5575653}) failed: 8002802b'
#  - Wine x86 4.0.4: network seems to fail to connect. Tried OS win7 -> winxp -> win98 (now some chatrooms does appears in 'Chat', but the status in the titlebar is still '<Connecting>').
#  - Wine x86 4.0.4, 4.21: playing radio does not work (no sound, ':fixme:msacm:PCM_StreamOpen Unsupported source bit depth: 32').
#
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.1: X
 
      
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Ares Galaxy"
PREFIX="ares-galaxy"
EDITOR=""
GAME_URL="https://en.wikipedia.org/wiki/Ares_Galaxy"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="128"
SHORTCUT_FILENAME="Ares.exe"
SOFTWARE_CATEGORIES="Utility;"
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
# POL_System_SetArch "auto"
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "4.0.4"

# POL_System_TmpCreate "$PREFIX"
             
Set_OS "win98"

#######################################
#  Hacks                              #
#######################################


#######################################
#  Installing mandatory dependencies  #
#######################################

# POL_Call POL_Install_corefonts
# POL_Call POL_Install_vcrun2010
# POL_Call POL_Install_dsound
# POL_Call POL_Install_directmusic
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
# POL_SetupWindow_menu_list "How much memory does your graphics board have?" "$TITLE" "64-128-256-320-384-512-640-768-896-1024-1536-1792-2048-3072-4096" "-" "256"
# VRAM="$APP_ANSWER"
# POL_Wine_Direct3D "VideoMemorySize" "$VRAM"

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


POL_SetupWindow_message "Warning: Ares Galaxy will automatically run, please close it (task bar) in order to end this installation." "$TITLE"
      
# POL_SetupWindow_message "Warning: do not install DirectX (nor the icons)." "$TITLE"
# POL_SetupWindow_message "Warning: do not install Visual C++ 2013 redistribuable\n nor Direct X." "$TITLE"
# POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"

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
        POL_Download "http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe"
           
        # mv stinger32.exe GameInstaller.exe
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

##########################
# Specific for this app  #
##########################
 
# Force the Skin to 'General' instead of 'OsThemes'.
REGFILE="$POL_USER_ROOT/tmp/ares.reg"
(echo "[HKEY_CURRENT_USER\Software\Ares]"
echo "\"GUI.LastLibrary\"=\"gen.nog\"") > "$REGFILE"
POL_Wine regedit "$REGFILE"
rm "$REGFILE"


              
POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"
        
# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"
             
# POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzPcXwAKCRDlMfrJqhPK
R+9cAJ4rHNe8IKgZuAIuqW+3C1M3A2U71QCdFOBRGEvLhZhEs5h7FzZqFQxglDc=
=x0bc
-----END PGP SIGNATURE-----
