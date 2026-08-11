#!/bin/bash
# Date : (2011-10-24 21:00)
# Last revision : see changelog
# Wine version used : 1.3.30, 1.5.21
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com


# CHANGELOG
# [GNU_Raziel] (2011-10-24)
#   First script.
# [Dadu042] (2019-11-09)
#   Wine 1.5.21 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Rage"
PREFIX="Rage"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Rage/top.jpg" "http://files.playonlinux.com/resources/setups/Rage/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ID Software" "http://www.aftertheimpact.com/" "GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # This game work better in x86
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Fix some installation/game issues
Set_OS "win7"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_vcrun2005 # Fix installation issue
POL_Call POL_Install_vcrun2008 # Fix game issue
POL_Call POL_Install_vcrun2010 # Fix multiplayer issue
POL_Call POL_Install_dxfullsetup # Fix game crash


# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > Fix.reg
[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]
"GrabFullscreen"="Y"
EOF
POL_Wine regedit "Fix.reg"

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
## End Fix

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "9200"

# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/9200"
POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Copy content of CDs to HDD
	TEMP="$POL_USER_ROOT/tmp/$PREFIX"
	chmod -R 777 "$TEMP"
	rm -R "$TEMP"
	mkdir -p "$TEMP"
	# Asking for CDROM and checking if it's correct one
	# Disk 1
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "RAGE_disk1_0.sid"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while installation is prepared...')" "$TITLE"
	cp -rf "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	# Disk 2
	POL_SetupWindow_message "$(eval_gettext 'Please insert disk 2 into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "RAGE_disk2_0.sid"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while installation is prepared...')" "$TITLE"
	cp -rf "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	# Disk 3
	POL_SetupWindow_message "$(eval_gettext 'Please insert disk 3 into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "RAGE_disk3_0.sid"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while installation is prepared...')" "$TITLE"
	cp -rf "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$TEMP" d:
	POL_Wine "d:\\Setup.exe"
	POL_SetupWindow_message "$(eval_gettext 'Do not forget to close Steam when downloading\nis finished, so that $APPLICATION_TITLE can continue\nto install your game.')" "$TITLE"
	# Relinking d: to $CDROM
	cd "$WINEPREFIX"/dosdevices
	rm ./d:
	ln -s "$CDROM" d:
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/9200
	POL_SetupWindow_message "$(eval_gettext 'Do not forget to close Steam when downloading\nis finished, so that $APPLICATION_TITLE can continue\nto install your game.')" "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdOutgAKCRDlMfrJqhPK
RwCpAKCGORFmy058RInYFqYYWUPRRr1ydACdG6idRqpIzSnhq0INQ+of9JI45LA=
=Iulq
-----END PGP SIGNATURE-----
