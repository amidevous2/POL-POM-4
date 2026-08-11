#!/bin/bash
# Date : (2012-09-01)
# Last revision :(2013-12-23)
# Wine version used : 1.5.19;1.7.8
# Distribution used to test : Linux Mint 13 x32
# Author : Ruzven
# Licence : Steam

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Orcs Must Die! 2"
PREFIX="Orcs_Must_Die_2"
WINEVERSION="1.7.8"
EDITOR="Robot Entertainment"
GAME_URL="http://www.robotentertainment.com/games/omd2"
AUTHOR="Ruzven"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1588

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"

# Installing mandatory dependencies
POL_Call POL_Install_steam

# Begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_SetupWindow_menu "$(eval_gettext 'Please select version.')" "$TITLE" "$(eval_gettext 'Normal version')~$(eval_gettext 'Demo version')" "~"
if [ "$APP_ANSWER" == "$(eval_gettext 'Normal version')" ]; then

    # Steam install Normal version
    POL_Wine "steam.exe" steam://install/201790
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/201790"
else

    # Steam install Demo version
    POL_Wine "steam.exe" steam://install/215020
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/215020"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlK4YCcACgkQ5TH6yaoTykc/GgCdGql+JdnjAhUd55dmPNBX8pLi
zd8Amwbpo11wNXrufJY5kUN/Pgc2LwiC
=HHyr
-----END PGP SIGNATURE-----
