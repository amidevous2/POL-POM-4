#!/bin/bash
# Date : (2012-02-28 21:00)
# Last revision : (2012-03-05 21:00)
# Wine version used : 1.3.37
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="A.R.E.S. : Extinction Agenda"
TITLE_DEMO="A.R.E.S. : Extinction Agenda (Demo)"
PREFIX="ares"
EDITOR="Extend Studio"
GAME_URL="http://trashman.x10studio.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.3.37"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ares/top.jpg" "http://files.playonlinux.com/resources/setups/ares/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet20
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_dotnet20
POL_Call POL_Install_xna31
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_quartz

# Mandatory pre-install fix for steam - Part 1
[ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="92310"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="92300"; SHORTCUT_NAME="$TITLE"; }

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Begin installation
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	# Mandatory pre-install fix for steam - Part 2
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
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

	# Shortcut done after install for local version
	POL_Shortcut "ares.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk9krRgACgkQ5TH6yaoTykcGcgCdHwoejytenI4F9Ss0rd6/GWIK
pT8AoK1Dy7z7I1NJkHZ2C8V5eAh80fc6
=UOwZ
-----END PGP SIGNATURE-----
