#!/bin/bash
# PlayOnLinux Function
 
# Date : (2009-11-21)
# Author : Berillions
# Licence : 
# Depend : none

POL_Download_Resource "http://download.microsoft.com/download/vc60pro/Update/2/W9XNT4/EN-US/VC6RedistSetup_deu.exe" "53a0925609b366daa17051e1e4be3b86"


if [ "$POL_ARCH" = "amd64" ]; then
    rm -rf "$WINEPREFIX/drive_c/windows/syswow64/comcat.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/syswow64/msvcrt.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/syswow64/oleaut32.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/syswow64/olepro32.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/syswow64/stdole2.tlb"
else
    rm -rf "$WINEPREFIX/drive_c/windows/system32/comcat.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/system32/msvcrt.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/system32/oleaut32.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/system32/olepro32.dll"
    rm -rf "$WINEPREFIX/drive_c/windows/system32/stdole2.tlb"
fi

#Install vcrun6
cd "$POL_USER_ROOT/tmp/"
cabextract "$POL_USER_ROOT/ressources/VC6RedistSetup_deu.exe"
POL_Wine --ignore-errors "vcredist.exe"
case "$?" in
    0|43) ;;
    *) POL_Debug_Error "Failed installing VC6 runtime"
esac
POL_Call POL_Install_mfc42
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxgBgAKCRDlMfrJqhPK
R4pEAJ0QpM4wa9VwSiP6vOC/Uy1f/muP+gCeL/OeY+prOvTT+4cr7cCN7TpUCcw=
=50sw
-----END PGP SIGNATURE-----
