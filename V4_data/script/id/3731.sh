#!/bin/bash
# Date : (2019-12-04)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions: 18.8.42_EP1 (versions.id), auto updated to 18.8.44
#
# Middlewares used by this software : vcrun2010.
#
# CHANGELOG
# [Dadu042] (2019-12-04 23:50). Tested with game v18.8.44_EP1
#   First script.
# [Dadu042] (2020-07-17 12:00). Tested with game v18.8.53
#   Wine 4.0.3 -> 5.0.1
#   Add download feature.
# [Dadu042] (2020-07-19 12:00)
#   Cleanup.
#   Add POL_Install_gecko and POL_Install_corefonts
# [Dadu042] (2020-07-20 12:00)
#   Replace POL_Wine_WaitBefore with POL_Wine_WaitExit
#
#
# KNOWN ISSUES:
#  - Wine x86 4.0.3, 4.0.4, 4.21, 5.0.1: does crash when launched, however the game does continue to run. Tried: --ignore-errors
#  - Wine x86 4.0.3, 4.21, 5.0.1: the end user agreement window does reappears at each launch of the game.
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 4.0.3: fail to start once installed. Tried: install vcrun2010, gecko. To try?: ie6  dotnet20 vcrun2005 vcrun6. Fix: win7 -> winxp, Related bug : https://bugs.winehq.org/show_bug.cgi?id=44516
#  - Wine x86 4.0.3: some lines reports in the log (fixme:ieframe, fixme:wininet). To try: install gecko, wininet. Less lines with Wine 4.21
#
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Anarchy Online (Original Client)"
PREFIX="Anarchy_Online_Original_Client"
EDITOR="Funcom"
GAME_URL="https://en.wikipedia.org/wiki/Anarchy_Online"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="5.0.1"
GAME_VMS="256"
SHORTCUT_FILENAME="AnarchyOnline.exe"
SOFTWARE_CATEGORIES="Game;RolePlaying;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
       
# Starting the script
POL_SetupWindow_Init
           
# Starting debugging API
POL_Debug_Init
          
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
        
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
 
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (FYI: a iGPU Intel HD Graphics 530 does only become comfortable with low details).')" "$TITLE"
         
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
          
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
  
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
Set_OS "winxp"
  
     
#######################################
#  Installing mandatory dependencies  #
#######################################

POL_Call POL_Install_corefonts

# Not use if it's useful for this game
POL_Call POL_Install_gecko

# POL_Call POL_Instatl_directmusic
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_msxml4
# POL_Call POL_Install_riched30
# POL_Call POL_Install_phzysx
# POL_Call POL_Install_corefonts
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_mono210

#############################################
#  Sound problem fix - pulseaudio related   #
#############################################

## Sound problem fix - pulseaudio related
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

             
#######################################
#  Main part of this script           #
#######################################

# Choose between Steam and other Digital Download versions
# POL_SetupWindow_InstallMethod "STEAM,DVD,LOCAL,DOWNLOAD"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    
POL_SetupWindow_message "Note: at the end of the installation, please do not run the game." "$TITLE"
 
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
        
        POL_SetupWindow_check_cdrom "SETUP.EXE"
        POL_Wine start /unix "$CDROM/SETUP.EXE"
        POL_Wine_WaitExit "SETUP.EXE"
    
        # Restore screen resolution (game's default is 800x600 ?)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
       
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
        POL_Download "http://update.anarchy-online.com/download/AO/AnarchyOnline_EP1.exe"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        POL_Wine start /unix "AnarchyOnline_EP1.exe" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
   
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
    
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "Anarchy Online/Readme.txt"
           
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        # POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
        APP_ANSWER=".EXE"
           
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        # POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE" # "/SILENT"
        POL_Wine_WaitExit "$TITLE"
  
        # Restore screen resolution (game's default is 1024x768)
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
     
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_Document "$TITLE" "Anarchy Online/Readme.txt"
     
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
#      GPU     #
################
         
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
          
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
           
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
 
POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxXxZgAKCRDlMfrJqhPK
RwqrAKCXQW/qwwfacX2WbK+EfzGTiqoI1QCgkE1s8GsuDrKNQ9/CmWtZH30orl4=
=YsZK
-----END PGP SIGNATURE-----
