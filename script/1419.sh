#!/bin/bash
# Date : (2012-09-29 16-22)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-29 16-22)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2014-02-01 23-50)
#   ?
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.2 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="deus_ex_invisible_war"
PREFIX="DeusEx2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Deus Ex 2: Invisible War"
SHORTCUT_NAME="Deus Ex 2: Invisible War"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1419
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ion Storm Inc. / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "6319ae4c3ce454f17c852f61aba3307b" "8c07943821a7d0d7cba98af1f0b9b743" "acf2dd2d2c1ff0e92a59c20028192b62"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "dx2.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Deus Ex - Invisible War/manual.pdf"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwl/gAKCRDlMfrJqhPK
R/RrAJwO8oSJLHAs0HFmhQxoaCVIndyNBgCgmheMlYrXc5vxb8BnQQd3mJie5VY=
=3Wkq
-----END PGP SIGNATURE-----
