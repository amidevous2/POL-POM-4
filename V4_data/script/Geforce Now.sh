#!/bin/bash
# Date : (2020-09-24)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits (Linux kernel v5.4.0). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: GeForceNOW-release.exe (2020-09-24, file Version 1.0.9, extractable as a ZIP file)
#
# Middlewares used by this software : DirectX 9 v47 / 11, MFC (seems to requires the MFC version from Win7 SP1), .Net
#
# Note DXVA2 is supported from Windows Vista. ref: https://docs.microsoft.com/en-us/windows/win32/medfound/about-dxva-2-0
#
#
# CHANGELOG
# [Dadu042] (2020-09-24 10-00). File version: 1.0.9
#   Initial script. Inspired from the work of 'haru-san' at https://lutris.net/games/geforce-now/
#   Currently I can not avoid the installer stop stop/fail before the end.
#
# KNOWN ISSUES :
#  - Wine amd64 5.11-staging, 5.18-staging: 'Nvidia installation program failed.' (same with OS win7/win10). Tried: DXVK_171
#    https://forum.winehq.org/viewtopic.php?t=33199&p=125413
#  - Wine x86 5.0.2 + dotnet40: 'The installation program NVIDIA can not continue'. Dotnet40 script is not 64bits compatible.
#  - Wine x86 5.0.3 + dotnet40: 'RPC server not available', then the installation does end. App v1.0.9.  Tried: Wine 6.3 (installation does end but GeForceNOW.exe is not extracted).
#
#
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.2: X

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Geforce Now"
PREFIX="Geforce_Now"
EDITOR="Nvidia"
GAME_URL="https://en.wikipedia.org/wiki/GeForce_Now"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME="GeForceNOW.exe"
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

############################################
#  Choose architecture: 32 bits or 64 bits #
############################################

# POL_SetupWindow_menu "$(eval_gettext 'What architecture do you want to use ?')" "$TITLE" "$(eval_gettext '64 bits (recommended)')~$(eval_gettext '32 bits')" "~"
 
# if [ "$APP_ANSWER" == "32 bits" ]; then
#	POL_System_SetArch "x86"
# elif [ "$APP_ANSWER" == "$(eval_gettext '64 bits (recommended)')" ]; then
#	POL_System_SetArch "amd64"
# fi

POL_System_SetArch "x86"

# Download Wine if necessary then create prefix
POL_Wine_PrefixCreate "6.3"


# POL_System_TmpCreate "$PREFIX"
             
Set_OS "win7"

#######################################
#  Hacks                              #
#######################################

# Prevent these .EXE to run when installing
POL_Wine_OverrideDLL "" "GeForceNOW.exe"
POL_Wine_OverrideDLL "" "GeForceNOWReliabilityMonitor.exe"
POL_Wine_OverrideDLL "" "GeForceNOWStreamer.exe"
POL_Wine_OverrideDLL "" "GeForceNOWContainer.exe"


#######################################
#  Installing mandatory dependencies  #
#######################################

# POL_Call POL_Install_dotnet40
# Required because of POL_Install_dotnet40
Set_OS "win10"


# Seems to avoid 'Nvidia installation program failed.'
POL_Call POL_Install_dcom98

# Perhaps useful for the Geforce's installer loading bar ?
# POL_Call POL_Install_Flashplayer_ActiveX


# POL_Call POL_Install_DXVK_171

# POL_Call POL_Install_vcrun2013
# POL_Call POL_Install_d3dx11

# Disable DirectX 11
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
# VRAM="$APP_ANSWER"
# POL_Wine_Direct3D "VideoMemorySize" "$VRAM"

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
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

# POL_SetupWindow_message "Warning: do not install Punk Buster nor DirectX." "$TITLE"
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
        POL_Download "https://download.nvidia.com/gfnpc/GeForceNOW-release.exe"
           
        mv GeForceNOW-release.exe GameInstaller.exe
        # mv Teacher%20Simulator.rar gameinstaller.rar
        # mv Lemms.zip gameinstaller.zip
           
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        # POL_System_unrar x "gameinstaller.rar" "$WINEPREFIX/drive_c/game/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        # POL_System_unzip "gameinstaller.zip" -d "$WINEPREFIX/drive_c/game/"
             
        # Extract without sub-folder.
        # unzip "gameinstaller.zip" -j -d "$WINEPREFIX/drive_c/"
             
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
         
        cd  "$WINEPREFIX/drive_c/game/"
        POL_Wine "GameInstaller.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
     
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: do NOT install DirectX.')" "$TITLE"
  
        # cd "$WINEPREFIX/drive_c"
        # rm GameInstaller.exe
             
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
             
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
                  
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
             
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
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
 
# POL_SetupWindow_menu "$(eval_gettext 'Do you have a official patch-update to install ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Yes')" "~"      
             
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

#######################################
#  Hacks                              #
#  Editing configuration files        #
#######################################

# I have to succeed to finish the installation, so I had not the chance to test this command line (from the Lutris script):
# sed -i -e 's/dx11/dx9/' -e 's/nv-sdl-iohid-configurable=false/nv-sdl-iohid-configurable=true/' -e 's/nv-sdl-hidpi=false/nv-sdl-hidpi=true/' "$PREFIX/drive_c/users/$USER/Local Settings/Application Data/NVIDIA Corporation/GeForceNOW/CEF/GeForceNOWStreamer.json"



POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
             
# POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYGTAogAKCRDlMfrJqhPK
R0umAJ9OLTlTeax1gUHCP92Spr/p1OIEAACaA7nTzeoY26QjoU5UzxzW4KQRGiI=
=pDc3
-----END PGP SIGNATURE-----
