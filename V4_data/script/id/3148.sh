#!/bin/bash
# Date : (2017-03-17 08:00)
# Last revision : (2017-03-21 22:29)
# Wine version used : 1.8-rc1
# Distribution used to test : Linux Mint 18.1 x64
# Author : José Gonçalves
# Only For : http://www.playonlinux.com
 
## Begin Note ##
# Some errors occurs when the dotnet 3 and 3.5 press next to continue installation
## End Note ##
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="XenCenter.exe"
PREFIX="XenCenter"
FILENAME="XenCenter.exe"
EDITOR="The Xen Project XenSource, Inc."
DOC_URL="https://xenserver.org/download-older-versions-of-xenserver.html"
AUTHOR="José Gonçalves"
GAME_VMS="128"
 
# Starting the script
POL_GetSetupImages "https://raw.githubusercontent.com/Tosta-Mixta/XenCenter-PlayOnLinux/master/xen_icon.png" "https://raw.githubusercontent.com/Tosta-Mixta/XenCenter-PlayOnLinux/master/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$DOC_URL" "$AUTHOR" "$PREFIX"
 
# Setting Wine Version
WORKING_WINE_VERSION="1.8-rc1"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Choose a 32-Bit or 64-Bit architecture (64bit is currently not supported)
POL_SetupWindow_menu_list "$(eval_gettext 'Select architecture')" "$TITLE" "x86" "~" "x86"
ARCHITECTURE="$APP_ANSWER"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "$ARCHITECTURE"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing additional components
POL_Call POL_install_dotnet45 
POL_Call POL_Install_ie8
POL_Call POL_Install_tahoma2

# Choose between Downloading client or using local one
POL_SetupWindow_InstallMethod "LOCAL-DOWNLOAD"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Seems to help with random crash issue
Set_OS "win7"

# Downloading client or choosing existing one
mkdir -p "$WINEPREFIX/drive_c/$PROGRAMFILES/Citrix/XenCenter"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Donwloading client
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Citrix/XenCenter" || return
        POL_Download "http://downloadns.citrix.com.edgesuite.net/10341/XenServer-6.5.0-SP1-XenCenterSetup.exe"
        POL_Wine "XenServer-6.5.0-SP1-XenCenterSetup.exe"

     
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
        # Asking for client exe
        cd "$HOME" || return
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cp "$SETUP_EXE" "$WINEPREFIX/drive_c/$PROGRAMFILES/Citrix/XenCenter/XenServer-6.5.0-SP1-XenCenterSetup.exe"
        POL_Wine "$WINEPREFIX/drive_c/$PROGRAMFILES/Citrix/XenCenter/XenServer-6.5.0-SP1-XenCenterSetup.exe"
fi

# Making shortcut
POL_Wine_WaitBefore "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Citrix/XenCenter" || return
POL_Shortcut "$FILENAME" "$TITLE"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNWwVgAKCRDlMfrJqhPK
RzzsAJ9cWMklQ7K0Cmc7vbhootFf1ABbdQCffa3N26DAgsMhc7Ix9bB4kuCEi6A=
=41TX
-----END PGP SIGNATURE-----
