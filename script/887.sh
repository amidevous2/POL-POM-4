#!/bin/bash
# Date : (2011-07-22 12-32)
# Last revision : (2013-05-19 20-37)
# Wine version used : N/A
# Distribution used to test : N/A
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2013-05-12 17-01)
#   Add --allow-kill in POL_Wine_WaitExit
#   Remove POL_Wine_PrefixCreate and POL_System_SetArch
# [SuperPlumus] (2013-05-19 20-37)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="World of Warcraft : Wrath of the Lich King"
TITLE_REQUIRED="World of Warcraft"
PREFIX="WorldOfWarcraft"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wow/top.jpg" "" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Blizzard Entertainment" "http://www.blizzard.com" "SuperPlumus" "$PREFIX"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
POL_SetupWindow_Close
exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "DVD,LOCAL"

if [ "$INSTALL_METHOD" = "DVD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
POL_SetupWindow_cdrom

POL_SetupWindow_wait "Waiting for users commands..." "$TITLE"
VALID_UID=`id -u`
VALID_GID=`id -g`
VALID_DEVNODE=`mount | grep "$CDROM" | awk '{print $1}'`
POL_Call POL_Function_RootCommand "sudo umount \\\"$CDROM\\\" && sudo mkdir -p /media/PlayOnLinux/ && sudo mount -o ro,unhide,uid=$VALID_UID,gid=$VALID_GID $VALID_DEVNODE /media/PlayOnLinux/ ; exit"
CDROM="/media/PlayOnLinux"

POL_SetupWindow_check_cdrom "Installer Tome.mpq"
POL_SetupWindow_wait "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
cp -r "$CDROM"/* "$POL_System_TmpDir"

cd "$POL_System_TmpDir"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Installer.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill

POL_SetupWindow_wait "Waiting for users commands..." "$TITLE"
POL_Call POL_Function_RootCommand "sudo umount $CDROM ; exit"

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

iEYEABECAAYFAlGZHH8ACgkQ5TH6yaoTykeYtACgmdXOjvqAXhJTJZ6UignfOufi
9uQAoJTuH/SMnt7TuGZ23Ir1AwAgKZW1
=FY4k
-----END PGP SIGNATURE-----
