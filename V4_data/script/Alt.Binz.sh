#!/bin/bash
# Date : (2012-05-07 05-48)
# Last revision : (2013-12-08 18-33)
# Wine version used : 1.4
# Distribution used to test : Ubuntu 12.04 LTS
# Author : Nexgen

# CHANGELOG
# [SuperPlumus] (2013-12-08 18-33)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Alt.Binz"
PREFIX="AltBinz"
WORKING_WINE_VERSION="1.4"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Rdl" "http://www.altbinz.net" "Nexgen" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_LunaTheme
# Declaration of variables pointing to the installation files depending on the choice of the user.
SOURCE_1="http://chewie4u.free.fr/altbinz/altbinz_0.39.4.exe"
SOURCE_2="http://www.altbinz.net/downloads/altbinz_0.39.4.exe"
# Variable declaration containing the different version of the application.
VERSION_1="v0.39.4"
# Variable declaration stating the names of files according to their version.
FILE_1="altbinz_0.39.4.exe"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Creating a menu allowing the user to choose the version of the application and the source of the download.
POL_SetupWindow_menu_num "$(eval_gettext 'Please select the setup file to run')" "$TITLE" "$TITLE $VERSION_1 - (Free) - Mirror 1~$TITLE $VERSION_1 - (Free) - Mirror 2" "~"

# Verification of user choice. The file will be downloaded and installed.
if [ "$APP_ANSWER" = "0" ]; then
    POL_Download "$SOURCE_1" "de4122f9bc162f867d6a0f434804e299"
elif [ "$APP_ANSWER" = "1" ]; then
    POL_Download "$SOURCE_2" "de4122f9bc162f867d6a0f434804e299"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/$FILE_1"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "altbinz.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKkrp0ACgkQ5TH6yaoTykdTYQCeO+4ooWTr4ekd0rxdhZrboZuR
rfYAn3d/0Ys5z7WrWmsLktNgQjou/Pny
=3iS/
-----END PGP SIGNATURE-----
