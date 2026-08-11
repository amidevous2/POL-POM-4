#!/bin/bash
# Date : (2015-02-22)
# Distribution used to test : Kubuntu 14.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.5


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="ImandixCoverPro"
WINEVERSION="1.7.37"
TITLE="Imandix Cover Pro"
EDITOR="Imandix"
GAME_URL="http://www.imandix.com/"
AUTHOR="RoninDusette"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies

# Configuration
Set_OS "winxp"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: When CoverPro opens up automatically, close it so that the installation can finish.')" "$TITLE"

# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "CoverPro.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlTqFyUACgkQ5TH6yaoTykfGMACgkNs4/2ob5P2RgZzuOGXuct+v
KIoAoJYNHUVK+z+I504d6eyAo46+Cvot
=N2cM
-----END PGP SIGNATURE-----
