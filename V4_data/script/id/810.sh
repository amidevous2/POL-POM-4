#!/bin/bash
#
# CHANGELOG
# [Quentin Paris] (2009 ?)
#   Initial script.
# [Dadu042] (2020-01-27 23:30)
#   Wine 1.4 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="La Panthere Rose 2 - Destination Mystère"
PREFIX="PanthereRose2"
EDITEUR="Wanderlust Interactive"

#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITEUR" "" "Tinou" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "2.22"

POL_System_CopyDirectory "$CDROM/INSTALL/" "$WINEPREFIX/drive_c/Panthere"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
Set_OS "win95"
POL_System_TmpDelete

Set_Managed Off
POL_Shortcut "HPP.EXE" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCMBAAKCRDlMfrJqhPK
R5WMAKCBnNHmvAvoy+WHh2x9PpvwXXAcBACdHDh6MblXfDjFiEyaDNHxukcpZTo=
=9ujl
-----END PGP SIGNATURE-----
