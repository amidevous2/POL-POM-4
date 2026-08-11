#!/bin/bash
# Date: (2012-07-26)
# Wine version used: 1.3.24
# Distribution used to test: Frugalware i686
# Author: DarkNekros
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [DarkNekros] (2012-07-26)
#   Initial script.
# [Dadu042] (2020-01-16 23:50)
#   Wine 1.3.24 (outdated) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Heroes of Might & Magic 5"
PREFIX="HOMM5"
EDITOR="Nival Interactive"
GAME_URL="http://www.mightandmagic.com/HeroesV/"
AUTHOR="DarkNekros"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="512"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Downloading client or using local one
POL_SetupWindow_InstallMethod "DVD"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

if [ "$INSTALL_METHOD" = "DVD" ]; then
  POL_SetupWindow_message "$(eval_gettext 'Please insert the DVD-ROM')" "$TITLE"
  POL_SetupWindow_cdrom
  POL_SetupWindow_check_cdrom "AutoRun.ico"
  cd "$WINEPREFIX/dosdevices" 
  ln -sf "$CDROM" p:
  POL_Wine start /unix "$CDROM/Setup.exe"
  POL_Wine_WaitExit "$TITLE"
fi

# Création Shortcut
POL_Shortcut "H5_Game.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDmuQAKCRDlMfrJqhPK
R+uiAJwKKgqLkmNPJ8vptrZ0Y7Ec4Ry/+wCggGYcVuahh/chtu720IXR4AwK9D0=
=62Kr
-----END PGP SIGNATURE-----
