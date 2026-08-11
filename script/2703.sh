#!/bin/bash
# Date : (2016-01-06)
# Distribution used to test : Mint Linux 64-bit
# Author : rafaelrj (Rafael Franco Vidal)
# Licence : GPLv3
# PlayOnLinux: 4.2.10

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="DreamweaverCS6"
WINEVERSION="1.8"
TITLE="Adobe Dreamweaver CS6"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="rafaelrj (rafael Franco Vidal)"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2703

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Configuration
Set_OS "winxp"

#Dependencies
POL_Call POL_Install_AdobeAir
POL_Call POL_Install_atmlib
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml3
POL_Call POL_Install_msxml6
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB

# Installation
Set_OS "win7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "dreamweaver.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaPS1QACgkQ5TH6yaoTykdhJACbBXjl7E7uWPm/XkLVu7xWpMv0
2UgAoLA9gydcKCvsWnTjDd5NMj22y9Vu
=k4R1
-----END PGP SIGNATURE-----
