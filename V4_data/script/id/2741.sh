#!/bin/bash
# Date : (02/23/2016)
# Distribution used to test : Ubuntu 15.10 64-bit
# Author : Dizlexic
# Licence : GPLv3
# PlayOnLinux: 4.2.6
#
#
# CHANGELOG
# [Dizlexic] (2016-02-23)
#   Initial script.
# [Dadu042] (2020-04-17 21-00)
#   Wine 1.7.39 (outdated) -> 3.0.3 (not tested)
#
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="aceOfSpades"
WINEVERSION="3.0.3"
TITLE="Ace of Spades: Battle Builder"
EDITOR="Jagex"
GAME_URL="http://aceofspades.com/"
STEAM_ID="224540"
GAME_VMS="512"

AUTHOR="Dizlexic"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Configuration
Set_OS "winxp"
POL_SetupWindow_VMS "$GAME_VMS"
POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE will be installed via Steam. After Steam is installed, uncheck Run Steam, click Finish, and Steam will restart. Sign in and install $TITLE.')" "$TITLE"

#Dependencies
POL_Call POL_Install_steam

# Installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"

# Create Shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpn1vgAKCRDlMfrJqhPK
RwRbAKCPAGvQfrZ3Iqn4I6AjMXe9zGJptACeNsJC9rCjPCLJN+KqObYq1t57X8k=
=7Het
-----END PGP SIGNATURE-----
