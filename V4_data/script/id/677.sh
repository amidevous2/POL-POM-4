#!/bin/bash
# Date : (2010-19-08 19-30)
# Last revision : see changelog
# Wine version used : 1.2, 1.4
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

#
# CHANGELOG
# [GNU_Raziel] (2010-19-08 19-30)
#   First script (Wine 4.0.3).
# [z3ke] (22012-05-18 21:00)
#   ?
# [z3ke] (2020-01-03)
#   Force arch x32
# [Dadu042] (2020-01-03)
#   Wine 1.4 -> 3.0.3
#   Improve POL_Shortcut
#   Add POL_RequiredVersion

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Wolfenstein"
PREFIX="wolfenstein_2k9"
MULTIPLAYER_EXE="Wolfenstein Multiplayer"
EDITOR="Activision"
GAME_URL="http://www.wolfenstein.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wolf_2k9/top.jpg" "http://files.playonlinux.com/resources/setups/wolf_2k9/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
# The POL_System_Arch must be x86 to get Wolfenstein working on x64
POL_System_SetArch "x86"

POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_dxfullsetup

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	#asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Setup/rsrc/Wolfenstein.ico"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix


# Making shortcut
POL_Shortcut "Wolf2.exe" "$TITLE" "Wolf2_SP.png" "" "Game;"
POL_Shortcut "Wolf2MP.exe" "$MULTIPLAYER_EXE" "Wolf2_MP.png" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg+5YQAKCRDlMfrJqhPK
R9GpAJ4mayjH5AfehujwIVNPNZOUlf6R8wCcDsh4cxG4PRPcmN0hQqVQbxwHOGQ=
=veIf
-----END PGP SIGNATURE-----
