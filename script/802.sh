#!/bin/bash
# Date : (2010-09-18 21:00)
# Last revision : (2012-02-24 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com 

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Extracting & Installing Dx11 dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DirectX 11 dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Message "Extracting x86 and x64 dlls"
	mkdir "directx11_x64"
	cabextract -d directx11_x64/ -L -F '*d3dx11*x64*' directx_Jun2010_redist.exe

	for x in `ls directx11_x64/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
	mkdir "directx11_x86"
	cabextract -d directx11_x86/ -L -F '*d3dx11*x86*' directx_Jun2010_redist.exe

	for x in `ls directx11_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F '*.dll' "$x"
	done
else
	POL_Debug_Message "Extracting only x86 dlls"
	mkdir "directx11_x86"
	cabextract -d directx11_x86/ -L -F '*d3dx11*x86*' directx_Jun2010_redist.exe

	for x in `ls directx11_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
fi

# Overriding dlls
POL_Debug_Message "Overriding all d3dx11 dlls"
POL_Wine_OverrideDLL "native, builtin" "d3dx11_42" "d3dx11_43"

# Cleaning
POL_Debug_Message "Deleting temporary directories"
rm -rf "$POL_USER_ROOT/ressources/directx11_x86"
if [ "$POL_ARCH" == "amd64" ]; then
	rm -rf "$POL_USER_ROOT/ressources/directx11_x64"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCY595HQAKCRDlMfrJqhPK
R+HyAJ4tPBTR7FHAaY+b+vh75FEXCKz7CACfXzY8JitO/B/VzzHjRWSF/MGF54M=
=Y94D
-----END PGP SIGNATURE-----
