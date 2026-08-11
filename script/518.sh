#!/bin/bash
# PlayOnLinux Function
# Date : (2009-10-31 17:55)
# Last revision : (2012-02-28 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2009-10-31)
#   First script.
# [Dadu042] (2019-09-10)
#   Fix dead URL (I could not find a URL hosted on Microsoft.com).
# [Dadu042] (2019-09-11)
#   Fix URL (* character into).
# [jack1142] (2022-01-15)
#   Fix URL (also a web.archive.org link but captured at different time)

cd "$POL_USER_ROOT/ressources/"
# Downloading GDIplus

# URL dead as of 2019-09-10
# POL_Download_Resource "http://download.microsoft.com/download/a/b/c/abc45517-97a0-4cee-a362-1957be2f24e1/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd"

# URL dead as of 2019-09-10
# POL_Download_Resource "https://web.archive.org/web/20150602122012/http://download.microsoft.com/download/a/b/c/abc45517-97a0-4cee-a362-1957be2f24e1/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd"
POL_Download_Resource "https://web.archive.org/web/20160222065646/http://download.microsoft.com/download/a/b/c/abc45517-97a0-4cee-a362-1957be2f24e1/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd"
 
# Installing GDIplus
POL_Wine WindowsXP-KB975337-x86-ENU.exe /extract:C:\\Tmp /q
cd "$WINEPREFIX/drive_c/Tmp"
 
if [ "$POL_ARCH" == "amd64" ]; then
        mv "$WINEPREFIX/drive_c/Tmp/asms/10/msft/windows/gdiplus/gdiplus.dll" "$WINEPREFIX/drive_c/windows/syswow64"
else
        mv "$WINEPREFIX/drive_c/Tmp/asms/10/msft/windows/gdiplus/gdiplus.dll" "$WINEPREFIX/drive_c/windows/system32"
fi
 
# Overriding dlls
POL_Wine_OverrideDLL "native" "gdiplus"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZ8xPYgAKCRDlMfrJqhPK
RxA4AKCSnJXceMwXqNZi9+832FfLg8Jl7ACcDHiUyqKFkdzQBHZL1zjKnzF8pug=
=kAwF
-----END PGP SIGNATURE-----
