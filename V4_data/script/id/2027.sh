#!/bin/bash
# Date : (2012-12-29 19-40)
# Last revision : (2014-05-06 16-06)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="warlords_battlecry_3"
PREFIX="WarlordsBattlecry3_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Warlords Battlecry 3"
SHORTCUT_NAME="Warlords Battlecry 3"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2027
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infinite Interactive / Enlight Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "845c8d08f2e9e5e471dd7f330a6493c4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Can scroll by moving mouse to screen borders
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Prevent minimized windows
Set_Managed "Off"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Battlecry III.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Warlords Battlecry 3/Manual.pdf"
# C:\Program Files\GOG.com\Warlords Battlecry 3\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNo7QQACgkQ5TH6yaoTyke+cgCeNMIEqGNTJQ6+rKYkmAxYU3eQ
stUAn33DZlADAzuy3UMyaMJ3aKGDJdsk
=ZAUt
-----END PGP SIGNATURE-----
