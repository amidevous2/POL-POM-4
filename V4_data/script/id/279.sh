#!/bin/bash

if [ "$PLAYONLINUX" = "" ]
then
echo "No PlayOnLinux"
exit 0
fi

source "$PLAYONLINUX/lib/sources" 


POL_SetupWindow_Init

POL_SetupWindow_presentation "Quiet Internet Pager" "QIP development team" "http://qip.ru" "Fenixk19" "qip"

select_prefix "$REPERTOIRE/wineprefix/qip/"
POL_SetupWindow_prefixcreate

#In future, there will be an abillity to detect build version automaticaly
POL_SetupWindow_textbox "What build I should download? It should be available from QIP site." "Select version." "8060"
QIP_BUILD=$APP_ANSWER
cd "$REPERTOIRE/tmp"
POL_SetupWindow_download "Downloading QIP build $QIP_BUILD" "Download" "http://download.qip.ru/qip$QIP_BUILD.exe"

POL_SetupWindow_wait_next_signal "Please wait while QIP is isntalled" "Installation" 
wine qip$QIP_BUILD.exe /S
POL_SetupWindow_detect_exit 

cd "$REPERTOIRE/icones"
POL_SetupWindow_download "Downloading icon" "Download" "http://qip.ru/favicon.ico"
mv favicon.ico qip.ico

POL_SetupWindow_auto_shortcut "qip" "qip.exe" "Quiet Internet Pager" "qip.ico" 

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEcACgkQ5TH6yaoTykfShQCgozCvpOk474Hko+N3EpZoSivZ
udkAnA0nYjVNWReFNGdhdNAjTt4ISZpi
=IeEA
-----END PGP SIGNATURE-----
