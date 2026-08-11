#!/bin/bash
# Date : (2013-03-16 21:00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : ArchLinux x64
# Author : rcmn
# Revision : BlondVador (Valentin PERRUSSEL)
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [rcmn] (2013-03-16 21:00)
#   First script.
# [BlondVador] (2015-11-19 03:18)
#   ?.
# [Dadu042] (2019-11-27 15:30)
#   Wine 1.7.55 -> 2.22.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Anno 2070 Steam"
PREFIX="Anno2070Steam"
EDITOR="Ubisoft"
GAME_URL="Ubisoft" "http://anno-game.ubi.com/anno-2070/en-GB/home/"
AUTHOR="rcmn"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"
 
# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/anno_2070/top.jpg" "http://files.playonlinux.com/resources/setups/anno_2070/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Digital Download version
POL_SetupWindow_InstallMethod "STEAM"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dx11
POL_Call POL_Install_corefonts
Set_OS "winxp"
POL_Wine_Direct3D "UseGLSL" "disabled"
Set_WineWindowTitle "$TITLE"
POL_Wine_OverrideDLL "builtin,native" "msvcr100"
cd "$POL_System_TmpDir"
POL_Wine_OverrideDLL "native,builtin" "winhttp"
 
# Mandatory pre-install fix for steam
STEAM_ID="48240"
POL_Call POL_Install_steam_flags "$STEAM_ID"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
 
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
 
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXd6J/AAKCRDlMfrJqhPK
RxEEAJ4mWDDmDPZTcCZLfASJ7W7ZYEhvdACeM4hYaKYJaRo0jLTg4rLeUpqivv0=
=KtRj
-----END PGP SIGNATURE-----
