#!/bin/bash
# Date : (2012-02-28 21:00)
# Last revision : (see changelog)
# Wine version used : 1.4-rc4-xliveless2, 1.5.3-xliveless2-rawinput3, 4.0.2
# Distribution used to test : Xubuntu 18.04 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2012-02-28)
#   First script.
# [Dadu042] (2019-09-07) (I used retail DVD GOTY, latest files date: february 2010. Main menu: v1.0).
#   - Wine 4.0.2 (instead of "1.5.3-xliveless2-rawinput3"). I wanted 2.22 but I had issues.
#   - Standardize NoCDWarning, however I did not need one.

# KNOWN ISSUES
#   - Wine x86 4.0.2: Installation does not exit from the POL/POM script at the end. Click the top right button to close the window.
#   - Wine x86 4.0.2: Game fail to exit (black screen). Process has to be killed from terminal.
#   - Wine x86 4.0.2: Game always install in English, even if a other language is selected (Multi5).
#   - Wine x86 4.0.2: dotnet40 if installed from POL will make this problem: installer block on 'Installing .NET Framework 3.0'.

# KNOWN ISSUES (2012, Wine 1.5.3-xliveless2-rawinput3) :
#  - Some errors output from wine because of .NET framework 3.5 use.
#  - Cannot connect to GFWL account since it do not work with wine.

# KNOWN ISSUES (FIXED)
#   - Wine x86 2.22: '002f:err:richedit:ReadStyleSheet skipping optional destination' -> install Riched30 or upgrade to Wine 4.
#   - Wine x86 4.0.2: Error functon DLL 'ISRT_CtrlSetMLERichText'. Fix: remove POL_Install_riched30.

## Begin Note ##
# Used Xliveless2 patch to disable non-working GFWL support - http://appdb.winehq.org/objectManager.php?sClass=version&iId=19065
## End Note ##
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Batman Arkham Asylum"
PREFIX="BatmanAA"
WORKING_WINE_VERSION="4.0.2"
EDITOR="Rocksteady"
GAME_URL="http://www.batmanarkhamasylum.com/"
AUTHOR="GNU_Raziel and Dadu042"
GAME_VMS="256"
 
# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/batmanAA/top.jpg" "http://files.playonlinux.com/resources/setups/batmanAA/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Makes more troubles than fixes (Wine 4.0.2) 
# POL_Call POL_Install_riched30

POL_Call POL_Install_vcrun2005

POL_Call POL_Install_physx

# Dotnet 3.5 and 4.0 sucks to install on my OS (because I've a root file to change).
# POL_Call POL_Install_dotnet461
# POL_Call POL_Install_dotnet30


POL_Call POL_Install_xinput

# Seems not required from Wine 3.x and 4.x
# POL_Call POL_Install_dxfullsetup
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS # Need to be done before installation
 
## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="35140"
fi
 
# Pre-install fix - Need to backup dll because game setup install xlive and override it
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive.dll xlive2.dll
 
# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Game protection warning
	POL_Call POL_Function_NoCDWarning

        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "BmGame.u"
        POL_Wine start /unix "$CDROM/autorun.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
 
# Mandatory to make the game work with wine
POL_Call POL_Remove_gfwl
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive2.dll xlive.dll
 
# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
        POL_Shortcut "BmStartApp.exe" "$TITLE" "" ""
fi 

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXXUW1QAKCRDlMfrJqhPK
R52CAJwNSRcztgBdMJq9Vj7uPOBk1016ywCfcw/1MMj+Id4nf699vQ+1d1XMCsU=
=2Xjf
-----END PGP SIGNATURE-----
