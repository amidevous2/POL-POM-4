#!/bin/bash
# Date : (2011-07-16 21:00)
# Last revision : (2012-03-25 21:00)
# Wine version used : 1.3.23, 1.4
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star-Twine"
TITLE_DEMO="Star-Twine (Demo)"
PREFIX="StarTwine"
EDITOR="Eric Billingsley"
GAME_URL="http://star-twine.net"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.4"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/startwine/top.jpg" "http://files.playonlinux.com/resources/setups/startwine/left.jpg" "$TITLE"
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
POL_SetupWindow_InstallMethod "DESURA_DEMO,DESURA,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "DESURA_DEMO" ] || [ "$INSTALL_METHOD" == "DESURA" ]; then
	POL_Call POL_Install_desura
fi
#POL_Call POL_Install_dotnet35
#POL_Call POL_Install_xna31

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

# Mandatory settings for Digital version
[ "$INSTALL_METHOD" == "DESURA_DEMO" ] && { DESURA_ID="417"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "DESURA" ] && { DESURA_ID="416"; SHORTCUT_NAME="$TITLE"; }

# Begin installation
if [ "$INSTALL_METHOD" == "DESURA_DEMO" ] || [ "$INSTALL_METHOD" == "DESURA" ]; then
	# Shortcut done before install for desura version
	POL_Shortcut "Desura.exe" "$SHORTCUT_NAME" "$TITLE.png" "desura://launch/games/star-twine/$DESURA_ID"
	# Desura install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Desura is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Desura interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Desura"
	POL_Wine start /unix "Desura.exe" desura://launch/games/star-twine/$DESURA_ID
	POL_Wine_WaitExit "$TITLE"

else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/"*
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_Shortcut "Star-Twine.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlATDBEACgkQ5TH6yaoTykcK5gCfYx5/twL/BIoINoHHMYx5srqf
InIAoIuhRxHOhRqgKHFZz4Z3WKmQOtzi
=KMAf
-----END PGP SIGNATURE-----
