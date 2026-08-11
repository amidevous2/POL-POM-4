#!/bin/bash
# Date : (2014-01-03)
# Last revision : (2014-05-30)
# Distribution used to test : Arch 64-bit, fully up-to-date as of 2014-01-05
# Author : DJYoshaBYD
# Licence : GPLv3
# PlayOnLinux: 4.2.2


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="ywriter5"
WINEVERSION="1.6.2"
TITLE="yWriter 5"
EDITOR="Spacejock Software"
GAME_URL="http://www.spacejock.com"
AUTHOR="DJYoshaBYD"

#Initialization
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
# POL_System_unzip
POL_RequiredVersion "4.1.4" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.4 is required to install $TITLE"
POL_SetupWindow_SetID 1916

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the installation archive:')" "$TITLE" "" "*.zip"
    ZIPARCHIVE="$APP_ANSWER"
else
    POL_System_TmpCreate "$PREFIX"

    cd "$POL_System_TmpDir"
    POL_Download "http://www.spacejock.com/files/yWriter5.zip" "c45b10fe20c61c4a56129f1f3e92d4b4"
    ZIPARCHIVE="$POL_System_TmpDir/yWriter5.zip"
fi

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies
POL_Call POL_Install_gdiplus
POL_Call POL_Install_riched20
POL_Call POL_Install_dotnet20sp2

# Configuration
Set_OS "winxp"

# Installation
POL_Debug_Message "Installing $TITLE..."

POL_System_unzip "$ZIPARCHIVE" -d "$WINEPREFIX/drive_c"


# Create Shortcuts
POL_Shortcut "yWriter5.exe" "$TITLE"

# Cleanup TMP folder
POL_System_TmpDelete

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXOY3YACgkQ5TH6yaoTykebDgCfSpinXxYK4+hwVDCHaNjNpthg
rY4AoKWMdpyBAlPVWo11AZbvWBlb3Cc1
=Ovoa
-----END PGP SIGNATURE-----
