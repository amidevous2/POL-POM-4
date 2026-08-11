#!/bin/bash
# Date : (2019-06-13 19-31)
# Last revision : (2019-06-13 19-31)
# Wine version used : 4.0.1
# Distribution used to test : Ubunru 19.04 x64
# Author : LinuxScripter

# CHANGELOG
# [LinuxScripter] (2019-06-13)
#   First script.
# [Dadu042] (2019-08-12)
#   Wine 4.0.1 -> 4.0.2
#   Fix download URL.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Synthesia"
EDITOR="Synthesia LLC"
AUTHOR="LinuxScripter"
GAME_URL="http://www.synthesiagame.com/"
PREFIX="Synthesia"
WORKING_WINE_VERSION="4.0.4"
    
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
     
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_Install_gdiplus

POL_SetupWindow_message "$(eval_gettext 'For the installation to be successful, Timidity must is installed on your system.')"
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    cd "$POL_System_TmpDir"
    POL_Download "http://synthesia.s3.amazonaws.com/files/Synthesia-10.6-installer.exe"
    POL_Wine start /unix "Synthesia-10.6-installer.exe"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi
 
POL_Shortcut "Synthesia.exe" "$TITLE" "" ""
POL_SetupWindow_message "$(eval_gettext 'For Synthesia running properly, you have to change the output to 'Timidity'(with the speaker icon) in Keyboard Setup.')"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYjO9lQAKCRDlMfrJqhPK
RwJYAKCHR1kqQchsDrDjNd+MhzNf01I3ygCgryJimgPXVD1J7Ag5m4ebJkhe0JQ=
=iiz1
-----END PGP SIGNATURE-----
