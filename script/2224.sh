#!/bin/bash
#
# Date : (2014-08-16 14-35)
# Last revision : see changelog
# Wine version used : 3.0
# Distribution used to test : Mac OS X 10.9.4
# Author : piotr58
#
# CHANGELOG
# [piotr58] (2014-08-17 02-08)
#   Correction to create shortcut. Use a local directory to launch software and
#   install it.
# [piotr58] (2014-08-17 12-08)
#   Correction to use TMPDIR to launch software (it's more clean).
# [piotr58] (2014-08-17 14-50)
#   Correction to use TMPDIR to launch software (it's more clean).
# [Tutul] (2014-08-17 15-09)
#   A little correction for the script (nothing really important, juste for guidelines)
# [Dadu042] (2019-12-22)
#   Wine 1.7.12 (in fact it was system's version) -> 3.0
#   Add software category.
#   Add link to the user guide.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Orbitron"
PREFIX="Orbitron"
export WINEDEBUG="-all"
 
# Starting the script
POL_SetupWindow_Init
POL_SetupWindow_SetID 2224
POL_Debug_Init
POL_SetupWindow_presentation "Orbitron - Satellite Tracking System" "Sebastian Stoff" "http://www.stoff.pl" "piotr58" "$TITLE"

# Setting Wine Version
WORKING_WINE_VERSION="3.0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ] ; then
	POL_System_TmpCreate "$PREFIX"
	cd "$POL_System_TmpDir"
	POL_Download "http://www.stoff.pl/orbitron/files/orbitron.exe"
	SETUP_EXE="orbitron.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ] ; then
	POL_SetupWindow_browse "Please select the installation file to run." "$TITLE"
	SETUP_EXE="$APP_ANSWER"
fi
POL_Wine_WaitBefore "$TITLE"
POL_Wine $SETUP_EXE
POL_Wine_WaitExit "$TITLE"

 
POL_System_TmpDelete
cd "$WINEPREFIX/drive_c/Program Files/Orbitron"
POL_Shortcut "Orbitron.exe" "$TITLE" "" "" "Science;"
POL_Shortcut_Document "$TITLE" "cnt.htm"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXf9D9QAKCRDlMfrJqhPK
R38xAJ9wneOlo3YxRYMvfccBgE42cfIUEwCePcpUdqUCsDi3RN0GX8VkcFtIQYY=
=9xFv
-----END PGP SIGNATURE-----
