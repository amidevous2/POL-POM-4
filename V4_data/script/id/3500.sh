#!/usr/bin/env playonlinux-bash
# Date : (2019-04-28 18-11)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64, GPU: AMD Vega 11
# Script licence : GPL3
# Program licence : ?
# Playonlinux version used : 4.3.4
#
# TESTED Editions: v1.6.0.0 (auto upgraded to v1.6.2.3).
#
# This game is based on: DirectX 9, DotNet 4.6, MS Visual C++ 2015 (all provided on the .ISO), Mono 4.8.
#
# CHANGELOG
# [Dadu042] (2019-04-28 18:11)
#   First script.
# [Dadu042] (2019-12-24)
#   Wine 4.7 -> 4.21
#   Add POL_RequiredVersion "4.3.4"
# [Dadu042] (2020-06-17)
#   Wine 5.0 -> 5.0.1 (this should not hurt. Game v1.6 is out but I have not tested it yet)
# [Dadu042] (2020-06-22)
#   Fix Set_OS (it was at a wrong place)
# [Dadu042] (2020-07-26)
#   Tried to run it again (and also from pure wine sessions) with Wine 5.13 and game v1.6.0.0. Tried: dotnet452, 461, 462, vcrun2008, vcrun2010
# [Dadu042] (2020-08-20)
#   Wine 5.0.1 -> 5.0.2 The game does now succeed to auto upgrade it self (to v1.6.2.3), but it crash when trying to play (after clicking Play). Tried: disable intro video.
#
#
#
# KNOWN ISSUES (game v1.6.0.0):
#  - Wine x86 5.0.1, 5.11 (+ dotnet40): once installed I get as soon as launched a window 'CLR error: 80004005. <OK>'. Related to Dotnet40.
#  - Wine x86 5.11, proton 4.2 (without dotnet), 5.12: game launch up to the login window, but the windows are black. Tried: mono 5.2, mono 4.8.1.
#
# KNOWN ISSUES (game v1.5.0.0):
#  - Wine x86 4.7 :
#    - Error "HTTP Status: 500" when installing game v1.5.0 (when trying to know latest game version).
#    - Fail to auto upgrade to v1.5.4.0 (screen freeze at 81% downloaded).
#    - Black screen after clicking 'Deployment' or 'Create local' (unsure where) : press Esc.
#    - Mouse slow and/or disapear on maps (where to select the deployment location). Related to Intel Graphics HD 4400 ?
#    - Online: game does not see online servers.
#
#  - Wine x86 4.21, 5.0-rc1: when installing dotnet461 a window titled 'mscorsvw.exe - Assert Failure' with message 'mscorlib recursive resource lookup bug'.
#  - Wine x86 5.0.1, 5.11 (+ dotnet40): once installed I get as soon as launched a window 'CLR error: 80004005. <OK>'. Related to Dotnet40.
#  - Wine x86 5.0.1: dotnet461 fail to install (loop on dotnet45: 'mscorlib recursive resource lookup bug').
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Project Reality: BF2"
PREFIX="project_reality"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Dadu042"
EDITOR="?"
GAME_URL="https://www.realitymod.com/"
 
     
POL_SetupWindow_Init
POL_Debug_Init
        
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_SetupWindow_message  "Warning: this script does not allow the game to work (play) online.\n" "$TITLE"
   
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
   
################
#      GPU     #
################
             
# Asking about memory size of graphic card
POL_SetupWindow_VMS "256"
              
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
               
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
   
################
# To improve ? #
################
  
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
   
# Really necessary ?
# POL_Call POL_Install_corefonts
    
# Really necessary ?
# POL_Call POL_Install_RegisterFonts
    
# A 2015 would be better... Not yet available in POL (april 2019)
# POL_Call POL_Install_vcrun2013
    
    
     
# No DotNet40fx available on Wine :(. Dotnet40 fail to let the game start.
# dotnet461 allow to the game to run, but perhaps dotnet45 could be enough.
# POL_Call POL_Install_dotnet40
 
# POL_SetupWindow_message  "Warning: If the installation of DotNet never end ( > 30 minutes), click Cancel." "$TITLE"
# POL_Call POL_Install_dotnet461
  
# OpenAudioLayer
POL_Wine_OverrideDLL "native" "openal32"
    
###############
# Go          #
###############
     
POL_SetupWindow_message  "Please note: Do not run the game at the end of the installation, first finish it.\n" "$TITLE"
    
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
cd "$POL_System_TmpDir"
     
# POL_Shortcut "PRBF2.exe" "$TITLE (to not use)" "" "" "Game;Shooter;"
POL_Shortcut "PRLauncher.exe" "$TITLE - Launcher" "" "" "Game;Shooter;"
    
# This .EXE "should be not launched manually."
# POL_Shortcut "PRUpdater.exe" "$TITLE - Updater" ""
   
Set_WineWindowTitle "$TITLE"
      
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX9ynWAAKCRDlMfrJqhPK
R94wAKCUzBnPXReiL0meW1y0nvs6PJhmjgCfdEg+3V+AOhwonZx+IZaW7nc29iI=
=Hf/v
-----END PGP SIGNATURE-----
