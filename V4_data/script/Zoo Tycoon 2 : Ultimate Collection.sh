#!/bin/bash
# Date : (2011-10-28 11-22)
# Last revision : (2013-05-19 12-44)
# Wine version used : 1.3.30
# Distribution used to test : N/A
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2013-05-19 12-44)
#   Use POL_Call POL_Function_NoCDWarning
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Zoo Tycoon : Ultimate Collection"
PREFIX="ZT2-UC"
WORKING_WINE_VERSION="1.3.30"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft Games" "http://www.microsoft.com" "SuperPlumus" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 1 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Files/x300_000.z2f"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -R "$CDROM"/* "$POL_System_TmpDir"
chmod -R 777 "$POL_System_TmpDir"

# Copie des fichiers du cd 2
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 2 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "files/x301_000.z2f"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -R "$CDROM"/* "$POL_System_TmpDir"
chmod -R 777 "$POL_System_TmpDir"

# Copie des fichiers du cd 3
POL_SetupWindow_message "$(eval_gettext 'Please insert game media 3 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "files/x302_000.z2f"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -R "$CDROM"/* "$POL_System_TmpDir"
chmod -R 777 "$POL_System_TmpDir"

# Copie du contenu du dossier "files" dans le dossier "Files" afin d'eviter un probleme lors de l'installation
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -R "$POL_System_TmpDir/files"/* "$POL_System_TmpDir/Files/"
chmod -R 777 "$POL_System_TmpDir"

POL_Wine_WaitBefore "$TITLE"
cd "$POL_System_TmpDir"
POL_Wine start /unix "autorun.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 1 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Files/x300_000.z2f"

POL_Call POL_Function_NoCDWarning

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

POL_Wine_Direct3D "OffscreenRenderingMode" "backbuffer"

POL_SetupWindow_VMS

POL_Wine_SetVideoDriver

POL_System_TmpDelete

POL_Shortcut "zt.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGYr+oACgkQ5TH6yaoTyke6TgCbBBCEMKdjtBcXEWDEG5mmnAyq
6VUAn1dufy2gkBV55KFBNz1TYljv8cti
=N9eP
-----END PGP SIGNATURE-----
