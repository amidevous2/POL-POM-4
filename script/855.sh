#!/bin/bash

# PlayOnLinux Function
# Date : (2011-07-07 19-28)
# Last revision : (2012-04-09 20-37)
# Author : SuperPlumus
 
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"
 
POL_Wine_WaitBefore "DirectX 9"

Set_OS "winxp"

WINEDLLOVERRIDES="wintrust=b,mscoree=,ddraw,d3d8,d3d9,dsound,dinput=n" POL_Wine "directx_Jun2010_redist.exe" /t:"C:\\windows\\temp\\directx9" /q
 
POL_Wine_OverrideDLL "native" "d3dim" "d3drm" "d3dx8" "d3dx9_24" "d3dx9_25" "d3dx9_26" "d3dx9_27" "d3dx9_28" "d3dx9_29" "d3dx9_30" "d3dx9_31" "d3dx9_32" "d3dx9_33" "d3dx9_34" "d3dx9_35" "d3dx9_36" "d3dx9_37" "d3dx9_38" "d3dx9_39" "d3dx9_40" "d3dx9_41" "d3dx9_42" "d3dx9_43" "d3dxof" "dciman32" "ddrawex" "devenum" "dmband" "dmcompos" "dmime" "dmloader" "dmscript" "dmstyle" "dmsynth" "dmusic" "dmusic32" "dnsapi" "dplay" "dplayx" "dpnaddr" "dpnet" "dpnhpast" "dpnlobby" "dswave" "dxdiagn" "msdmo" "qcap" "quartz" "streamci" "dxdiag"
POL_Wine_OverrideDLL "builtin" "d3d8" "d3d9" "dinput" "dinput8" "dsound"
 
POL_Wine "C:\\windows\\temp\\directx9\\DXSETUP.exe" /silent

POL_Wine_WaitExit "DirectX 9"

rm -rf "$WINEPREFIX/drive_c/windows/temp/directx9"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCY0vjOAAKCRDlMfrJqhPK
Rwy3AKCmhbcc1Gvan948Melxpql/waMs6ACgrpDt5ZKXszHxIto6+MRlq/P+mbA=
=Q8iU
-----END PGP SIGNATURE-----
