#!/bin/bash
# Date : (2015)
# Last revision : see the changelog below
# (latest) Distribution used to test : Kubuntu 18.04 x64
# Author : schotty
# Licence : GPLv3
# PlayOnLinux: 4.3.4
# Notes: Pulls in the US instsallation file for Battle.Net.  Not aware of issues outside of North America or the US, but this might be the cause if any do arise.
 
# CHANGELOG
# [schotty] (2015-08-21)
#   First script.
# [BiTSHiFT] (201x)
#   Language switch.
# [7z4r] (2016-07-26)
#   working fix for Hearthstone & HotS.
#   wine 1.9.2 -> 1.9.15
#   POL_SetupWindow_VMS "1024" -> "64" (minimum for Hearthstone).
# [BlondeValor, applied by 7z4r] (2016-07-28)
#   More POL_Wine_OverrideDLL.
# [oloc] (2016-11-09)
#   win7 -> winxp
#   More POL_Wine_OverrideDLL.
# [schotty] (2016-11-24)
#   wine 1.9.15 -> 1.9.23
#   Disable POL_Wine_OverrideDLL (not necessary anymore).
# [Fivelek (2017-04-30)
#   Improved version to make the launcher fully functional without some UI bugs that we had before (dropping menus, etc...).
#   Warning message (winxp required to install, then switching to win7 is possible).
# [Dadu042] (2019-11-10)
#   Add changelog.
#   Wine 1.9.15 -> 4.0.2
# [Dadu042] (2020-03-15)
#   Clean up.
#   Wine 4.0.2 -> 4.0.3 (not tested. Perhaps 4.21 could be OK).
#   Add POL_RequiredVersion (v4.3.4).
 

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="battle.net"
WINEVERSION="4.0.3"
TITLE="Battle.Net"
EDITOR="Blizzard Entertainment Inc."
GAME_URL="http://us.battle.net/en"
AUTHOR="Schotty"
  
# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2599
  
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
POL_SetupWindow_menu_list "$(eval_gettext 'Please choose your desired locale')" "$TITLE" "enGB~enUS~deDE~esES~frFR~ruRU~itIT~ptPT" "~"
CLIENT_NAME="Battle.net-Setup-"$APP_ANSWER".exe"
DOWNLOAD_BASE="http://dist.blizzard.com/downloads/bna-installers/322d5bb9ae0318de3d4cde7641c96425/retail.1/"
POL_System_TmpCreate "$PREFIX"
  
cd "$POL_System_TmpDir"
POL_Download "$DOWNLOAD_BASE$CLIENT_NAME"
  
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
  
# Configuration
Set_OS "winxp"

# POL_Wine_OverrideDLL "native,builtin" "*msvcr90" "msvcp100" "dbghelp"
# not sure if this is really needed (2016):
# POL_Wine_OverrideDLL "disabled" "d3dcompiler_46"
  
# Dependencies
POL_Call POL_Install_corefonts
  
# Installation
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Do not close $TITLE until installation completes. When you are at the $TITLE login window, please close it. ')" "$TITLE"
  
POL_Wine "$POL_System_TmpDir/$CLIENT_NAME"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
POL_SetupWindow_VMS "64"
POL_Wine_reboot
  
# Create Shortcut
POL_Shortcut "Battle.net Launcher.exe" "$TITLE" "" "" "Game;"
 
# 2016 note:
POL_SetupWindow_message "$(eval_gettext 'Wine has been configured with Windows XP as the Windows version to make the launcher works properly. You will have to change the Windows version to Windows 7 or higher (and install some components and/or DLLs) to play some games like Overwatch.\nChanging the Windows version for an higher version breaks some app functionalities but it does not prevent you from launching games. ')" "$TITLE"
 
# Cleanup
POL_System_TmpDelete
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXm3iKAAKCRDlMfrJqhPK
R70mAJwLWpArfj+UDKmdiJcKIdl0PvLC7wCfUlb6dNgr93cKLBlaMvaXJszDwcI=
=43w8
-----END PGP SIGNATURE-----
