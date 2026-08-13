#!/bin/bash
#
# CHANGELOG
# [WitalijBukatkin] (2019-03-14)
#   Initial writting.
# [Dadu042] (2020-02-20 17:15)
#   Wine 4.0 -> 4.0.3
#   Add shortcut category.
#   Add POL_RequiredVersion "4.3.0"
# [WitalijBukatkin] (2020-06-08 21:30)
# Change https to http


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Zona"
PREFIX="Zona"
FILE="ZonaSetup.exe"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "t.me/wbkid" "WitalijBukatkin" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "4.0.3"

POL_Call POL_Install_corefonts
  
cd "$WINEPREFIX/drive_c"
POL_Download "http://install4.zonastat.com/ZonaSetup.exe"
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$FILE"
POL_Wine_WaitExit "$TITLE"

rm ZonaSetup.exe
   
POL_Shortcut "Zona.exe" "$TITLE" "" "" "AudioVideo;"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMUiWwAKCRDlMfrJqhPK
RyElAKCrUene3aj18sbVgCTtc+f3xu0QTQCbBYVgKw0bFKOGvQBBZTmXYbrphqY=
=O394
-----END PGP SIGNATURE-----
