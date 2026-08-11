#!/usr/bin/env playonlinux-bash
# Date : (2019-04-17 11-14)
# Last revision : see changelog
# Wine version used : see script
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# This game is a hex-based MMORTS.
#
# Middlewares used by this software : Unity ( https://appdb.winehq.org/objectManager.php?sClass=application&iId=11075 )
#
# CHANGELOG
# [Dadu042] (2019-04-17)  (game v0.8)
#   First script.
# [Dadu042] (2019-12-30) 
#   POL_RequiredVersion 4.3.4
#   Improve POL_Shortcut
# [Dadu042] (2020-05-21) (Launcher v1.3.64)
#   Wine 4.5 -> 4.21
#   Win7 -> win10 (just in case)
# [Dadu042] (2020-07-12) ('Open Alpha', Launcher v1.3.98)
#   Can now download the installer .EXE
#   Note: DXVK161 tested successfully (Xubuntu 18.04, AMD APU Ryzen 5 3400G + drivers Vulkan and AMDgpu).
#
#
# KNOWN ISSUES:
# W 4.0, 4.0.4 64b + v0.8 : starborne patcher "Unhandled exception: page fault on read access to 0xc0008e1a8 in 64-bit code (0x000000007bca04ed)."
# W 4.0 32b ? + 0.8 : starborne patcher "Unhandled exception: page fault on read access to 0xffffffffffffffff in 64-bit code (0x000000007bc5a1b8)."
# W 4.5 64b + 0.8 : starborne patcher does stall of "Updating: Launcher. Downloading package..."
# W 4.5 64b + 0.8 : often "No mouse nor keyboard on main menu". Creating a virtual desktop prevent that.
# All Wine versions : After ALT+TAB or using another Window, mouse and keyboard are disabled on the game window. Virtual desktop does workaround that.
# W 4.5 64b + 0.8 : jerky music when launching a game session.
# W 4.5, 4.21 + 2020-05 version : on the login screen, typing on the keyboard does not display character. Fix: end the installation, then relauch the game. Fix: warning message added.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Starborne"
PREFIX="starborne"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Dadu042"
EDITOR="Solid Clouds"
GAME_URL="https://www.solidclouds.com"
SHORTCUT_FILENAME="Launcher.exe"
SOFTWARE_CATEGORIES="Game;StrategyGame;"    
DOCUMENT_FILE=""


POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win10"

    
#######################################
#  Installing mandatory dependencies  #
#######################################

POL_Call POL_Install_d3dx11
  
# Try to fix the jerky music when launching a game session:
# POL_Call POL_Install_dsound  <- this freeze my PC (Wine 4.6, game v0.8)
 
################
#      GPU     #
################
 
POL_SetupWindow_VMS "256"
 
POL_Wine_SetVideoDriver
  
###############
# Go          #
###############
    
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_SetupWindow_message  "WARNING: Do not run (nor try to login into) the game at the end of the installation, you must exit the game in order to finish the installation first.\n" "$TITLE"
             
# Begin game installation
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE" # "/silent"
        POL_Wine_WaitExit "$TITLE"
                  
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
            
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
                     
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        cd "$WINEPREFIX/drive_c"
            
        # POL_SetupWindow_message "$(eval_gettext '\n\nNote: this script will download the demo .')" "$TITLE"
        POL_Download "https://starbornecdn.azureedge.net/files/installers/StarborneInstaller.exe"
   
        mv StarborneInstaller.exe GameInstaller.exe
             
        POL_Wine "GameInstaller.exe" # "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
    
        rm GameInstaller.exe
            
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
        POL_Shortcut_QuietDebug "$TITLE"
            
        POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"
fi     
           
  
#######################################
# Create a 'virtual desktop' (window) #
#######################################
  
# Workaround to fix the "No mouse nor keyboard on main menu":
  
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"
  

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYBKRpgAKCRDlMfrJqhPK
RxpqAJ4iltdIVXLnx0HvY3VV403MU5i4SACfVp4HJ9XBQbXy895HM1d3VlMxzUw=
=Klcv
-----END PGP SIGNATURE-----
