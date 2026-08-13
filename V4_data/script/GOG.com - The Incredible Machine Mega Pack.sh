#!/bin/bash
# Date : (2012-05-13 10-53)
# Last revision : (2013-12-06 02-02)
# Wine version used : 1.4-dos_support_0.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_incredible_machine_mega_pack"
PREFIX="TheIncredibleMachine_gog"
WORKING_WINE_VERSION="1.4-dos_support_0.6"

TITLE="GOG.com - The Incredible Machine Mega Pack"
SHORTCUT_NAME1="TIM - Even More Incredible Machine"
SHORTCUT_NAME2="TIM - The Incredible Machine 3"
SHORTCUT_NAME3="TIM - Return of the Incredible Machine Contraptions"
SHORTCUT_NAME4="TIM - Even More Contraptions"

POL_Call POL_Install_gdiplus # Ref https://www.playonlinux.com/en/app-518-POL_Install_gdiplus.html windows install issue

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1186
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Dynamix / Playdom" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7f842be0463cc33f58e3a0898798cdc6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<_EOFCFG_ >> "$WINEPREFIX/playonlinux_dos.cfg"
dosbox_memsize=16
cpu_core=auto
cpu_cycles=8000
_EOFCFG_

# GoG work!
Set_OS winxp

# "800x600 16-bit color"
POL_SetupWindow_VMS "1"

# Otherwise both "Even More Contraptions" and "Return of Incredible Machine Contraptions" crashes
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "TIM.EXE" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;LogicGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME1" 'POL_SetupWindow_Init'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME1" "POL_SetupWindow_message \"$(eval_gettext 'Please select ANY 3 icons when prompted.')\" \"$SHORTCUT_NAME1\""
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME1" 'POL_SetupWindow_Close'

POL_Shortcut "TIMWIN.EXE" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;LogicGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"

POL_Shortcut "Contraptions.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;LogicGame;"

POL_Shortcut "EvenMore.exe" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;LogicGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"
POL_Shortcut_Document "$SHORTCUT_NAME4" "$GOGROOT/The Incredible Machine Series/The Incredible Machine - Even More Contraptions/readme.txt"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqkuxgAKCRDlMfrJqhPK
R/UFAJ0bQrQ++C642ZUh88Dp6oSLicoumwCeJYS+ELu9QPSzS5rkLABmXbAO/S4=
=sqdj
-----END PGP SIGNATURE-----
