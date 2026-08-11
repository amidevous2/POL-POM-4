#!/bin/bash
# Date : (2015-12-08)
# Distribution used to test : Duzeru GNU/Linux 2.0 64 bit(Debian Jessie based)
# Author : chocoelho
# Based on: PhotoshopCS6 script
# Licence : GPLv3
# PlayOnLinux: 4.2.9
#
# CHANGELOG
# [chocoelho] (2015-12-08)
#   First script.
# [Dadu042] (2019-11-28)
#   Wine 1.7.46-staging -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="FireworksCS6"
WINEVERSION="2.22"
TITLE="Adobe Fireworks CS6"
EDITOR="Adobe Systems Inc."
GAME_URL="https://www.adobe.com/products/fireworks"
AUTHOR="chocoelho"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 2670

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

POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error saying that the installation failed, wait at least 5 minutes before closing it. PlayOnLinux will finish the install, even though it crashed.')" "$TITLE"


# Installation
Set_OS "win7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "Fireworks.exe" "$TITLE" "" "" "Graphics;"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeDxUwAKCRDlMfrJqhPK
R+RvAJ9tQ4agvHW8yqaY6MdAOrDzg/w+/wCdGuSBzZm0OuEfdKIb4LFwmKojW7Y=
=oHgm
-----END PGP SIGNATURE-----
