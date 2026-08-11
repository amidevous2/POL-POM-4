#!/bin/bash
# Date : (2012-12-23 16-55)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
#
# CHANGELOG: 
# [Pierre Etchemaite] (2012-12-23 16-55)
#   Initial script. Wine 1.5.16 ?
# [Dadu042] (2019-06-12)
#   Upgrade from Wine 1.5.16 to 1.9.24 on Linux, because the script crash with POL v4.x
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.9.24 -> 2.22. Mac: 1.3.10 -> 2.22

# Wine 1.5.16 + Set_Managed Off choice:
# http://www.playonlinux.com/en/topic-9996-HoMM3_HD_issue.html
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="heroes_of_might_and_magic_3_complete_edition"
PREFIX="HoMM3_gog"
WORKING_WINE_VERSION="2.22"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="2.22"
 
TITLE="GOG.com - Heroes of Might and Magic 3 Complete"
SHORTCUT_NAME="Heroes of Might and Magic 3 Complete"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1518
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "New World Computing Inc. / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "263d58f8cc026dd861e9bbcadecba318"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"
 
POL_Call POL_GoG_install /nogui
 
 
# GoG work!
Set_OS winxp
 
POL_SetupWindow_VMS "2"
 
# http://appdb.winehq.org/objectManager.php?sClass=version&iId=24425
Set_Managed "Off"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
POL_Shortcut "Heroes3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Heroes of Might and Magic 3 Complete/Heroes3_Manual.pdf"
# C:\GOG Games\Heroes of Might and Magic 3\Heroes3_AB_Manual.pdf
# C:\GOG Games\Heroes of Might and Magic 3\Heroes3_SoD_Manual.pdf
# C:\GOG Games\Heroes of Might and Magic 3\Heroes3_Tutorial.pdf
# C:\GOG Games\Heroes of Might and Magic 3\README.TXT
# C:\GOG Games\Heroes of Might and Magic 3\h3ccmped.exe
# C:\GOG Games\Heroes of Might and Magic 3\h3maped.exe
 
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXp04pwAKCRDlMfrJqhPK
R3KZAJ9NLnE+q1VfNOnQ8UL55rjGNH/99ACfZ1ZYK7OAjtYROJGq6dEO+QV6pQU=
=BIO9
-----END PGP SIGNATURE-----
