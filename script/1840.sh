#!/bin/bash
# Date : (2013-09-22 ??-??)
# Last revision : (2013-10-01 23-24)
# Wine version used : 1.4.1
# Distribution used to test : Ubuntu-GNOME 13.04
# Author : Massawi33
#
# CHANGELOG:
# [Massawi33] (2013-09-22)
#   First script.
# [Dadu042] (2019-12-24)
#   Wine 1.4.1 -> system version.
#   Add shortcuts category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Pro Evolution Soccer 2014"
PREFIX="ProEvolutionSoccer2014"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Konami" "http://pes.konami.com/" "Massawi33" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate ""

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
    POL_SetupWindow_check_cdrom "Pro Evolution Soccer 2014.msi"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$CDROM/Pro Evolution Soccer 2014.msi"
    POL_Wine_WaitExit "$TITLE"
fi

POL_Call POL_Install_dotnet40

POL_Wine_SetVideoDriver
POL_SetupWindow_VMS "512"

POL_Shortcut "pes2014.exe" "$TITLE" "" "" "Game;"
POL_Shortcut "settings.exe" "$TITLE - Settings" "" "" "Game;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgIvrwAKCRDlMfrJqhPK
Rzg/AJ9T7enx+GF9eeYlfMBGoU8i95GrZACcCKXe5CdQUzDwn24FO9IFX+iyjkQ=
=f+2L
-----END PGP SIGNATURE-----
