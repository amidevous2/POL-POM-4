#!/bin/bash
# Date : (2020-03-22)
# Wine version used : 5.0
# Distributions used to test : Ubuntu 16.04, Ubuntu 18.04
# Author : magnesium
# Licence : GPLv3
# PlayOnLinux : playonlinux-4.3.4
# Components : corefonts, dinput8, d3dx9

# KNOWN ISSUES
#  - Wine x86 5.0: works good, except the journal/help page can randomly crash the game.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rise Of Agon"
PUBLISHER="Big Picture Games Ltd."
GAME_URL="https://www.riseofagon.com/"
PREFIX="RiseOfAgon"
 
WORKING_WINE_VERSION="5.0.2"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
 
POL_SetupWindow_Init
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $POL_RequiredVersion is required to install $TITLE"
POL_Debug_Init
POL_SetupWindow_free_presentation "Welcome to the PlayOnLinux Installation Wizard." " \n $TITLE created by $PUBLISHER \n\n $GAME_URL \n\n\n If you've previously installed $TITLE with PlayOnLinux, then its recommended to select \n 'ERASE' if you're asked in the next window."
 
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_Install_corefonts
POL_Call POL_Install_dinput8
POL_Call POL_Install_d3dx9
 
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
 
POL_Download "https://www.riseofagon.com/documents/17/Darkfall_RoA_Installer.exe"
 
POL_SetupWindow_message " \n When the DirectX installer comes up, click 'CANCEL'. \n\n PoL will install the necessary files. " "$TITLE"
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/Darkfall_RoA_Installer.exe"
 
# Try to minimize journal and help page crashes
POL_Wine reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" /f /v "DefaultConnectionSettings" /t "REG_BINARY" /d "4600000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
 
POL_Shortcut "Darkfall_RoA.exe" "$TITLE" "" "" "Game;"
 
POL_System_TmpDelete
 
POL_SetupWindow_message "\n Sometimes the in-game browser (journal, help, clan) crashes the game.  If it happens, be sure to kill 'sfbrowser.exe' and 'darkfall.exe' before clicking PLAY again."  "Installation complete."
 
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2n04gAKCRDlMfrJqhPK
R6/dAKCZ3kzI8lEM23eQ4Oka2nHWcZdFSgCeKXek5nKDFoEETSySbhjyZxhj1Xk=
=Lyoe
-----END PGP SIGNATURE-----
