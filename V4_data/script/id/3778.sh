#!/bin/bash
# Date : (2020-01-01)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: DVD-ROM EU (folders date: march 2005).
#
# Middlewares used by this software : DirectX 9.
#
# CHANGELOG
# [Dadu042] (2020-01-01)
#   First script. Wine 4.0.3
#
# KNOWN ISSUES:
#  - Wine amd64 4.0.3, 5.0-rc3: a window says that DRM prevent the game to run. Tried: Wine 4.21 (no message but same issue). Fix: NoCD patch.
#  - Wine amd64 4.0.3: intro video does not play, but the main menu is OK. Log: 'Required media codec 'vidc IV32' not found!'. Tried: iv50 (not compatible amd64 ? or break ?).
#  - Wine amd64 4.0.3: many lines:  002c:err:d3d:wined3d_debug_callback 0x186b88: "GL_INVALID_OPERATION in glVertexAttribPointer(non-VBO array)". Fix: Wine 4.21
#  - Wine amd64 4.21: game fail to launch even with a NoCD.

# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...
     
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
        
TITLE="Special Forces: Nemesis Strike (= CT Special Forces - Fire For Effect)"
PREFIX="Special_Forces_2005"
EDITOR=""
GAME_URL="https://en.wikipedia.org/wiki/Special_Forces:_Nemesis_Strike"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION=""
GAME_VMS="128"
SHORTCUT_FILENAME="CT Special Forces.exe"
SOFTWARE_CATEGORIES="Game;Shooter;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="Read*.txt"
   
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
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
     
# Downloading wine if necessary and creating prefix
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_PrefixCreate
        
Set_OS "winxp"
   
#######################################
#  Installing mandatory dependencies  #
#######################################

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
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
   
   
#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
   
   
# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "DVD,LOCAL"
    
POL_SetupWindow_message "Warning: do not install DirectX." "$TITLE"

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
        
        POL_Call POL_Function_NoCDWarning
 
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe" "/SILENT"
        POL_Wine_WaitExit "setup.exe"
    
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
       
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
        
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
        POL_Download "https://scdn.line-apps.com/client/win/new/LineInst.exe"
        POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        POL_Wine "LineInst.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
    
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
    
        # POL_Shortcut "l.exe" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        # POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
   
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
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
        # POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
    
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
   
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

# Fail ?
# POL_SetupWindow_message "$LNG_FIN" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg0R8gAKCRDlMfrJqhPK
R4a/AKCK2FY6n3UwP6MKz2gQepgT42FoQgCeIdOPvLTvT4URt8CtwR7rV4WliSs=
=4FLJ
-----END PGP SIGNATURE-----
