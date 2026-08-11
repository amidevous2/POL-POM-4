#!/bin/bash
# Date : (2011-02-22 21:00)
# Last revision : (2012-05-17 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com 

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Installing DirectX
cd "$POL_USER_ROOT/ressources"
POL_SetupWindow_wait "$(eval_gettext 'Installing DirectX runtime')" "$TITLE"

mkdir "dxfullsetup"
cabextract -d dxfullsetup/ -L -F '*' directx_Jun2010_redist.exe

POL_Wine start /unix "dxfullsetup/dxsetup.exe" /silent
POL_Wine_WaitExit "DirectX runtime"

# Overriding dlls
POL_Debug_Message "Overriding all DirectX dlls"
POL_Wine_OverrideDLL "native, builtin" "d3dx9_24" "d3dx9_25" "d3dx9_26" "d3dx9_27" "d3dx9_28" "d3dx9_29" "d3dx9_30" "d3dx9_31" "d3dx9_32" "d3dx9_33" "d3dx9_34" "d3dx9_35" "d3dx9_36" "d3dx9_37" "d3dx9_38" "d3dx9_39" "d3dx9_40" "d3dx9_41" "d3dx9_42" "d3dx9_43" "d3dx10_33" "d3dx10_34" "d3dx10_35" "d3dx10_36" "d3dx10_37" "d3dx10_38" "d3dx10_39" "d3dx10_40" "d3dx10_41" "d3dx10_42" "d3dx10_43" "d3dx11_42" "d3dx11_43" "xinput1_1" "xinput1_2" "xinput1_3" "xinput9_1_0" "d3dcompiler_33" "d3dcompiler_34" "d3dcompiler_35" "d3dcompiler_36" "d3dcompiler_37" "d3dcompiler_38" "d3dcompiler_39" "d3dcompiler_40" "d3dcompiler_41" "d3dcompiler_42" "d3dcompiler_43"

# Registering XACT
POL_Debug_Message "Registering XACT & Xaudio dlls"
POL_SetupWindow_wait "$(eval_gettext 'Registering libraries, please wait\n(It can take a while)')" "$TITLE"
for x in `ls "$WINEPREFIX"/drive_c/windows/system32/xactengine* "$WINEPREFIX"/drive_c/windows/system32/XAudio*`
do
	POL_Wine regsvr32 `basename $x`
done

# Cleaning
rm -rf "dxfullsetup"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYGxOtAAKCRDlMfrJqhPK
R1wqAJ9/IiAgvFMt0pj1PH3rZgaFXkJEVwCgkLn8PDak/RWL+AOIwDgLU/YyziY=
=yN44
-----END PGP SIGNATURE-----
