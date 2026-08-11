#!/bin/bash
# Date : (2014-06-09 20:00)
# Last revision : (2015-01-20 01:34)
# Wine version used : 1.7.12
# Distribution used to test : Fedora 21 64 bit - Ubuntu 14.04 64 bit
# Author : Tutul & Rashintawak
# License : GNU/GPL v3
  
## Beta script ##
  
[ "$PLAYONLINUX" = "" ] && exit 1
source "$PLAYONLINUX/lib/sources"
  
TITLE="The Mighty Quest For Epic Loot"
PREFIX="TheMightyQuest"
EDITOR="Ubisoft"
GAME_URL="https://www.themightyquest.com"
AUTHOR="Tutul & Rashintawak"
GAME_VMS="256"
  
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2059
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Setting Wine Version
WORKING_WINE_VERSION="1.7.12"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Install mandatory dependencies
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_d3dx9
  
# Fix Sound Stutter
Set_OS "win7"
  
# Choose between Downloading client or using local one
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
  
# Downloading client or choosing existing one
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Donwloading client
        POL_System_TmpCreate "$PREFIX"
        cd "$POL_System_TmpDir"
        URL="http://static7.cdn.ubi.com/mqel/static-live/mqel-live/LauncherSetup/PC/MightyQuestSetup_254972.exe"
        POL_Download "$URL" "bd76d2146897386d4cb1761ce3f14938"
        SETUP_EXE="$POL_System_TmpDir/$(basename "$URL")"
else
        # Asking for client exe
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
fi
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Run the install
POL_Wine_WaitBefore "$TITLE"
POL_Wine $SETUP_EXE
POL_Wine_WaitExit "$TITLE"
  
# Making shortcut
POL_Shortcut "PublicLauncher.exe" "$TITLE" "$TITLE.png" "-SkipMinimumConfigCheck" "Game;"
  
#Deleting temp files
POL_System_TmpDelete
  
#Closing POL
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlTeNX0ACgkQ5TH6yaoTykfNmACgpFtpVW4vrYavQNTp5dkm0/Q0
aaQAnjEB9JBnsinlcBo+KHZ6IWRa0wt6
=2PIj
-----END PGP SIGNATURE-----
