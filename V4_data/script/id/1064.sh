#!/bin/bash
# Date : (2012-01-16 20-04)
# Last revision : (2013-05-18 18-33)
# Wine version used : 1.5.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Freeware
# Depend :

# Tested with install archives:
# Circle_of_Eight_Modpack_7.8.0_Setup.exe 192055661 "5729e38c734ab0e60296bafdebae4e0c"
# and
# Circle_of_Eight_Modpack_7.8.0_NC_Setup.exe 404436762 "c741c1707eb29b22867ced4ff86a4d0e"

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Must match templeofelementalevil-gog script values
TITLE_REQUIRED="The Temple of Elemental Evil (GoG release)"
PREFIX="TempleElementalEvil_gog"
WORKING_WINE_VERSION="1.5.22"
INSTALLBIN="Circle_of_Eight_Modpack_7.7.0_NC_Setup.exe"

DOWNLOAD_URL="http://www.moddb.com/mods/circle-of-eight-modpack"

TITLE="GOG.com - Temple of Elemental Evil patch CO8 Modpack 7"
SHORTCUT_NAME="Temple of Elemental Evil - Circle of Eight Modpack 7"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1064
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Circle of Eight" "http://www.co8.org/" "Pierre Etchemaite" "$PREFIX"

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

# neither wine-mono 0.0.8 nor mono 2.10 worked...
POL_Call POL_Install_dotnet20sp2

POL_SetupWindow_message "$(eval_gettext 'Now you must install the modpack in directory:')\nC:\\GOG Games\\Temple of Elemental Evil\\" "$TITLE"

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

POL_Wine "$ARCHIVE" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"

POL_Wine_WaitExit "$TITLE"

POL_Shortcut "TFE-X.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEABECAAYFAlGXt5EACgkQ5TH6yaoTyke+vwCYusnuScmpdtDSl/d1YsSP6hG1
8ACeOzPVDW4O9rtwvLkMl+XVIcwwtsQ=
=k0XP
-----END PGP SIGNATURE-----
