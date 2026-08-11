#!/bin/bash
# Date : (2012-02-28 21:00)
# Last revision : (2012-05-12 21:00)
# Wine version used : 1.4-rc4-xliveless2, 1.5.3-xliveless2-rawinput3
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

## Begin Note ##
# Used Xliveless2 patch to disable non-working GFWL support - http://appdb.winehq.org/objectManager.php?sClass=version&iId=19065
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Batman Arkham City"
PREFIX="BatmanAC"
WORKING_WINE_VERSION="1.5.3-xliveless2-rawinput3"
EDITOR="Rocksteady"
GAME_URL="http://arkhamhasmoved.com/"
AUTHOR="GNU_Raziel"
GAME_VMS="256"

# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/batmanAC/top.jpg" "http://files.playonlinux.com/resources/setups/batmanAC/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	STEAM_ID="57400"
fi
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
POL_Call POL_Install_dotnet35

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS # Need to be done before installation

## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Pre-install fix - Need to backup dll because game setup install xlive and override it
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive.dll xlive2.dll

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "autorun.exe"
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
	POL_Shortcut "BmLauncher.exe" "$TITLE" "" ""
fi

# Game protection warning
POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+wL6oACgkQ5TH6yaoTykdJlACdGODcOrkW3Ke806gIa6VXYy5D
JQ0An3nb1awjt4kPoyoByTGN1G77KJDK
=tHyS
-----END PGP SIGNATURE-----
