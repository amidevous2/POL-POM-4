#!/bin/bash
# Date : (2019-09-17)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - X  (GameCenter shows: 'Version 11.0.01.35.1 of 09.09.2020')
#        - As of 2021-02, GameCenter shows: 'Version 4.1614 rev 56243' in the About window).
#
# Software based on: My.com GameCenter.
#
#
#
# CHANGELOG
# [Dadu042] (2019-09-17 20-00)
#   Initial writting.
#   As of 2020-09-19, the installer blocks because it does see a too old Windows version. Wine 4.21-staging.
# [Dadu042] (2021-02-05 12:00)
#   Enable download .EXE
#   Wine 4.21-staging -> 5.22-staging, but impossible to use because I have the 'black window' issue (in the Game center).
#
# KNOWN ISSUES:
#   Wine amd64 4.21-staging: the installer stops  because it thinks the OS is Vista or earlier (winxp). I used: win7, win8 
#   Wine amd64 5.0.2, 5.12: some characters are missing (ie: in the yellow box). Fix: Wine 4.21-staging
#   Wine amd64 5.8-staging, 5.9-staging, 5.10-staging: after clicking the yellow button (Play) the screen does freeze.
#   Wine amd64 5.11-staging: nothing does appears (not even the GameCenter).
#   Wine amd64 5.0.3, 5.22-staging, 6.0, 6.0-staging: the game center does appear, but the only the title bar is displayed, the bottom is black.
#
#
# KNOWN ISSUES (FIXED):
#   Wine amd64 5.0.2, 5.12: after the yellow button (play) a window titled 'MY.GAMES GameCenter' does appears, but without any content. Perhaps that the identify stage does fail (bcrypt related ?). Fix: Wine 4.21-staging 
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="My.Games Game Center"
PREFIX="My.Games"
EDITOR="My.Games"
WORKING_WINE_VERSION="5.22-staging"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="https://store.my.game"
       
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
      
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
      
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
# POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win8"
  
#######################################
#  Installing mandatory dependencies  #
#######################################
 
POL_Call POL_Install_corefonts
 
# POL_Call POL_Install_d3dx9
# POL_Call POL_Install_vcrun2010
# POL_Call POL_Install_wininet
 
################
#      GPU     #
################
            
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
             
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
              
# Useful for Nvidia GPUs
POL_Call POL_Install_physx
  
  
#######################################
#  Main part of this script           #
#######################################
 
# POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD" 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
POL_SetupWindow_message "IMPORTANT: Do finish (and quit) the installation before to try to play." "$TITLE"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        cd "$HOME"
        POL_SetupWindow_browse "Please select the .EXE file:" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
  
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "https://static.gc.my.games/MyGamesLoader.exe"
#        INSTALLER="$POL_System_TmpDir/RevelationOnlineLoader_en.exe"
        POL_Wine start /unix "MyGamesLoader.exe"
        POL_Wine_WaitExit "$TITLE"
fi
     
POL_Shortcut "GameCenter.exe" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYB26WQAKCRDlMfrJqhPK
R73tAJ0Y1DwEcI9M/JyZaveBac3ctUj/xwCeOZ8TTi+cH0xDrXDyDkiHCrl5ZLc=
=GHO0
-----END PGP SIGNATURE-----
