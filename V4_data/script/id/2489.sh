#!/bin/bash
# Date : (2015-03-30T20:30Z)
# Last revision : (2015-03-30T20:30Z)
# Distribution used to test : Arch Linux
# Author : Alexander Borysov (Xenos5)
# Script licence : GPLv3
# Program licence: Proprietary

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="S.T.A.L.K.E.R.: Shadow of Chernobyl"
TITLE="$TITLE_REQUIRED Patch 1.0005"
PREFIX="STALKERShadowOfChernobyl"

# Gamefront download ids for the various releases
WW_ID=11854167
US_ID=9029415
DD_ID=11853727
PL_ID=11853514
CZ_ID=11862431

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
    POL_SetupWindow_menu_num "$(eval_gettext 'Please select the game release')" "$TITLE" "$(eval_gettext 'Worldwide')~$(eval_gettext 'US')~$(eval_gettext 'Digital Distribution')~$(eval_gettext 'Polish')~$(eval_gettext 'Czech')" "~"
    case $APP_ANSWER in
        0)
            ID=$WW_ID
            NAME=stkww10005.exe
            ;;
        1)
            ID=$US_ID
            NAME=stkus10005.exe
            ;;
        2)
            ID=$DD_ID
            NAME=stkdd10005.exe
            ;;
        3)
            ID=$PL_ID
            NAME=stkpl10005.exe
            ;;
        4)
            ID=$CZ_ID
            NAME=stkcz10005.exe
            ;;
        *)
            POL_Debug_Fatal "$(eval_gettext 'Could not parse game release response')"
            POL_SetupWindow_Close
            exit
    esac

    POL_System_TmpCreate "$PREFIX"
    URI="${POL_System_TmpDir}/$NAME"
    POL_Call POL_Gamefront_Download "$ID" "$POL_System_TmpDir" "$URI" "$TITLE"
    PATCHNAME="$URI"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    PATCHNAME="$APP_ANSWER"
fi

POL_Wine "$PATCHNAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUZ5hgACgkQ5TH6yaoTykcfPQCbBV20WFBwi1KE4v14TKHZrZhz
e8MAn1vlc2MbXp0wuIYO2Wko3o20hKRl
=M4Ns
-----END PGP SIGNATURE-----
