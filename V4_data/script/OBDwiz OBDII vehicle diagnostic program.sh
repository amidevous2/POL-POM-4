#!/usr/bin/env playonlinux-bash

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
WINE_VERSION="1.6.2"
TITLE="OBDwiz OBDII vehicle diagnostic program"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "OBDwiz installation" "Kukulo" "OBDwiz"

POL_Wine_SelectPrefix "OBDwiz2"
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_System_TmpCreate "OBDwiz2"
POL_Call POL_Install_dotnet35
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "https://www.obdsoftware.net/downloads/obdwiz/current" 
        POL_Wine_WaitBefore "$TITLE"
        mv "$POL_System_TmpDir/current" "$POL_System_TmpDir/OBDwizSetup.exe"
        POL_Wine "$POL_System_TmpDir/OBDwizSetup.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ]
then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the install file.')" "$TITLE"
        SETUP_PATH="$APP_ANSWER"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$SETUP_PATH"
fi

POL_Wine_WaitExit "$TITLE"

POL_Shortcut "OBDwiz.exe" "OBDwiz"
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlYxN/IACgkQ5TH6yaoTykd0cgCgnG5AVS9nRW9gLNCFBTt13Vwk
hIYAnAoNd6D4Tknar5eSqf0eFMChk3ch
=GOVw
-----END PGP SIGNATURE-----
