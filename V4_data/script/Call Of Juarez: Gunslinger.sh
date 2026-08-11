#!/bin/bash
# Date : (2013-06-24)
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Linux Mint 15 x64
# Author : Ruzven
#
# CHANGELOG
# [Ruzven] (2013-06-24)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Wine 1.7.8 -> system's wine.
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Call Of Juarez Gunslinger"
TITLE_DEMO="Call Of Juarez Gunslinger (Demo)"
PREFIX="Call_Of_Juarez_Gunslinger"

EDITOR="Ubisoft"
GAME_URL="http://www.ubi.com/UK/Games/Info.aspx?pId=11149"
AUTHOR="Ruzven"
GAME_VMS="512"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1915
# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,STEAM"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
    POL_Call POL_Install_steam
fi

# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/222400
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
    POL_Wine_WaitExit "$TITLE_DEMO"
    POL_Shortcut "steam.exe" "$TITLE_DEMO" "$TITLE_DEMO.png" "steam://rungameid/222400"

elif [ "$INSTALL_METHOD" == "STEAM" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/204450
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/204450"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlIyCgAKCRDlMfrJqhPK
RxCaAKCzC6kcOjUCNqaaWMXB4/Pzz2+Q/gCfbwHnEtFIdWfju8s5++hIiU1Wm5Y=
=1wak
-----END PGP SIGNATURE-----
