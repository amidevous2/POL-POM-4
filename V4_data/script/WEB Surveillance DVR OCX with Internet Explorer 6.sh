#!/usr/bin/env bash

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
WINE_VERSION="3.13"
TITLE="WEB Surveillance DVR OCX with Internet Explorer 6"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "WEB Surveillance DVR OCX with Internet Explorer 6" "Evolveo" "https://www.evolveo.eu/" "Kukulo" "WEB_DVR_OCX_IE6"
POL_Wine_SelectPrefix "WEB_DVR_OCX_IE6"
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_System_TmpCreate "GENERAL_IE_OCX"
POL_Call POL_Install_vcrun6
POL_Call POL_Install_ie6
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ] 
then 
	cd "$POL_System_TmpDir"
	POL_Download "http://www.evolveo.eu/ftp/monitoring_system/Detective-S4CIH7/software/IEActive/General_IE_V1.0.2.3_20131104.exe" "7b1148c3d21dc871a9d3458083af83c8"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$POL_System_TmpDir/General_IE_V1.0.2.3_20131104.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ] 
then
  	POL_SetupWindow_browse "$(eval_gettext 'Please select the install file.')" "$TITLE"
	SETUP_PATH="$APP_ANSWER"
 	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$SETUP_PATH"
fi

POL_Wine_WaitExit "$TITLE"
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"
POL_Shortcut "iexplore.exe" "Internet Explorer with DVR OCX"
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXw3kUgAKCRDlMfrJqhPK
R2UxAJ9xJorIo4Q+34Xa1v7Z7kPYNnFKHQCcDhNeofSCNvMrgeTJ9I/fHP6/uBk=
=8X+H
-----END PGP SIGNATURE-----
