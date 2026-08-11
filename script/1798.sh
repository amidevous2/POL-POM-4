#!/bin/bash
# Date : 18/08/2013
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Ubuntu-GNOME 13.04
# Author : Massawi33
#
# CHANGELOG:
# [Massawi33] (2013-09-18)
#   First script.
# [Dadu042] (2019-12-24)
#   Wine 1.5.20 -> system version.
#   Add shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Pro Evolution Soccer 2013"
PREFIX="PES2013"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Konami" "http://pes.konami.com/" "Massawi33" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate ""

POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME" 
    POL_SetupWindow_browse " $(eval_gettext 'Please select the file named Pro Evolution Soccer 2013.msi')" "$TITLE"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed')" "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DVD" ]
then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "Pro Evolution Soccer 2013.msi"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed')" "$TITLE"
    POL_Wine start /unix "$CDROM/Pro Evolution Soccer 2013.msi"
fi
POL_Wine_WaitExit "$TITLE"
POL_Shortcut "pes2013.exe" "Pro Evolution Soccer 2013" "" "" "Game;"
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed')" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgIwHwAKCRDlMfrJqhPK
RxCqAJ9aBihl5h7sn3iHtit3SE75gBnNMwCgnpUlkiSs2+S6xRgBbUGp77prKbc=
=yHky
-----END PGP SIGNATURE-----
