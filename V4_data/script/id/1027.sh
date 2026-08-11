#!/bin/bash
# Date : (2011-12-28 22-21)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-28 22-21)
#   Initial script.
# [Pierre Etchemaite] (2013-04-01 14-42)
#   ?
# [Dadu042] (2020-01-19 22:00)
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="advent_rising"
PREFIX="AdventRising_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Advent Rising"
SHORTCUT_NAME="Advent Rising"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1027
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "GlyphX Games / Majesco" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "28869aa14b25d9705f65ed916458a9aa" "16038e27a471a710b06bf8d737fc3679" "3f98999aa162600b4b8cb0fe036cbe21" "e210f8aace0110d0ab20b46a1d10ee92"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Wine_X11Drv "GrabFullScreen" "Y"
# Read on WineHQ AppDB test, not sure it's necessary
POL_Wine_Direct3D "OffscreenRenderingMode" "backbuffer"

Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "advent.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Advent Rising/manual.pdf"
# C:/$PROGRAMFILES/GOG.com/Advent Rising/Help/ReadMe.int.txt

POL_SetupWindow_Close

exit 
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYYcgAKCRDlMfrJqhPK
R9XHAJ9ljIQY8pPOh+4r8eaIDZRANhUd5gCdHbZkNMAT3ZiUlVYk7qXWf2bO8Xk=
=vgAW
-----END PGP SIGNATURE-----
