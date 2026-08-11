#!/bin/bash
# Date : (2013-11-05)
# Last revision : (2019-11-26)
# Wine version used : 1.7.8
# Distribution used to test : Linux Mint 16 x64
# Author : Ruzven

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Orcs Must Die!"
PREFIX="Orcs_Must_Die"
WORKING_WINE_VERSION="2.22"
EDITOR="Robot Entertainment"
GAME_URL="http://www.robotentertainment.com/games/orcsmustdie/"
AUTHOR="Ruzven"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1912
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"

# Installing mandatory dependencies
POL_Call POL_Install_steam

# Begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_SetupWindow_menu "$(eval_gettext 'Please select version.')" "$TITLE" "$(eval_gettext 'Normal version')~$(eval_gettext 'Demo version')" "~"
if [ "$APP_ANSWER" == "$(eval_gettext 'Normal version')" ]; then

    # Steam install Normal version
    POL_Wine "steam.exe" steam://install/102600
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/102600"        
else

    # Steam install Demo version
    POL_Wine "steam.exe" steam://install/102610
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/102610"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXd2olQAKCRDlMfrJqhPK
R/VtAJ9o3zQYJr8ZTK0y9HUWbL5DKKYW8gCdFESUrEam8i00SLsz6bVt93ONFWM=
=rTg8
-----END PGP SIGNATURE-----
