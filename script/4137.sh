#!/bin/bash
# Last revision : (2021-06-15 22:22)
# Creator: Dadu042 & Yaotl
# Inspired by Winetricks d3dcompiler_47 https://github.com/Winetricks/winetricks
# Script licence : GNU Lesser General Public License 2.1 https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt

POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing d3dcompiler_47 dlls...')" "$TITLE"
if [ -f "$POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32" ]; then
    if [ "$POL_ARCH" = "amd64" ]; then
        cp -f $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32 $WINEPREFIX/drive_c/windows/syswow64/d3dcompiler_47.dll
    else
        cp -f $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32 $WINEPREFIX/drive_c/windows/system32/d3dcompiler_47.dll
    fi
else
    POL_Download_Resource "https://ftp.mozilla.org/pub/firefox/releases/78.11.0esr/win32/en-US/Firefox Setup 78.11.0esr.exe" "b72333db7a247ecd9df0189d79f2ed7f" "d3dcompiler_47/win32"
    7z x "Firefox Setup 78.11.0esr.exe" "core/d3dcompiler_47.dll"
    cp -f core/d3dcompiler_47.dll $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32
    if [ "$POL_ARCH" = "amd64" ]; then
        cp -f $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32 $WINEPREFIX/drive_c/windows/syswow64/d3dcompiler_47.dll
    else
        cp -f $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win32 $WINEPREFIX/drive_c/windows/system32/d3dcompiler_47.dll
    fi
    rm -rf $POL_USER_ROOT/ressources/d3dcompiler_47/win32
fi
if [ "$POL_ARCH" = "amd64" ]; then
    if [ -f "$POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win64" ]; then
        cp -f $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win64 $WINEPREFIX/drive_c/windows/system32/d3dcompiler_47.dll
    else
        POL_Download_Resource "https://ftp.mozilla.org/pub/firefox/releases/78.11.0esr/win64/en-US/Firefox Setup 78.11.0esr.exe" "6ad08322fa49ee1a2a4e12c6d77e5388" "d3dcompiler_47/win64"
        7z x "Firefox Setup 78.11.0esr.exe" "core/d3dcompiler_47.dll"
        cp -f core/d3dcompiler_47.dll $POL_USER_ROOT/ressources/d3dcompiler_47/d3dcompiler_47.win64
        mv -f core/d3dcompiler_47.dll $WINEPREFIX/drive_c/windows/system32/d3dcompiler_47.dll
    fi
    rm -rf $POL_USER_ROOT/ressources/d3dcompiler_47/win64
fi

POL_Debug_Message "Overriding d3dcompiler_47 dll"
POL_Wine_OverrideDLL "native, builtin" "d3dcompiler_47"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMl+YgAKCRDlMfrJqhPK
R9DBAJ9/a7qzXPfoHabAoym4t8Ke8c2e/gCcDb3ONRxa3h9j0KJSU+72hSqRb8M=
=ofXx
-----END PGP SIGNATURE-----
