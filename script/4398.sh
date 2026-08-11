#!/bin/bash
# Date : (2021-08-02 02-59)
# Last revision : (2021-08-02 03-02)
# Creator: Yaotl
# based on:
#  https://www.playonlinux.com/en/app-4278-POL_Install_DXVK_173.html
#  https://www.playonlinux.com/en/app-912-POL_Install_mfc42.html
#  https://www.playonlinux.com/es/app-2194-POL_GetTool_samba3.html
#  POL_Install_d3dx9_43 by Petch
#  POL_Install_d3dx9 by Berillions/GNU_Raziel
# Only For : http://www.playonlinux.com

# How to adapt this script for a newer version:
# #1 in a text editor, do search for '1.7.3' (example) replace it to '1.7.4' (example).
# #2 download the file manually, then make its checksum (linux: 'md5sum filename'), replace it at the end of 'POL_Download_Resource'.


POL_SetupWindow_message "Warning: DXVK software can not work without Vulkan driver (on your OS), we can not automate this." "$TITLE"

DXVK_VERSION="1.9.1"

# Downloading DXVK files
POL_Download_Resource "https://github.com/doitsujin/dxvk/releases/download/v$DXVK_VERSION/dxvk-$DXVK_VERSION.tar.gz" "09058abcd44d72a7555fac0a2254351a"

# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DXVK files...')" "$TITLE"

cd "$WINEPREFIX/drive_c/windows/temp"

tar -xvzf "$POL_USER_ROOT/ressources/dxvk-$DXVK_VERSION.tar.gz"

if [ "$POL_ARCH" == "amd64" ]; then
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d9.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10core.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d11.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/dxgi.dll" "$WINEPREFIX/drive_c/windows/syswow64"
 
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/d3d9.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/d3d10.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/d3d10core.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/d3d11.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x64/dxgi.dll" "$WINEPREFIX/drive_c/windows/system32"
else
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d9.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d10core.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/d3d11.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/dxvk-$DXVK_VERSION/x32/dxgi.dll" "$WINEPREFIX/drive_c/windows/system32"
fi

# Overriding dlls
POL_Debug_Message "Overriding DirectX 9, 10, 11 DLLs"

POL_Call POL_Function_OverrideDLL "native" "d3d9"
POL_Call POL_Function_OverrideDLL "native" "d3d10"
POL_Call POL_Function_OverrideDLL "native" "d3d10_1"
POL_Call POL_Function_OverrideDLL "native" "d3d10core"
POL_Call POL_Function_OverrideDLL "native" "d3d11"
POL_Call POL_Function_OverrideDLL "native" "dxgi"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYQfO7QAKCRDlMfrJqhPK
R1RjAKCQ28YnBhoUQjC1CRGvoZdlI0efEQCeNaobjlppBFx8PDIr15q0GcnaK74=
=saXF
-----END PGP SIGNATURE-----
