#!/bin/bash
# Date : (2013-02-22 ??-??)
# Last revision : see changelog
# Distribution used to test : Kubuntu 18.04 amd64
# Author : Robbz
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [SuperPlumus] (2013-07-24 11-32)
#   Update gettext messages.
# [Bratzmeister] (2015-11-17 10-38)
#   Added Support for the new mandatory 64bit client and improved fps with CSMT.
# [Dadu042] (2019-06-30 19-58)
#   Wine 1.7.55-staging -> 4.0.1
#   vcrun2008 -> vcrun2010 because I saw in the game files that hte software uses this one.
#   Add message 'do not install the DirectX package'.
# [Dadu042] (2020-02-13 21:20)
#   New test unsuccessful.
#   Add POL_RequiredVersion.
# [Dadu042] (2020-05-21 14:00)
#   New test unsuccessful.
# [Dadu042] (2020-08-05 10:00)
#   Wine 5.7 -> 5.13
#   New test, now I can pass the Daybreak logo, can login, accept EULA then BattlEye EULA, start download.
#
#
# KNOWN ISSUES
#  - Wine amd64 5.12: after clicking the button 'Play', the game crash immediately because of BattlEye anticheater ('Starting BattlEye Service...'   'Failed to initialize BattlEye Service: Driver Load Error (31).')
#  - Wine amd64 5.13 (2020-08-09): error window 'BattlEye Launcher. Unsupported operating system architecture. Game only runs on 64-bit Windows.' I think that the script switched to Wine 32bits because Wine 5.13 was not available yet in 64bits.
#  - Wine amd64 2.22, 3.0.5, 4.0.1, 4.11, 5.1: Installer does crash on the 'black window with the reg logo 'Daybreak' in the middle appear':
#  The window about the firewall does appear, then the window asking the installation location, Install, I cancel DirectX installation. Some files are downloaded. The black window with the reg logo 'Daybreak' in the middle appear (it's Launchpad.exe), and many error window telling: 'GameLauncherCefChildProcess.exe' had a serious issue and has to be closed (it's wine that does crash, POL's log show: 'wine: Unhandled page fault on write access'). Then the installer closes.
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="PlanetSide 2"
PREFIX="planet-side2"
WORKING_WINE_VERSION="5.12"
PUBLISHER="Sony Entertainment"
GAME_URL="https://www.planetside2.com/"
AUTHOR="Robbz"
    
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
# Components
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_dxdiag
   
POL_SetupWindow_message "Note: do not install the DirectX package provided by the game, when you will be asked." "$TITLE"
   
   
# Useless (2015)
# POL_Call POL_Install_dxfullsetup
   
# Useless 2019 (This enabled CSMT. Now it's default setting in wine)
# POL_Wine_UpdateRegistryWinePair 'DllRedirects' 'wined3d' 'wined3d-csmt.dll'
    
# Asking about minimum memory size of graphic card
# POL_SetupWindow_VMS "256"
    
# Download
cd "$WINEPREFIX/drive_c"
POL_Download "https://launch.daybreakgames.com/installer/PS2_setup.exe"
    
POL_SetupWindow_message "$(eval_gettext 'Attention: After installation is complete, the patcher will load. Please close the patcher before logging in to complete the installation. After this, you can run "$TITLE" when setup is done.')" "$TITLE"
    
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$WINEPREFIX/drive_c/PS2_setup.exe"
POL_Wine_WaitExit "$TITLE"
    
# Create Shortcuts
POL_Shortcut "LaunchPad.exe" "$TITLE" "$TITLE.png" "" "Game;Shooter;"
    
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzAE8gAKCRDlMfrJqhPK
R/iRAKCUUoUoFpoBCVQ4k+mdCWvwOOzqngCgk4zNSdeXp+wj0bVY0Js2iwwG8UY=
=t6nJ
-----END PGP SIGNATURE-----
