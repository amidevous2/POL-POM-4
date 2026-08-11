#!/bin/bash
# Date : (2015-03-05 09-05)
# Last revision : See changelog
# Distribution used to test : Ubuntu 14.04 LTS
# Author : Stefan Werner

# CHANGELOG
# [Dadu042] (2019-09-19)
#   Wine 1.9.2 -> 2.22, in order to fix script 'windows fail to appear' (on Ubuntu 18.04 x64).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


# Define constants
TITLE="3D Train Studio"
PREFIX="3D_TrainStudio"
WINEVERSION="2.22"

# Start installation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Stefan Werner" "http://www.3d-train.com" "Stefan Werner" "$PREFIX"

# Prepare the wine config
POL_System_SetArch "x86"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

Set_OS "win7"
POL_Wine_Direct3D "UseGLSL" "disabled"

POL_SetupWindow_wait "$(eval_gettext 'Please wait while installing prerequisites.')" "$TITLE"
POL_Call POL_Install_tahoma2

# Install the main application, either by using a local setup file or by downloading
# the latest setup from the web.
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"    
    cd "$POL_System_TmpDir"
    POL_Download "https://www.3d-modellbahn.de/files/client/v3/SetupTrainStudio.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$POL_System_TmpDir/SetupTrainStudio.exe"
    POL_System_TmpDelete
fi
 
# Finish installation
POL_Shortcut "ModellbahnStudio.exe" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXYNyBQAKCRDlMfrJqhPK
R0EbAKCS9UhpcO1zKzfeW4tzcZcSSqXQewCfU9ojym3FZi5Ohr76lN3NeuZSSE4=
=ON5V
-----END PGP SIGNATURE-----
