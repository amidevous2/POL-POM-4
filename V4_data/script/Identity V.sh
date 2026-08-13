#!/bin/bash
# Date : (2019-09-15)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - identityv_setup_release_oversea_0828.exe (2020-09, 'Game Version: 1.0.402277')
#
# Software based on: DirectX 9, Messiah Game Engine ?
#
# CHANGELOG
# [Dadu042] (2019-09-15 09-00)
#   Initial writting.
#
# KNOWN ISSUES:
#   Wine amd64 5.0.2: The EULA is not displayed correctly (squares instead of characters). Tried: corefonts, POL_Install_RegisterFonts.
#   Wine amd64 5.0.2: the game fail to launch after login with a Gmail account (via 'Login using a browser'). Fix: login gmail, then select Android.
#   Wine amd64 5.0.2: installing crypt32 component does prevent the game to launch.
#
#
# KNOWN ISSUES (FIXED):
 
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Identity V"
PREFIX="IdentityV"
EDITOR="NetEase Games"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Dadu042"
GAME_VMS="1024"
GAME_URL="http://idv.163.com/"
      
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
     
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
# POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
#######################################
#  Installing mandatory dependencies  #
#######################################

# Trying to display the license agreement (otherwise there characters are squares).
#  POL_Call POL_Install_corefonts       # useless
#  POL_Call POL_Install_RegisterFonts   # useless
#  POL_Call POL_Internal_InstallFonts   # useless


# This make more mess than help.
# POL_Call POL_Install_crypt32

# Useless to remove those debug lines:   fixme:d3d9:shader_validator_Instruction iface 
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43


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
 
# POL_SetupWindow_message "IMPORTANT: Do finish the installation before to try to play." "$TITLE"
 
        cd "$HOME"
        POL_SetupWindow_browse "Please select the .EXE file:" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
#        cd "$POL_System_TmpDir"

    
POL_Shortcut "dwrg.exe" "$TITLE" "" "" "Game;AdventureGame;"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX9n8YAAKCRDlMfrJqhPK
R2sMAJ0QTukiU7exdkVaJi3CC/6WXbXHhACgmycgs7f3yitUIPn6IrruGRlaExY=
=KkHm
-----END PGP SIGNATURE-----
