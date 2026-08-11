#!/bin/bash
# Date : (2014-02-09)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : UbuntuGnome 13.10
# Author : Massawi33
#
# CHANGELOG
# [Massawi33] (2014-02-09)
#   First script.
# [Dadu042] (2019-12-30)
#   Wine 1.3.20 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed Undercover"
PREFIX="NFSUndercover"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1941
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.needforspeed.com/fr_FR/undercover" "Massawi33" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "2.22"
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DVD" ]
then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "nfs.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$CDROM/AutoRun.exe"
    POL_Wine_WaitExit "$TITLE"
fi
 
POL_Wine_SetVideoDriver
POL_SetupWindow_VMS "128"

POL_Shortcut "nfs.exe" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsjfAAKCRDlMfrJqhPK
R5KLAKCByN/M8gKsaO6l0XqS5O5T49PtxwCgkyNI2XTghT4fOcpqk9Zo6dYM4yI=
=Ms1P
-----END PGP SIGNATURE-----
