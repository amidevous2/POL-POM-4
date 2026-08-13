#!/bin/bash
# Date : (2012-04-08 14-51)
# Last revision : (2013-09-30 08-54)
# Distribution used to test :
# Author : SuperPlumus and ademar

# CHANGELOG
# [SuperPlumus] (2012-04-08 14-51)
#   Initial writting
# [SuperPlumus] (2013-05-14 18-45)
#   Remove POL_Wine_PrefixCreate
# [SuperPlumus] (2013-09-30 08-54)
#   Update gettext messages
#   Update $TITLE var

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="X3 : Terran Conflict Patch 3.2"
TITLE_REQUIRED="X3 : Terran Conflict"
PREFIX="X3TC"
PVERSION="3.2"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE_REQUIRED')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
POL_SetupWindow_Close
exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"

STEAM=`find "$WINEPREFIX" -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')"
POL_SetupWindow_Close
exit
fi

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then

cd "$POL_System_TmpDir"
POL_Download "http://dl2.egosoft.com/download/x3tc/files/X3TCUpdate1.0.1_to_3.2.exe" "c9fad11614d76be4f93cb2c8d531adbf"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "X3TCUpdate1.0.1_to_3.2.exe"
POL_Wine_WaitExit "$TITLE"

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJIbgACgkQ5TH6yaoTykemTACgit9sFF73CS5I8iNSnxxO57IL
krwAnAvMeNK23T/0TuqRoFQIpGqE/9bg
=GgVo
-----END PGP SIGNATURE-----
