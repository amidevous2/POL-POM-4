#!/bin/bash
# Date : (2016-01-05 21:11)
# Last revision : see changelog
# Wine version used : 1.9.5, 1.9.5-staging (PlayOnLinux)
# Distribution used to test : Linux Xubuntu 19.04
# Author : HunterSephir
# Licence : N/A
# Only For : PlayOnLinux
 
# CHANGELOG
# [mauriciofauth] (2016-01-05)
#   First script.
# [Dadu042] (2019-11-20 15:00)
#   Wine 1.9.5 -> 3.0.3
#   GAME_VMS="2048" -> 256
#   Issue: Steam does fail to load.
# [Dadu042] (2019-11-20 15:40)
#   Disable POL_Wine_SetVideoDriver because this is not a 3D game.
#   Cleanup.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Brawlhalla"
PREFIX="Brawlhalla"
EDITOR="Blue Mammoth Games"
GAME_URL="http://www.brawlhalla.com/"
AUTHOR="HunterSephir"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
STEAM_ID="291550"
 
# Starting the script
POL_GetSetupImages "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1005
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading Wine if necessary and creating prefix
# POL_System_SetArch "x86" # For dotnet/mono
POL_System_SetArch "amd64" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam
 
# Fix PulseAudio issue
which pulseaudio && Set_OS "win7"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver
 
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"
 
# Shortcut done before install for Steam version
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID" "Game;RolePlaying;"
# POL_Shortcut "steam.exe" "Steam ($TITLE)" "" "" "Game;"
 
# Begin game installation
POL_SetupWindow_Close

# Steam install
#POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished, do NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdVQ6gAKCRDlMfrJqhPK
R8e9AJ4gbSDp9hBbDmbLER0jH0Q1B12nlgCfadOglJxIsGp/yFLGVKjoxTfn3IM=
=DWZn
-----END PGP SIGNATURE-----
