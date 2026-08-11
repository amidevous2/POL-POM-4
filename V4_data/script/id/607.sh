#!/bin/bash
# Date : (2009-03-28 12:00)
# Last revision : (2012-03-16 21:00)
# Wine version used : 1.2.2-Mousepatch, 1.2.3-forcebox
# Distribution used to test : Debian Testing x64
# Author : Berillions & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Mass Effect"
PREFIX="MassEffect"
EDITOR="BioWare"
GAME_URL="http://masseffect.bioware.com/me1"
AUTHOR="Berillions & GNU_Raziel"
WORKING_WINE_VERSION="1.7.46-staging"
GAME_VMS="256"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_d3dx9

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media 1 into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next Disk\nclick on \"Forward\"')" "$TITLE"
	POL_Wine eject
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media 2 into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	rm ./p:
	ln -sf "$CDROM" p:
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "17460"
	# Shortcut done before install for steam version
	POL_Shortcut "Steam.exe" "$TITLE" "" "steam://rungameid/17460"
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "Steam.exe" steam://install/17460
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
# Wine patch related fix - do not use with vanilla wine
POL_Wine_DirectInput "MouseWarpOverride" "force-box"
POL_Wine_DirectInput "Box-Pixels" "5"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

### PlayOnMac Section
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
	POL_Shortcut "MassEffect.exe" "$TITLE" "" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXN/rAQAKCRDlMfrJqhPK
R1mxAJ9WfT9/tyc9JXEcTGNklTaNa+qC6ACfUa+nzmOYwIEK+rQDT4OaSXUQZpo=
=v8BM
-----END PGP SIGNATURE-----
