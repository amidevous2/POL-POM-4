#!/usr/bin/env playonlinux-bash
# **PlayOnLinux 4.2.8**
# Wine version tested: It works on all versions
# Distributions used to test: Fedora 21 Gnome and 22 XFCE, openSUSE 13.2 x86_64, Linux Mint Debian amd64
# Psiphon version: 3
# Based on community.linuxmint.com: http://community.linuxmint.com/tutorial/view/1926
# Author: Ueliton
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
# Variables -------------
AUTHOR="Ueliton"
BINU_SERVER="http://media.binu.com/12630290/stream"
PREFIX="Psiphon3"
TITLE="Psiphon3"
WINESYSTEM=""
   
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
    
POL_SetupWindow_Init
POL_SetupWindow_SetID 2583
# Enable debugging
POL_Debug_Init
# Presentation
POL_SetupWindow_presentation "$TITLE" "Psiphon Inc." "https://psiphon.ca" "$AUTHOR" "$PREFIX"
   
# Managing prefix and Wine version
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINESYSTEM"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/"
POL_System_SetArch "auto"
# Creating Temp directory ----------------
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Some dependencies
mkdir "$WINEPREFIX/drive_c/windows/syswow64"
POL_Call POL_Install_winhttp
POL_Call POL_Install_wininet

# Install Method --------------------------
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
# Installation Method DOWNLOAD
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
  then
      cd "$WINEPREFIX/drive_c/$PROGRAMFILES/"
      POL_Download "$BINU_SERVER/98561634667-9219adc5c42107c4/psiphon3.exe" "a25ca0b1b39a7f3d8a5e8b4add90537f"
      POL_Wine_WaitBefore "$TITLE"
fi
# Installation Method LOCAL
if [ "$INSTALL_METHOD" = "LOCAL" ]
  then
      cd "$HOME"
      POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file')" "$TITLE"
      POL_Wine_WaitBefore "$TITLE"
      cp "$APP_ANSWER" "$WINEPREFIX/drive_c/$PROGRAMFILES/"
fi
# Delete temp directory --------------------------
POL_System_TmpDelete
# Create a launcher
POL_Shortcut "psiphon*.exe" "$TITLE" # Using "*", if user need install other version
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPOLcwAKCRDlMfrJqhPK
R+n0AJ0fKF/OQ2jBBBPBGv5Xc2EAKW4rKgCeP45HOt6Gr8l0eXhUPcbB1J4A6BI=
=daLk
-----END PGP SIGNATURE-----
