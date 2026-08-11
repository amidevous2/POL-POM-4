#!/bin/bash
# Date : (2016-01-17 12:17)
# Last revision : (2016-01-17 12:17)
# Wine version used : 1.6.2
# Distribution used to test : Linux Mint 17.3
# Author : plata

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SchILD-NRW"
PREFIX="SchildNrw"
EDITOR="Schulverwaltung NRW"
URL="https://www.svws.nrw.de/index.php?id=schildnrw"
AUTHOR="plata"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$URL" "$AUTHOR" "$PREFIX"
 
POL_System_TmpCreate "$PREFIX"

#select installation method
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "https://www.svws.nrw.de/uploads/media/SchILDBasisSetup.exe"
    INSTALLER="$POL_System_TmpDir/SchILDBasisSetup.exe"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

#install dependencies
POL_Call POL_Install_mdac28
POL_Call POL_Install_msls31
POL_Call POL_Install_riched30
POL_Call POL_Install_vbrun6

#fetch required dlls
cd "$WINEPREFIX/drive_c/windows/system32"
POL_Download "http://schulverwaltungsprogramme.msw.nrw.de/download/EncodeClasses2.dll" "d63af4460b2584e950c6dd1cc4d7fdf8"
POL_Download "http://dllfiles.free.fr/dllfiles/fontsub.dll" "c0b6227dfa048a3ba6cad00304ea8b09"
 
#install program
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Change installation path to C:\ and ignore possible dll error messages.')" "$TITLE"
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed...')"
POL_Wine "$INSTALLER"
 
POL_System_TmpDelete
 
POL_Shortcut "ExtNotMod.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$(eval_gettext '$TITLE installation finished')"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSELwAKCRDlMfrJqhPK
R5LfAJsGQLxqZYb+0g+H5pEtYD6Hayl10wCdG8WUOajU4m37uW2QBfya9tYO0ik=
=SsLW
-----END PGP SIGNATURE-----
