#!/bin/bash
# Last revision : (2021-05-26 13:30)
# Creator : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Extracting & Installing Dx10 dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DirectX 10 dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Message "Extracting x86 and x64 dlls"
	mkdir "directx10_x64"
	cabextract -d directx10_x64/ -L -F '*d3dx10*x64*' directx_Jun2010_redist.exe

	for x in `ls directx10_x64/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
	mkdir "directx10_x86"
	cabextract -d directx10_x86/ -L -F '*d3dx10*x86*' directx_Jun2010_redist.exe

	for x in `ls directx10_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F '*.dll' "$x"
	done
else
	POL_Debug_Message "Extracting only x86 dlls"
	mkdir "directx10_x86"
	cabextract -d directx10_x86/ -L -F '*d3dx10*x86*' directx_Jun2010_redist.exe

	for x in `ls directx10_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
fi

# Overriding dlls
POL_Debug_Message "Overriding all d3dx10 dlls"
POL_Wine_OverrideDLL "native, builtin" "d3dx10_33" "d3dx10_34" "d3dx10_35" "d3dx10_36" "d3dx10_37" "d3dx10_38" "d3dx10_39" "d3dx10_40" "d3dx10_41" "d3dx10_42" "d3dx10_43"

# Cleaning
POL_Debug_Message "Deleting temporary directories"
rm -rf "$POL_USER_ROOT/ressources/directx10_x86"
if [ "$POL_ARCH" == "amd64" ]; then
	rm -rf "$POL_USER_ROOT/ressources/directx10_x64"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLXmbAAKCRDlMfrJqhPK
R6b7AJ9M2Gsj9YpwWFdXFJ4fZ+HQvHt5ZwCgrUKOYFvvQlnyDDQ7UW1cGBSsRr8=
=UcCg
-----END PGP SIGNATURE-----
