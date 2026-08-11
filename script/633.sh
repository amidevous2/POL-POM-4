#!/bin/bash
# PlayOnLinux Function
# Date : ?
# Last revision : (2022-04-02 8-49)
# Author : NSLW based on Berillions's d3dx9 script

cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "https://dl.4players.de/f1/pc2/sonstiges/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

POL_Wine_WaitBefore "DirectX 9"

POL_SetupWindow_wait_next_signal "PlayOnLinux is installing DirectPlay" "DirectPlay"

mkdir "Directx"
cd Directx
cabextract "../directx_feb2010_redist.exe"

mkdir "dxnt"
cabextract -d "dxnt" dxnt.cab

cd "dxnt"

mv -f dplaysvr.exe "$WINEPREFIX/drive_c/windows/system32"
mv -f dplayx.dll "$WINEPREFIX/drive_c/windows/system32"
mv -f dpnet.dll "$WINEPREFIX/drive_c/windows/system32"
mv -f dpnhpast.dll "$WINEPREFIX/drive_c/windows/system32"
mv -f dpwsockx.dll "$WINEPREFIX/drive_c/windows/system32"

POL_Wine regsvr32 dplayx.dll
POL_Wine regsvr32 dpnet.dll
POL_Wine regsvr32 dpnhpast.dll

#Réglage directplay
POL_Wine_OverrideDLL native dplayx dpnet dpnhpast dpwsockx

cd "$POL_USER_ROOT/ressources"
rm -rf Directx

POL_SetupWindow_detect_exit
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkhTTgAKCRDlMfrJqhPK
R/OMAKCDjgw76zLoYZpyzRleEkK31RN81wCeNCXQuuwuM7T8DR+SEate4HxL+Bs=
=Fp0+
-----END PGP SIGNATURE-----
