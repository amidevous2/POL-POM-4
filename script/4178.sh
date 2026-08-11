#!/bin/bash
# Last revision : (2020-08-15)
# Creator: Dadu042
# based on:
#  https://www.playonlinux.com/en/app-912-POL_Install_mfc42.html
#  https://www.playonlinux.com/es/app-2194-POL_GetTool_samba3.html
#  POL_Install_d3dx9_43 by Petch
#  POL_Install_d3dx9 by Berillions/GNU_Raziel
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [Dadu042] (2020-06-26 17-00)
#   Initial script.
# [Yaolt] (2020-06-29 15-00)
#   Fix folders inversion when in amd64 mode.
 
    
DXVK_VERSION="dxvk-1.7.1"
    
# Downloading DXVK files
POL_Download_Resource "https://github.com/doitsujin/dxvk/releases/download/v1.7.1/$DXVK_VERSION.tar.gz" "d12be05240cbd1529147bc6b67e557e8"
     
# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing DXVK files...')" "$TITLE"
    
cd "$WINEPREFIX"/drive_c/windows/temp
    
# tar -xvzf dxvk-1.7.tar.gz -C "$TARGET"
tar -xvzf "$POL_USER_ROOT"/ressources/$DXVK_VERSION.tar.gz
    
    
if [ "$POL_ARCH" == "amd64" ]; then
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d9.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10core.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d11.dll" "$WINEPREFIX/drive_c/windows/syswow64"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/dxgi.dll" "$WINEPREFIX/drive_c/windows/syswow64"
  
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/d3d9.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/d3d10.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/d3d10core.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/d3d11.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x64/dxgi.dll" "$WINEPREFIX/drive_c/windows/system32"
else
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d9.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10_1.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d10core.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/d3d11.dll" "$WINEPREFIX/drive_c/windows/system32"
        cp -f "$WINEPREFIX/drive_c/windows/temp/$DXVK_VERSION/x32/dxgi.dll" "$WINEPREFIX/drive_c/windows/system32"
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzfjOgAKCRDlMfrJqhPK
R0afAKCoTKIR0OlPXvMjRCxjeD5q0kivxACeNPdfxhWBTOvMMfvbNWMnSd0/vyQ=
=LVQf
-----END PGP SIGNATURE-----
