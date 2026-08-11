#!/bin/bash
# Last revision : (2012-11-29 20:56)
# Creator: petch
#  based on POL_Install_d3dx9 by Berillions/GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Extracting & Installing Dx9 dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DirectX 9 dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

install_dx_dlls () {
    local CABPATTERN="$1"
    local TARGET="$2"
    local PATTERN="$3"
    local TMPDLL="$POL_USER_ROOT/tmp/Install_d3dx9"

    mkdir "$TMPDLL"
    cabextract -d "$TMPDLL/" -L -F "$CABPATTERN" directx_Jun2010_redist.exe
    
    for x in "$TMPDLL/"*.cab; do
        cabextract -d "$TARGET/" -L -F "$PATTERN" "$x"
    done
    rm -rf "$TMPDLL"
}

if [ "$POL_ARCH" = "amd64" ]; then
	POL_Debug_Message "Extracting x86 and x64 dlls"
        install_dx_dlls '*d3dx9*43_x64.cab' "$WINEPREFIX/drive_c/windows/system32" 'd3dx9_43.dll'
        install_dx_dlls '*d3dx9*43_x86.cab' "$WINEPREFIX/drive_c/windows/syswow64" 'd3dx9_43.dll'
else
	POL_Debug_Message "Extracting only x86 dll"
        install_dx_dlls '*d3dx9*43_x86.cab' "$WINEPREFIX/drive_c/windows/system32" 'd3dx9_43.dll'
fi

# Overriding dlls
POL_Debug_Message "Overriding d3dx9_43 dll"
POL_Wine_OverrideDLL "native, builtin" "d3dx9_43"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYKI7uQAKCRDlMfrJqhPK
RzasAJ4p1Ji3Pc/QH80CmfUDlEeV1x29BACgj2w+Ek2RXn9OIUgPra2FPfZzY2I=
=tl/z
-----END PGP SIGNATURE-----
