#!/bin/bash
# Date : (2015-03-29T03:30Z)
# Last revision : (2015-03-29T03:30Z)
# Distribution used to test : Arch Linux
# Author : Alexander Borysov (Xenos5)
# Script licence : GPLv3
# Program licence: Proprietary

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="S.T.A.L.K.E.R.: Clear Sky"
TITLE="$TITLE_REQUIRED Patch 1.5.10"
PREFIX="STALKERClearSky"

# Gamefront download ids for the various releases
WW_ID=14026473
DD_ID=14028245
RU_ID=14031495

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "THQ" "http://stalker-game.com" "Alexander Borysov" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_SetupWindow_menu_num "$(eval_gettext 'Please select the game release')" "$TITLE" "$(eval_gettext 'Worldwide')~$(eval_gettext 'Digital Distribution')~$(eval_gettext 'Russian')" "~"
    case $APP_ANSWER in
        0)
            ID=$WW_ID
            ARCHIVE_NAME="stkcsforpackefigspcjhpatchany10.zip"
            EXE_NAME="stkcs-for-pack-efigspcjh-patch-any-10.exe"
            ;;
        1)
            ID=$DD_ID
            ARCHIVE_NAME="stkcstolpackefigspcjhpatchany10.zip"
            EXE_NAME="stkcs-tol-pack-efigspcjh-patch-any-10.exe"
            ;;
        2)
            ID=$RU_ID
            ARCHIVE_NAME="stkcsruspackrpatchany10fixed.zip"
            EXE_NAME="stkcs-rus-pack-r-patch-any-10-fixed.exe"
            ;;
        *)
            POL_Debug_Fatal "$(eval_gettext 'Could not parse game release response')"
            POL_SetupWindow_Close
            exit
    esac

    POL_System_TmpCreate "$PREFIX"
    ARCHIVE="${POL_System_TmpDir}/$ARCHIVE_NAME"
    POL_Call POL_Gamefront_Download "$ID" "$POL_System_TmpDir" "$ARCHIVE" "$TITLE"
    POL_System_unzip -od "$POL_System_TmpDir" "$ARCHIVE" "$EXE_NAME"
    PATCHNAME="${POL_System_TmpDir}/$EXE_NAME"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    PATCHNAME="$APP_ANSWER"
fi

POL_Wine "$PATCHNAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUZjTsACgkQ5TH6yaoTykdi0gCeIoFYhbC4K5LL7KeAuaKIWHUy
0PYAn1CM1o2ngzq2Cmj01Dfr7XJEXHeD
=qEZh
-----END PGP SIGNATURE-----
