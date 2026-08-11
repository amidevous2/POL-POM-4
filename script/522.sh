#!/bin/bash
# PlayOnLinux Function
 
# Date : (2009-11-19 21-50)
# Last revision : (2021-10-18 17:46)
# Author : Berillions
# Updated by : l.ukasz
# Licence : 
# Depend : none
 
POL_Wine_WaitBefore "msls31"
# Official link don't work now, using archived file from Internet Archive WayBack Machine
POL_Download_Resource "https://web.archive.org/web/20160710055851if_/http://download.microsoft.com/download/WindowsInstaller/Install/2.0/NT45/EN-US/InstMsiW.exe" "53820efbc952107ee1a38be6cd5aa3f0"
# POL_Download_Resource "http://download.microsoft.com/download/WindowsInstaller/Install/2.0/NT45/EN-US/InstMsiW.exe" "53820efbc952107ee1a38be6cd5aa3f0"


if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
cabextract -F msls31.dll "$POL_USER_ROOT/ressources/InstMsiW.exe"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfCQAKCRDlMfrJqhPK
R0eLAJ0cTai1PibIMqb5Mz7Em8MqMmjFOwCdHN6qek9ocxNoaj9rpFVq4zl6wb4=
=ctlQ
-----END PGP SIGNATURE-----
