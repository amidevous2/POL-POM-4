#!/bin/bash
# Date : (2010-08-31 13:00)
# Last revision : see changelog
# Wine version used : 1.2.1, 1.2.3, 1.4, 1.6
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2010-08-31)
#   First script.
# [?] (2012-04-11 21:00)
#   ?
# [Dadu042] (2019-12-24)
#   Wine 1.6 (obsolete) -> 2.22 (minimal)
# [Dadu042] (2020-03-16)
#   Wine 2.22 -> 3.0.3 (after reviewing Appdb.winehq.org, not tested).


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Witcher"
TITLE_EE="The Witcher : Enhanced Edition"
PREFIX="thewitcher"
EDITOR="CD Projekt"
GAME_URL="http://www.thewitcher.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3" # (#2900)
GAME_VMS="256"
SHORTCUT_NAME="$TITLE"
MD5_DVD_EE="2596b13aed5fb1c2b3653465e26a32b8"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/witcher/top.jpg" "http://files.playonlinux.com/resources/setups/witcher/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Setup method and md5 detection
if [ "$POL_SELECTED_FILE" ]; then
        SETUP_EXE="$POL_SELECTED_FILE"
	MD5_CHECK=`md5sum $SETUP_EXE` # pol 4.0.16 and lower only
	if [ "$MD5_CHECK" == "$MD5_DVD_EE" ]; then # pol 4.0.16 and lower only
	#if [ "$POL_SELECTED_MD5" == "$MD5_DVD_EE" ]; then # pol 4.0.17 and newer only
		INSTALL_METHOD="DVD"
	fi
else
	# Choose between DVD, Steam and Digital Download version
	POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
fi

# Choose beween Standard and Enhanced Edition
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_SetupWindow_menu "$(eval_gettext 'Which edition do you have?')" "$TITLE" "$(eval_gettext 'Standard Edition')~$(eval_gettext 'Enhanced Edition')" "~"

	if [ "$APP_ANSWER" == "$(eval_gettext 'Enhanced Edition')" ]; then
		cd "$WINEPREFIX/drive_c/"
		touch ENHANCED_EDITION
		SHORTCUT_NAME="$TITLE_EE"
	fi
fi

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_gdiplus
POL_Call POL_Install_dxfullsetup

# Mandatory pre-install fix for steam
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="20900"; SHORTCUT_NAME="$TITLE_EE"; }

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > witcher_fix.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"DirectDrawRenderer"="opengl"
"RenderTargetLockMode"="readtex"
"OffscreenRenderingMode"="fbo"
EOF
regedit witcher_fix.reg

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Begin installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "witcher.ico"
	# Disk 1
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	POL_Wine start /unix "$CDROM/setup.exe"
	# Ejecting Disk 1
	POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next Disk\nclick on \"Forward\"')" "$TITLE"
	POL_Wine eject
	# Disk 2
	POL_SetupWindow_message "$(eval_gettext 'Please insert the next game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "System/djinni.chm"
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
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

# Creating Shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "launcher.exe" "$SHORTCUT_NAME" "$TITLE.png" "" "Game;"
fi
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXm/jUwAKCRDlMfrJqhPK
R9OMAKCwFaNT3oC8EZ00j1TX3kXh3N+oxwCgitw0EURq3yK7q8Xccx+2t7d9Vm0=
=sd4b
-----END PGP SIGNATURE-----
