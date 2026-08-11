#!/bin/bash
# Date : (2012-12-23 17-44)
# Last revision : (2014-11-16 19-20)
# Wine version used : 1.5.16
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Tested with install archives:
# HoMM3 HD 3.25f.exe 7637343 "a9a476bcb71254bfe733c5cd1962d2b9"
# HoMM3 HD 3.26f.exe 7890918 "b7e260b3175ae2e8d489b009ae65c3ce"
# HoMM3 HD 3.27f.exe 7876422 "2f9238592730621f05061900e96c8274"
# HoMM3 HD 3.28f.exe 7876526 "eeea22c7e7ea9488c925b6eef01bc4dc"
# HoMM3 HD 3.43f.exe 7946385 "65c5275893c6badfd21589758cc7d46b"
# HoMM3 HD 3.45f.exe 7947810 "e5175cc3f5936d111b5dbfcfd9f97f7c"
# HoMM3 HD 3.57f.exe 7976623 "c529fc34f6c1bb0934f50f854ba205db"
# HoMM3 HD 3.3.714f.exe 8256139 "e1d0f2965c82897ee8baa3e4bb66c2aa"
# HoMM3 HD 3.3.802f.exe 8273069 "cd5be0a238c06e51e94dd7f51fff20f3"

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Must match heroesofmightandmagic3-gog script values
TITLE_REQUIRED="GOG.com - Heroes of Might and Magic 3 Complete"
PREFIX="HoMM3_gog"
WORKING_WINE_VERSION="1.5.16"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="1.3.10"

DOWNLOAD_URL="https://sites.google.com/site/heroes3hd/eng/download"

TITLE="GOG.com - Heroes of Might and Magic 3 HD mod"
SHORTCUT_NAME="Heroes of Might and Magic 3 Complete (HD)"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1519
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Alexander Barinov" "$URL" "Pierre Etchemaite" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_AutoSetVersionEnv
POL_LoadVar_PROGRAMFILES

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    POL_SetupWindow_question "$(eval_gettext 'You can download the archive file from:')\n$DOWNLOAD_URL\n$(eval_gettext 'Go there now?')" "$TITLE"
    [ "$APP_ANSWER" = "TRUE" ] && POL_Browser "$DOWNLOAD_URL"

    cd $HOME
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" ""
    ARCHIVE="$APP_ANSWER"
fi


POL_Wine_WaitBefore "$TITLE"

POL_Wine "$ARCHIVE" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"


POL_Shortcut "HD3_Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRo7c8ACgkQ5TH6yaoTykeh6QCfZMPBbpE/uWCeIIbdY2e9cpgz
ab4AoKtijhbjgcrjwjd7Ms/k2lMMTS+c
=Edm2
-----END PGP SIGNATURE-----
