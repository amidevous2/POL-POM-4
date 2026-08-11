#!/bin/bash
# Date : (2011-09-03 21-00)
# Last revision : see changelog.
# Wine version used : 1.3.15, 1.3.23, 1.3.27
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-09-03 21-00)
#   Initial script.
# [Dadu042] (2020-01-29 22:00)
#   Wine 1.3.27 (because outdated) -> 3.0.3 (untested)
#   Standardize POL_Function_NoCDWarning

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dragon Age 2"
TITLE_CONFIG="Dragon Age 2 - Configutation"
PREFIX="DA2"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/da2/top.jpg" "http://files.playonlinux.com/resources/setups/da2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bioware" "http://dragonage.bioware.com/da2" "GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi

# Note
POL_SetupWindow_message "$(eval_gettext 'If the setup request DirectX installation, answer no.')" "$TITLE"

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "901633"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "data/Dragon Age 2 Uninstaller.exe"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/901633
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Installing mandatory dependencies - need to be post-install for this game
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_devenum
POL_Call POL_Install_dxfullsetup

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/901633"
else
	POL_Shortcut "DragonAge2.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi
POL_Shortcut "DragonAge2Config.exe" "$TITLE_CONFIG" "$TITLE_CONFIG.png" "" "Game;"

# Fix needed after the very first launch
CHECK_GAME_FILE=`find "$HOME/BioWare/Dragon Age 2/Settings" -name "DragonAge.ini"`
if [ "$CHECK_GAME_FILE" == "" ]; then
	POL_SetupWindow_message "$(eval_gettext "$TITLE_CONFIG will be started\nClose it after your hardware's detection.")" "$TITLE"
	bash "$POL_USER_ROOT/shortcuts/$TITLE_CONFIG"
	POL_Wine_WaitExit "$TITLE"
fi
cd "$HOME/BioWare/Dragon Age 2/Settings"
mv "DragonAge.ini" "DragonAge.ini.save"
cat "DragonAge.ini.save" | sed s/"SoundDisabled=1"/"SoundDisabled=0"/g > "DragonAge.ini"

# Game protection warning
POL_Call POL_Function_NoCDWarning

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH7kwAKCRDlMfrJqhPK
R/3DAJ4lQVqBtOlDoBATYpKqV1tqGCnTeQCfR9oCoMGYcJC+vo0xYF3WWjWoFDg=
=oCPy
-----END PGP SIGNATURE-----
