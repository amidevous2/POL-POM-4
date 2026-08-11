#!/bin/bash
# Date : (2019-06-20 23-21)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: CD-ROM v1.1 (according Readme.htm)
# Software based on: DirectX 8.1, Quicktime (2004).
#
# CHANGELOG
# [Dadu042] (2019-06-20)
#   Initial writting.
# [Dadu042] (2019-09-02)
#   Cleanup. Comments.
#
# Known issues:
#   Wine x86 2.22, 3.0.5, 4.0.1, 4.0.2, 4.11: Installation fail (loop) when creating the game folder ('Eidos Interactive\Beach Life'). Tried: install MFC42, xmllite, msxml6.
#       From a .ISO : no problem.  I think the issue was that the files were copied from the CD to the HDD.
#   Wine x86 4.0.2: game fail to launch (log: GStreamer issue). Tried: amstream, quartz, ffdshow.


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Beach Life"
PREFIX="beach-life"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Eidos Interactive"
GAME_URL="https://en.wikipedia.org/wiki/Beach_Life"
      
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
POL_RequiredVersion 4.2.12 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_SetArch "x86"
POL_System_TmpCreate "$TITLE"
 
Set_OS "winxp"
 
# Seems required for the installer (otherwise it can create the folder and loop the window of the pathname target)
# POL_Call POL_Install_mfc42

# POL_Call POL_Install_amstream

# POL_Call POL_Install_msxml6

# Useless ?
# POL_Call POL_Install_vcrun2005
 
###############
# GPU         #
###############
 
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Install_VideoDriver
  
# Asking about memory size of graphic card
# GAME_VMS="16"
# POL_SetupWindow_VMS "$GAME_VMS"
 
 
###############
# Go          #
###############
    
POL_SetupWindow_InstallMethod "LOCAL"
    
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "BeachLife.exe" "$TITLE" "" "Game;StrategyGame;"
       
POL_Shortcut_Document "$TITLE" "Readme.htm"
 
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
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZYXTxAAKCRDlMfrJqhPK
R9buAJ9H7vKV0TmOlZERsSL904vBguZcEACfWkXtA/nA4vdFoOdZSpfEsha2vm4=
=qb8K
-----END PGP SIGNATURE-----
