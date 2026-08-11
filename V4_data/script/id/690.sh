#!/bin/bash
# Date : (2010-09-03 14:00)
# Last revision : (2012-05-10 21:00)
# Wine version used : 1.3.5, 1.3.23, 1.4, 1.5.3-ubisoft2
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

## Begin Note ##
# Used patch to fix "ReadFileEx failture", see Bug #28119 - http://bugs.winehq.org/show_bug.cgi?id=28119
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Prince of Persia : The Forgotten Sands"
TITLE_SETTINGS="Prince of Persia : The Forgotten Sands (Configuration)"
PREFIX="PoP-TFS"
EDITOR="Ubisoft"
GAME_URL="http://prince-of-persia.uk.ubi.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.5.3-ubisoft2"

if [ "$POL_LANG" == "fr" ]; then
TITLE="Prince of Persia : Les Sables Oublies"
TITLE_SETTINGS="Prince of Persia : Les Sables Oublies (Configuration)"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/PoP-TFS/top.jpg" "http://files.playonlinux.com/resources/setups/PoP-TFS/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
POL_Call POL_Install_ubigamelauncher

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "System/Prince of Persia.exe"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_SetupWindow_menu "$(eval_gettext 'Which edition do you have?')" "$TITLE" "$(eval_gettext 'Normal version')~$(eval_gettext 'Digital Deluxe version')" "~"
	if [ "$APP_ANSWER" == "$(eval_gettext 'Normal version')" ]; then
		STEAM_ID="33320"
	else
		STEAM_ID="33329"
	fi
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$TITLE" "Prince of Persia : The Forgotten Sands.png" "steam://rungameid/$STEAM_ID"
	# Steam install
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

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
cat << EOF > "$POL_USER_ROOT/tmp/PoP_Fix.reg"
[HKEY_CURRENT_USER\\Software\\Wine\\DirectSound] 
"MaxShadowSize"="0"
EOF
POL_Wine regedit "$POL_USER_ROOT/tmp/PoP_Fix.reg"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/"*
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "Prince of Persia.exe" "$TITLE" "Prince of Persia : The Forgotten Sands.png" ""
fi
POL_Shortcut "GameSettings.exe" "$TITLE_SETTINGS" "Prince of Persia : The Forgotten Sands (Configuration).png" ""

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+sLTYACgkQ5TH6yaoTykfw/gCgiSABFe0Y0RcgOcwr/z84kZEz
bHQAnjntAh9aQFEB7/KJ1k1GPJ111Xqe
=duc0
-----END PGP SIGNATURE-----
