#!/bin/bash
# Date : (2013-02-12 17-10)
# Last revision : (2014-02-15 17-48)
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-02-12 17-10)
#   Initial script.
# [Pierre Etchemaite] (2014-02-15 17-48)
#   ?
# [Dadu042] (2020-01-19 23:50)
#   Wine 1.4.1 -> 2.22

# KNOWN ISSUES:
# Pictures in title screen/menu/introduction appear with a delay starting with Wine 1.5.5

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="avernum_the_complete_saga"
PREFIX="Avernum_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Avernum: The Complete Saga"
SHORTCUT_NAME1="Avernum"
SHORTCUT_NAME2="Avernum 2"
SHORTCUT_NAME3="Avernum 3"
SHORTCUT_NAME4="Avernum 4"
SHORTCUT_NAME5="Avernum 5"
SHORTCUT_NAME6="Avernum 6"
SHORTCUT_NAMEB="Blades of Avernum"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1568
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Spiderweb Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "97caacf820a97bc73fd95fb757971afa"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# For Avernum 4+
POL_Wine_DirectInput "MouseWarpOverride" "force"

# Enable "Change resolution: Ask at start"
# Seems to starts more reliably that way, at least in virtual desktop
cd "$WINEPREFIX/drive_c/GOG Games/Avernum Series" || POL_Debug_Fatal "Could not find game directory"
dd if=/dev/zero of="Avernum 4/Data/Avernum4Settings.dat" conv=notrunc bs=1 seek=8 count=1

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Avernum.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum/Mapofavernum.bmp"

POL_Shortcut "Avernum 2.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 2/Avernum 2 Map.BMP"

POL_Shortcut "Avernum 3.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 3/Avernum 3 Manual, Order Form.pdf"

POL_Shortcut "Blades of Avernum.exe" "$SHORTCUT_NAMEB" "$SHORTCUT_NAMEB.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAMEB" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Blades of Avernum/Blades of Avernum Manual, Order Form.pdf"

POL_Shortcut "Avernum 4.exe" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME4" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 4/Avernum 4 Instructions.pdf"

POL_Shortcut "Avernum 5.exe" "$SHORTCUT_NAME5" "$SHORTCUT_NAME5.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME5" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 5/Avernum_5_Instructions.pdf"

POL_Shortcut "Avernum 6.exe" "$SHORTCUT_NAME6" "$SHORTCUT_NAME6.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME6" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 6/Avernum 6 Instructions.pdf"

POL_Shortcut "Avernum 6 DX.exe" "$SHORTCUT_NAME6 (DirectX)" "$SHORTCUT_NAME6.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME6 (DirectX)" "$WINEPREFIX/drive_c/GOG Games/Avernum Series/Avernum 6/Avernum 6 Instructions.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYjYQAKCRDlMfrJqhPK
R1ZQAJ9ZAsu0z4ttM4oovt+tmNpqG4PkpgCfQ8+LJw5ullvdlTZS9oEOwibXLvM=
=Wp7l
-----END PGP SIGNATURE-----
