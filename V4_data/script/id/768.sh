#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2012-04-22 21:00)
# Wine version used : 1.2.1, 1.2.3, 1.4
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate"
PREFIX="BaldursGate1"
EDITOR="BioWare"
GAME_URL="http://www.bioware.com/games/baldurs_gate/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.4"
GAME_VMS="128"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG1/top.jpg" "http://files.playonlinux.com/resources/setups/BG1/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between CD, DVD and Digital Download version
POL_SetupWindow_InstallMethod "CD,DVD,LOCAL"

if [ "$INSTALL_METHOD" == "CD" ]; then
	# Asking for CDROM and checking if it's correct one
	# CD-ROM 1
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "SETUP.EXE"
	# Disk 1
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	POL_Wine start /unix "$CDROM/SETUP.EXE"
	# Ejecting Disk 1
	POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next Disk\nclick on \"Forward\"')" "$TITLE"
	POL_Wine eject
	# Disk 2
	POL_SetupWindow_message "$(eval_gettext 'Please insert the next game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	# Ejecting Disk 2
	POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next Disk\nclick on \"Forward\"')" "$TITLE"
	POL_Wine eject
	# Disk 3
	POL_SetupWindow_message "$(eval_gettext 'Please insert the next game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	# Disk 4
	POL_SetupWindow_message "$(eval_gettext 'Please insert the next game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	# Disk 5
	POL_SetupWindow_message "$(eval_gettext 'Please insert the next game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:

	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "baldur.ico"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/"*
fi

# Making shortcut
POL_Shortcut "Baldur.exe" "$TITLE" "$TITLE.png" ""

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+ULRYACgkQ5TH6yaoTykf96ACfZQq504+UsuZ8/Lq9r6J8nA7Y
e5UAoKPMcQidH0+6vAK9uLoUkBAayT8t
=Urwu
-----END PGP SIGNATURE-----
