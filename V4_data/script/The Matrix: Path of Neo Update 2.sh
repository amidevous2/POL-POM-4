#!/bin/bash
# Date : (2014-04-06T10:42Z)
# Last revision : (2014-04-06T10:42Z)
# Distribution used to test : Arch Linux
# Author : Alexander Borysov
# Script licence : GPLv3
# Program licence: Proprietary

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

install_patch () {
    local ID="$1"
    local FILENAME="$2"
    local NAME="$3"
    local MD5="$4"

    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        local URI="${POL_System_TmpDir}/$FILENAME"
        POL_Call POL_Gamefront_Download "$ID" "$POL_System_TmpDir" "$URI" "$NAME"
        PATCHNAME="$URI"
    else
        POL_SetupWindow_browse "$NAME: $(eval_gettext "Please select the setup file to run.")" "$TITLE"
        PATCHNAME="$APP_ANSWER"
    fi

    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$PATCHNAME"
}

TITLE_REQUIRED="The Matrix: Path of Neo"
TITLE="$TITLE_REQUIRED Update 2"
PREFIX="MatrixPathOfNeo"


POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1992
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Atari" "http://atari.com" "Alexander Borysov" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

[ "$INSTALL_METHOD" = "DOWNLOAD" ] && POL_System_TmpCreate "$PREFIX"
install_patch 4344398 "pathofneo_retail-update1_usa.exe" "$TITLE_REQUIRED Update 1" "2481b5c1b40471345b839e53b7b38da9"
install_patch 4560917 "pathofneo_update1-to-update2_usa.exe" "$TITLE_REQUIRED Update 1-2" "2edfe8414403b6e3517a83edc7d6b5da"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEUEABECAAYFAlNERSsACgkQ5TH6yaoTykcyBgCglLe9fyNPAACwxXBvp2Xh23JQ
UQYAmPzbx/Nuqr1aCmA5u0mT8ZoKb1U=
=OovB
-----END PGP SIGNATURE-----
