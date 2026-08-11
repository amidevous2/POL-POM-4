#!/bin/bash
# Date : (2010-09-06 14:00)
# Last revision : (2012-04-21 21:00)
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Elder Scrolls 4 - Oblivion - Knights Of The Nine"
PREFIX="TheElderScrolls4_Oblivion"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/oblivion/top.jpg" "http://files.playonlinux.com/resources/setups/oblivion/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "2K Games" "http://www.elderscrolls.com/games/oblivion_overview.htm" "GNU_Raziel" "$PREFIX"
 
POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "English/Oblivion - Knights of the Nine.exe"
	if [ "$POL_LANG" == "fr" ]; then
		POL_SetupWindow_message "$(eval_gettext '"Horse Armor Pack" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Horse Armor Pack.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Knights of the Nine" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Knights of the Nine.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Mehrunes Razor" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Mehrunes Razor.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Orrery" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Orrery.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Spell Tomes" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Spell Tomes.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Thieves Den" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Thieves Den.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Vile Lair" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Vile Lair.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Wizard Tower" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/French/Oblivion - Wizard's Tower.exe"
		POL_Wine_WaitExit "$TITLE"
	elif [ "$POL_LANG" == "de" ]; then
		POL_SetupWindow_message "$(eval_gettext '"Horse Armor Pack" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Horse Armor Pack.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Knights of the Nine" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Knights of the Nine.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Mehrunes Razor" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Mehrunes Razor.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Orrery" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Orrery.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Spell Tomes" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Spell Tomes.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Thieves Den" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Thieves Den.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Vile Lair" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Vile Lair.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Wizard Tower" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/German/Oblivion - Wizard's Tower.exe"
		POL_Wine_WaitExit "$TITLE"
	elif [ "$POL_LANG" == "es" ]; then
		POL_SetupWindow_message "$(eval_gettext '"Horse Armor Pack" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Horse Armor Pack.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Knights of the Nine" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Knights of the Nine.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Mehrunes Razor" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Mehrunes Razor.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Orrery" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Orrery.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Spell Tomes" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Spell Tomes.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Thieves Den" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Thieves Den.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Vile Lair" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Vile Lair.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Wizard Tower" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Spanish/Oblivion - Wizard's Tower.exe"
		POL_Wine_WaitExit "$TITLE"
	elif [ "$POL_LANG" == "it" ]; then
		POL_SetupWindow_message "$(eval_gettext '"Horse Armor Pack" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Horse Armor Pack.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Knights of the Nine" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Knights of the Nine.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Mehrunes Razor" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Mehrunes Razor.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Orrery" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Orrery.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Spell Tomes" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Spell Tomes.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Thieves Den" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Thieves Den.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Vile Lair" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Vile Lair.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Wizard Tower" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/Italian/Oblivion - Wizard's Tower.exe"
		POL_Wine_WaitExit "$TITLE"
	else
		POL_SetupWindow_message "$(eval_gettext '"Horse Armor Pack" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Horse Armor Pack.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Knights of the Nine" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Knights of the Nine.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Mehrunes Razor" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Mehrunes Razor.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Orrery" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Orrery.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Spell Tomes" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Spell Tomes.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Thieves Den" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Thieves Den.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Vile Lair" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Vile Lair.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_message "$(eval_gettext '"Wizard Tower" installation will begin...')" "$TITLE"
		POL_Wine start /unix "$CDROM/English/Oblivion - Wizard's Tower.exe"
		POL_Wine_WaitExit "$TITLE"
	fi
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Warning about update
POL_SetupWindow_message "$(eval_gettext 'If you do not have "Shivering Isle" addon\nyou must update this game before using it.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF0SSMACgkQ5TH6yaoTykesWACdEamwUUqZh24jVKe8iMd5W1aA
chcAn2SxNMopa6eYMAYc/qbjqjhN0fQ4
=kGCb
-----END PGP SIGNATURE-----
