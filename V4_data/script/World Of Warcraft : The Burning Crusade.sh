#!/bin/bash
# Date : (2009-07-07 19-30)
# Last revision : (2013-05-19 20-23)
# Wine version used : N/A
# Distribution used to test : N/A
# Author : Asimov and SuperPlumus

# CHANGELOG
# [SuperPlumus] (2013-05-12 16-56)
#   Add --allow-kill in POL_Wine_WaitExit
#   Remove POL_Wine_PrefixCreate and POL_System_SetArch
# [SuperPlumus] (2013-05-19 20-23)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="World of Warcraft : The Burning Crusade"
TITLE_REQUIRED="World of Warcraft"
PREFIX="WorldOfWarcraft"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wow/top.jpg" "http://files.playonlinux.com/resources/setups/wow_bc/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Blizzard Entertainment" "http://www.blizzard.com" "Asimov and SuperPlumus" "$PREFIX"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
POL_SetupWindow_Close
exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "CD,DVD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 1 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 2 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 2.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 3 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 3.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"

POL_SetupWindow_message "$(eval_gettext 'Please insert game media 4 into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome 4.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/*.mpq "$POL_System_TmpDir"

cd "$POL_System_TmpDir"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Installer.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill

fi
if [ "$INSTALL_METHOD" = "DVD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Installer Tome.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"

cd "$POL_System_TmpDir"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Installer.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE" --allow-kill

fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGZGckACgkQ5TH6yaoTykfPowCgjxfEExKp8IB7QiRl1X8Xq31P
bsMAnifVcCOWK5vxjYAuEWEQAP4yctIj
=Q+7F
-----END PGP SIGNATURE-----
