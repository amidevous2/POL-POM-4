#!/bin/bash
# Last revision : (2012-02-24 21:00)
# Creator : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Extracting & Installing Dx9 dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DirectX 9 dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Message "Extracting x86 and x64 dlls"
	mkdir "directx9_x64"
	cabextract -d directx9_x64/ -L -F '*d3dx9*x64*' directx_Jun2010_redist.exe

	for x in `ls directx9_x64/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
	mkdir "directx9_x86"
	cabextract -d directx9_x86/ -L -F '*d3dx9*x86*' directx_Jun2010_redist.exe

	for x in `ls directx9_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F '*.dll' "$x"
	done
else
	POL_Debug_Message "Extracting only x86 dlls"
	mkdir "directx9_x86"
	cabextract -d directx9_x86/ -L -F '*d3dx9*x86*' directx_Jun2010_redist.exe

	for x in `ls directx9_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
fi

# Overriding dlls
POL_Debug_Message "Overriding all d3dx9 dlls"
POL_Wine_OverrideDLL "native, builtin" "d3dx9_24" "d3dx9_25" "d3dx9_26" "d3dx9_27" "d3dx9_28" "d3dx9_29" "d3dx9_30" "d3dx9_31" "d3dx9_32" "d3dx9_33" "d3dx9_34" "d3dx9_35" "d3dx9_36" "d3dx9_37" "d3dx9_38" "d3dx9_39" "d3dx9_40" "d3dx9_41" "d3dx9_42" "d3dx9_43"

# Cleaning
POL_Debug_Message "Deleting temporary directories"
rm -rf "$POL_USER_ROOT/ressources/directx9_x86"
if [ "$POL_ARCH" == "amd64" ]; then
	rm -rf "$POL_USER_ROOT/ressources/directx9_x64"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYElC2QAKCRDlMfrJqhPK
R6urAJ434eKKRhNdVAZcPGdxrnJggqQsLgCgioYrtm0hfG3lpQgFBj+PypfIJjM=
=PTED
-----END PGP SIGNATURE-----
