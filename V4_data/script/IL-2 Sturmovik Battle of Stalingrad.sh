#!/bin/bash

# Date: (2018-11-24 20-00)
# Last revision: (2018-11-24 20:00)
# Wine version used: 3.20
# Distribution used to test: Ubuntu 18.04.1 (Bionic Beaver)
# Author : Denis Lobanov
# Licence : GPL
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="IL-2 Shturmovik Battle of Stalingrad"
EDITOR="vim"
PREFIX="IL2_BoS"
WORKING_WINE_VERSION="3.20"
GAME_VMS="4096"
 
# Starting the script
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_SetupWindow_VMS $GAME_VMS
POL_Wine_Direct3D "UseGLSL" "enabled"

# Installing mandatory dependencies
POL_Wine_SetVideoDriver
cd "$WINEPREFIX/drive_c"
POL_Download "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
chmod +x winetricks

POL_Wine_WaitExit "corefonts"
./winetricks corefonts


POL_Wine_WaitExit ".Net 4.0"
./winetricks -q dotnet40

# Switch to the Win10
Set_OS "win10"

# Download installer and start it
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_browse "Please select the installation file to run." "$TITLE"
        POL_SetupWindow_wait "Installation in progress." "$TITLE"
        POL_Wine start /unix "$APP_ANSWER"
        POL_Wine_WaitExit "$TITLE"
else
        # Downloading file from the Internet
        POL_System_TmpCreate "il2bos_tmp"
        cd "$POL_System_TmpDir"
        POL_Wine_WaitExit "$TITLE"
        POL_Download "http://cdn.il2sturmovik.net/x64/IL2_setup_BoS.exe"
        POL_Wine start /unix "IL2_setup_BoS.exe"
        POL_Wine_WaitExit "$TITLE"
        POL_System_TmpDelete
fi

# Required for Launcher
Set_Desktop "On" "1024" "768"

# Making shortcut
POL_Shortcut "Launcher.exe" "$TITLE - Updater" "" ""
 
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlv5m1YACgkQ5TH6yaoTykcS6QCdGFzkZoENkm98ZQGnqGmTnViS
VikAoKBCBvb9si/SJwk5ZmocesrBbSdR
=ln74
-----END PGP SIGNATURE-----
