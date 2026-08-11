#!/usr/bin/env playonlinux-bash
# Date : (2016-10-17)
# Last revision : (2016-10-17)
# Wine revision used : 1.9.20-staging
# Distribution used to test : Ubuntu 16.04, Ubuntu 16.10
# Author : NoSt

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Definition of the variables
TITLE="Assassin's Creed Chronicles: China"
PREFIX="AssassinsCreedChina"
STEAM_ID="354380"
WORKING_WINE_VERSION="1.9.20-staging"

# Initialization of the setup
POL_SetupWindow_Init

# Initialization of the debugging
POL_Debug_Init

# Presentation screen
POL_SetupWindow_presentation "$TITLE" "Climax Studios" "http://assassinscreed.ubi.com/en-US/games/chronicles/china.aspx" "NoSt" "$PREFIX"

# Definition of the Wine prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Selecting the installation method
POL_SetupWindow_InstallMethod "LOCAL,STEAM"

# Installation from a local archive
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext "Please select the installation file to run.")" "$TITLE"
    POL_SetupWindow_wait "$(eval_gettext "Please wait...")" "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Shortcut "ACCGame-Win32-Shipping.exe" "$TITLE"
    POL_SetupWindow_message "$(eval_gettext "Installation finished.")" "$TITLE"
    
# Installation in Steam    
else
    POL_Call POL_Install_steam
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam" || exit
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID
    POL_SetupWindow_message "$(eval_gettext "Steam is installing $TITLE. Press Next when the installation is finished.")" "$TITLE"
    POL_Shortcut "Steam.exe" "$TITLE" "" "-applaunch $STEAM_ID"
    POL_SetupWindow_message "$(eval_gettext "Installation finished.")" "$TITLE"
fi

# Terminating the setup
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNXSlwAKCRDlMfrJqhPK
R3r2AJ4vxhXlCzQhehUds6vShUXsU4VxKwCgjjZTpLjOVqOUI2TFh8lc03mRzs0=
=BY2T
-----END PGP SIGNATURE-----
