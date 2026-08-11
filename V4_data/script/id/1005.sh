#!/bin/bash
# Date : (2012-02-24 21:00)
# Last revision : see changelog
# Wine version used : 1.3.37, 1.4, 1.5.4 (PlayOnLinux) / 1.4 (PlayOnMac), 1.5.20, 2.22
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2012-02-24)
#   First script.
# [Dadu042] (2019-11-54)
#   Wine 1.7.36 -> 2.22 (emergency update, because of many install issues reported from users)
#   POL_RequiredVersion "4.2.12"
#   Note (for a future update): replacing dotnet35 by dotnet40 will does the 'ptrace' issue.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Elder Scrolls V: Skyrim"
PREFIX="Skyrim"
EDITOR="Bethesda Softworks"
GAME_URL="http://www.elderscrolls.com/skyrim/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="1024"
STEAM_ID="72850"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Skyrim/top.jpg" "http://files.playonlinux.com/resources/setups/Skyrim/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1005

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
# Check Kernel ptrace
if [ -e "/proc/sys/kernel/yama/ptrace_scope" ]; then
	PTRACE_CHECK=`cat /proc/sys/kernel/yama/ptrace_scope`
	if [ "$PTRACE_CHECK" != 0 ]; then
		POL_Debug_message "$(eval_gettext 'The game will fail to launch until you set /proc/sys/kernel/yama/ptrace_scope to 0')" "$TITLE"
	fi
fi

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading Wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_vcrun2008 # Fix game issue
POL_Call POL_Install_dotnet35 # Fix launcher issue
POL_Call POL_Install_dxfullsetup # Fix game crash

# Fix PulseAudio issue
which pulseaudio && Set_OS "win7"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
POL_Wine_X11Drv "GrabFullscreen" "Y"

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for Steam version
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID" "Game;RolePlaying;"
# POL_Shortcut "steam.exe" "Steam ($TITLE)" "" "" "Game;"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "The Elder Scrolls V- Skyrim_disk1_0.sid"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
	POL_SetupWindow_Close
else
    POL_SetupWindow_Close
	# Steam install
	#POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished, do NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
fi


exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcEP0AAKCRDlMfrJqhPK
R5tfAJ0ecYu6q2G0QxqV5+fYPCDKO9JlugCeOS9TO2Cu9PDtMF3wRLtFOfEzXYQ=
=EWX+
-----END PGP SIGNATURE-----
