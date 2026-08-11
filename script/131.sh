#!/bin/bash
# Distribution used to test : Mac OS 10.7
# Depend : ImageMagick, unzip

# CHANGELOG
# [SuperPlumus] (2013-06-08 17-53)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SimCity 2000"
PREFIX="SimCity2000"
WINEVERSION="1.4-dos_support_0.5"
export WINEDEBUG="-all"

POL_SetupWindow_Init
POL_Debug_Init
POL_RequiredVersion "4.0.18" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.18 is required to install $TITLE"

POL_SetupWindow_presentation "$TITLE" "Maxis" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_SetupWindow_InstallMethod "CD"

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_cdrom
    setup="DOS/INSTALL.EXE"
    POL_SetupWindow_cdrom_MountPC "$setup"
    POL_SetupWindow_check_cdrom "$setup"

    POL_Wine_PrefixCreate "$WINEVERSION"
    POL_Call POL_Install_DosboxDrive

    SetupFile="$CDROM/$setup"
    cd "$CDROM/DOS"
    POL_Wine "INSTALL.EXE"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the MS-DOS version of setup file:')" "$TITLE"
    SetupFile="$APP_ANSWER"
    POL_Wine_PrefixCreate "$WINEVERSION"
    POL_Wine "$SetupFile"
fi


POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_cdrom_UmountPC
    POL_SetupWindow_cdrom_MountMessage
fi

POL_SetupWindow_menu_num "What edition of $TITLE do you have?" "$TITLE" "Normal Edition~Special Edition" "~"

if [ "$APP_ANSWER" = "0" ]; then
    POL_Shortcut "SC2000.EXE" "$TITLE"
else
    POL_Shortcut "SC2K.EXE" "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGzVEsACgkQ5TH6yaoTykcCFACcDFcnM5HvIG6kOv4cX0kS5w/h
SzkAnRzwEaOwQQIY8QfYi+E2ojVA/7Dt
=L+mV
-----END PGP SIGNATURE-----
