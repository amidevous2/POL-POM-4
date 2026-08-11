#!/bin/bash
# Date : (2019-09-16)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - RevelationOnlineLoader_cd2a61df604870163855d2fbec38df4a__en.exe on the Gamecenter: 'Version 1129.52a of 13.09.2020').
#
# Software based on: Chrome web browser.
#
#
#
# CHANGELOG
# [Dadu042] (2019-09-16 10-00)
#   Initial writting.
# [Dadu042] (2019-09-17 18-00)
#   Wine 5.0.2 -> 4.21-staging (should allow to login and to play, like in the Allods script).
# [Dadu042] (2019-09-22 10-00)
#   Arch auto -> amd64
#
# KNOWN ISSUES:
#   Wine amd64 5.8-staging, 5.9-staging, 5.17-staging: after clicking the yellow button Play the Game Center does freeze. Tried: wininet
#                        Note: the current POL's staging releases 5.10 and 5.11 does fail to run (0214:err:ntdll:RtlpWaitForCriticalSection section 0xxxxxxx "../../../dlls/ntdll/heap.c: main process heap section" wait timed out).
#   Wine amd64 5.0.2, 5.16, 4.21: after accepting the EULA, the Login window that appears is empty and freeze. Tried: dwrite n,b. Fix: wine 4.21-staging ?
#   Wine amd64 4.21, 5.17: after clicking 'Play' (yellow button) the game show a window 'Game integrity test', then display a empty window 'Login' with the busy sign (circle) is turning forever. Fix: Wine 5.18-staging and 4.21-staging
#   Wine amd64 5.18-staging: in the login window, the characters typed by the user are not displayed. Tried: gdiplus
#   Wine amd64 4.21-staging, 5.18-staging: after clicking the yellow button Play, error 'Game start error. General failure. File name: ... tianyu.exe'. Tried: running manually 'tianyu64.exe' (I get a chinese error message).
#
# KNOWN ISSUES (FIXED):
#   Wine amd64 5.0.2, 5.16: 'ERROR:network_change_notifier_win.cc(141)] WSALookupServiceBegin failed with: 0'. Seems related to bcrypt, fixable with Wine-staging (according: https://forum.winehq.org/viewtopic.php?t=29792&p=113198).
#   Wine amd64 5.0.2, 5.16, 5.17, 4.21: some characters are missing (ie: in the yellow box). Fix: Wine 4.21-staging, 5.9-staging
#   Wine amd64 5.0.2, 5.16, 5.17, 4.21: the background of the launcher is empty (no web content displayed). Fix: Wine 4.21-staging
#   Wine amd64 5.9-staging: 'err:module:import_dll Library DWrite.dll (which is needed by L"C:\\users\\user-name\\Local Settings\\Application Data\\GameCenter\\Chrome\\80.3987.2146\\libcef.dll") not found'. Fix: dwrite: n,b
#   Wine amd64 up to 5.18-staging: when exiting the debug log shows lines containing '[\\ObjectTypes\\XXXXXXXXX] Object type'. Fix: riched30


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Revelation Online"
PREFIX="Revelation_Online"
EDITOR="My.games"
WORKING_WINE_VERSION="4.21-staging"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="https://www.pcgamingwiki.com/wiki/Revelation_Online"
      
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
     
POL_Wine_SelectPrefix "$PREFIX"
# POL_System_SetArch "auto"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
#######################################
#  Installing mandatory dependencies  #
#######################################

POL_Call POL_Install_corefonts

# Required at least up to Wine 5.18-staging
POL_Call POL_Install_riched30

# POL_Call POL_Install_d3dx9
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
# POL_Call POL_Install_physx
 
 
#######################################
#  Main part of this script           #
#######################################

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_SetupWindow_message "IMPORTANT: Do finish the installation before to try to play." "$TITLE" 

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
        POL_Download "https://static.gc.my.games/RevelationOnlineLoader_en.exe"
        INSTALLER="$POL_System_TmpDir/RevelationOnlineLoader_en.exe"
        POL_Wine start /unix "RevelationOnlineLoader_en.exe"
        POL_Wine_WaitExit "$TITLE"
fi
    
POL_Shortcut "GameCenter.exe" "$TITLE" "" "" "Game;"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX3gzAQAKCRDlMfrJqhPK
R2ptAJ0UtNQSLm7YNBIa8cUQjeVeSbjpWgCeLHJHb0HA75qU7reT953dDBZcoUQ=
=CuAi
-----END PGP SIGNATURE-----
