#!/bin/bash
# Date : (2012-07-02 19-30)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] 2012-07-02 19-30)
#   Initial script.
# [Pierre Etchemaite] (2014-01-31 22-12)
#   Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.6.2 -> 3.0.3 (should fix the GLSL issue).
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="arcanum_of_steamworks_and_magick_obscura"
PREFIX="Arcanum_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Arcanum"
SHORTCUT_NAME="Arcanum"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1298
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Troika Games / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c09523c61edd18abb97da97463e07a88"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Arcanum.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-No3d -doublebuffer" "Game;RolePlaying;" # "-fullscreen"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Arcanum/Manual.pdf"
# C:\GOG Games\Arcanum\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYfFwAKCRDlMfrJqhPK
R07qAKCRkvk43apth1sYa8zwIV1ARWPJaACfY51/RvthPx6dFhp7aAG9dcdm5Ho=
=8qN1
-----END PGP SIGNATURE-----
