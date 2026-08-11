#!/bin/bash

# Date : 2016-04-29
# Last revision : see changelog
# Wine version used : 3.0.3, 1.7.55-staging
# Distribution used to test : Ubuntu 16.04 LTS
# Author : http://github.com/kaiwa
# URL :    http://github.com/kaiwa/playonlinux-script-helldorado
# Based on http://www.gamersonlinux.com/forum/threads/helldorado-guide.541/ by "booman"
#
# CHANGELOG
# [NSLW] (2009-05-29 18-00)
#   Initial script.
# [Dadu042] (2020-01-16 23:30)
#   Wine "1.7.55-staging" (outdated) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Helldorado"
PREFIX="$TITLE"
# Requiring staging version of wine because of bug https://bugs.winehq.org/show_bug.cgi?id=37811
WINE_VERSION="3.0.3"

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Spellbound" "http://www.spellbound.de" "http://github.com/kaiwa" "$PREFIX"
POL_SetupWindow_VMS "128"

# FIND SETUP.EXE
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    SETUP_EXE=$APP_ANSWER
elif [ "$INSTALL_METHOD" = "DVD" ]
then
    POL_SetupWindow_check_cdrom "setup.exe"
    SETUP_EXE="$CDROM/setup.exe"
fi

# CREATE WINE PREFIX
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"
Set_OS "win7"
POL_Wine_OverrideDLL "native" "msvcp71"

# INSTALL LIBRARIES
POL_Call POL_Install_corefonts
POL_Call POL_Install_devenum
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
POL_Call POL_Install_tahoma
POL_Call POL_Install_xvid

# INSTALL GAME
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$SETUP_EXE" /SILENT /COMPONENTS="Game Files" /DIR="expand:{pf}\\$TITLE"
POL_Wine_WaitExit "$TITLE"

# ADDITIONAL GAME FILES
POL_SetupWindow_question "$(eval_gettext 'Do you have a patch to install?')" "$TITLE"

if [ $APP_ANSWER ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the file to install.')" "$TITLE"
    cp "$APP_ANSWER" "$WINEPREFIX/drive_c/$PROGRAMFILES/$TITLE"
fi

# FINISH INSTALLATION
POL_Shortcut "Helldorado.exe" "$TITLE" "" "" "Game;"
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

Set_Desktop "On" "1024" "768"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDlcwAKCRDlMfrJqhPK
R8meAJ42kqe+Ud2OXCQ+1plEuFBxQLpKZQCgpmGqT6CJ1LWQJktUGIFIAipnFxU=
=xxHw
-----END PGP SIGNATURE-----
