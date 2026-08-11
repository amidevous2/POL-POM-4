#!/bin/bash
# Date : (2012-12-02 15-45)
# Last revision : changelog
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Wine
# 1.4.1, 1.5.0: unimplemented function msvcp90.dll.??0?$basic_ifstream@DU?$char_traits@D@std@@@std@@QAE@XZ, aborting
# 1.5.7, 1.5.8: black screen
# 1.5.9, 1.5.10, 1.5.12: ok

# CHANGELOG
# [Pierre Etchemaite] (2012-12-02 15-45)
#   Initial script.
# [Pierre Etchemaite] (2013-05-16 21-17)
#   ?
# [khampf] (2017-à3-11)
#   Add Register mouse clicks
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.5.9 -> 3.0.3


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="total_anihilation_commander_pack"
PREFIX="TotalAnnihilationCP_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Total Annihilation: Commander Pack"
SHORTCUT_NAME="Total Annihilation: Commander Pack"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1498
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cavedog Entertainment / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0328c16e7bd74dd3cb9229977a11e9d7"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# Otherwise the game complains about DirectX version
Set_OS win98

# Could not find any reliable info about that
POL_SetupWindow_VMS "4"

# Help with mouse scrolling
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Register mouse clicks
Set_Managed "off"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "TotalA.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Total Annihilation - Commander Pack/manual.pdf"
# C:\GOG Games\Total Annihilation - Commander Pack\readme.txt
# C:\GOG Games\Total Annihilation - Commander Pack\BTREADME.TXT
# C:\GOG Games\Total Annihilation - Commander Pack\Taccread.txt
# C:\GOG Games\Total Annihilation - Commander Pack\TAE.EXE
# C:\GOG Games\Total Annihilation - Commander Pack\TAEread.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYZCgAKCRDlMfrJqhPK
R5OxAJ0XEHXtiU+XrFJ7Fu4csfD8JO/7xACfXfRM2k6UU0LHPzWV0rZyTmn8LOA=
=oL1u
-----END PGP SIGNATURE-----
