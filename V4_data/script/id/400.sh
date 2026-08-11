#!/bin/bash
# Date : (2009-05-29)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: retail DVD-ROM v1.0 (FR/EN/DE) .
#
# Middlewares used by this software : vcrun2008, Bink, dotnet20.
#
# CHANGELOG
# [NSLW] (2009-05-29 18-00)
#   Initial script.
# [Dadu042] (2020-01-14 20:30)
#   Rewrite script.
#   Still needed ?: gecko, dotnet20
# [Dadu042] (2020-01-19 23:30)
#   Can force DirectX 11 instead of 12 (default). Not tested because my release (DVD-ROM v1.0) does not has 'Grid_dx12.exe' .
#
# KNOWN ISSUES:
#  - Wine amd64 3.0.3, 3.20, 4.0.3, 4.21: crash when launching a race.
#        007a:err:d3d:wined3d_debug_callback 0x573a568: "GL_OUT_OF_MEMORY in glMapBufferRange(map failed)".
#        Note: after changing VMS from 512 to 1024 (in POL settings), the game started but crashed 2 sec later.
#        Tried: game patched to v1.3, dotnet40, d3dx9_43 + compiler, NoCD for v1.3, shadows disabled (and also multi sampling). Then worked with Wine 4.21
#
#        To try: dotnet20
#
#  - Wine amd64 3.0.3, 3.20, 4.0.3, 4.21, 5.0: crash some dozen of seconds after a race did start (if sometimes it does start).
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 4.0.3: X


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="Race Driver: Grid"
PREFIX="race_driver_grid"
EDITOR="Codemasters"
GAME_URL="https://en.wikipedia.org/wiki/Race_Driver:_Grid"
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME="GRID.exe"
SOFTWARE_CATEGORIES="Game;SportsGame;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE="Readme.html"
    
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
POL_Wine_PrefixCreate "4.21"

POL_System_TmpCreate "$PREFIX"

Set_OS "win7"
    
#######################################
#  Installing mandatory dependencies  #
#######################################

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
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Useful for Nvidia GPUs
POL_Call POL_Install_physx
    
    
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
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
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
         
        # POL_Call POL_Function_NoCDWarning
  
        POL_SetupWindow_check_cdrom "ISSetup.dll"
        POL_Wine start /unix "$CDROM/setup.exe" 
        
        POL_Wine_WaitExit "$TITLE"
     
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
        
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
 
 
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
        # POL_SetupWindow_message "$(eval_gettext 'Note: this script can only download the demo.')" "$TITLE"
        POL_Download "http://biomediaproject.com/bmp/files/gms/tlomn/Launcher/setuprebuilt.exe"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
 
        POL_Wine "setuprebuilt.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
        
	# Restore screen resolution (game's default is 1024x768 ?)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
     
        # POL_Shortcut "l.exe" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
    
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.EXE')~$(eval_gettext '.RAR')" "~"
        # APP_ANSWER=".EXE"
    
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
	# POL_Shortcut_QuietDebug "$TITLE"

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

# enable 1920x1080 screen (from https://www.playonlinux.com/en/topic-12621.html )
# sed -e 's/maxWidth="1280"/maxWidth="1920"/' -i "$WINEPREFIX/drive_c/GOG Games/Race Driver GRID/system/hardware_settings_restrictions.xml"

################
# Patch update #
################

POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"      

if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

############################
# Force DirectX 12 -> 11 ? #
############################

# REF: https://www.protondb.com/app/703860
# REF: https://www.playonlinux.com/en/topic-8634-Race_Driver_Grid_Not_Starting.html

POL_SetupWindow_menu "$(eval_gettext 'Do you want to force DirectX 11 instead of 12 (default) ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"      

if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
	cd "$WINEPREFIX/drive_c/Program Files/Codemasters/GRID"
	mv Grid_dx12.exe Grid_dx12.exe_bak
	mv Grid.exe Grid_dx12.exe
fi

# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
 
# Fail ?
# POL_SetupWindow_message "$LNG_FIN" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXsFV7QAKCRDlMfrJqhPK
Rz5xAJ9zRCpwg4+mH6MccLwC8vhO3EnB6QCfTOpZPymFzZwxsTTpKSQoMVoa4dw=
=kg5p
-----END PGP SIGNATURE-----
