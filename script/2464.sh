#!/bin/bash
# Date : (2015-03-09 22:58)
# Last Revision : see changelog
# Wine Version used : system
# Distribution used to test : Debian testing/jessie
# Author: Hoshpak
# Script license : GPL v2
# Programm license : Retail
#
# Depend :
#
# CHANGELOG
# [Hoshpak] (2015-03-09 22:58)
#   Initial script.
# [Dadu042] (2020-02-16)
#   Wine 1.7.38 -> system
#   Force arch x86 for wmp9.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Risen 3: Titan Lords"
PREFIX="Risen3"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Piranha Bytes" "http://risen3.deepsilver.com" "Hoshpak" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate

POL_Call POL_Install_wmp9
Set_OS "win7"

POL_SetupWindow_InstallMethod "DVD,LOCAL"
if [ "$INSTALL_METHOD" = "DVD" ]; then
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
        SETUP="$CDROM_SETUP"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP="$APP_ANSWER"
fi


POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SETUP"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Risen3.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXkl8lAAKCRDlMfrJqhPK
R2xpAJ9bkKPIuMzUSZQvdMJ4Od6X9c2hjwCgsBXqPE2O7aXl2L4NQlpsJzgSQyg=
=lzMf
-----END PGP SIGNATURE-----
