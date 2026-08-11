#!/bin/bash
# PlayOnLinux Function
# Date : (2010-03-12 04:29)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "https://web.archive.org/web/20180619044052if_/http://download.microsoft.com/download/E/E/1/EE17FF74-6C45-4575-9CF4-7FC2597ACD18/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

# Extracting DLL
cd "$POL_USER_ROOT/ressources"
mkdir -p quartz
cabextract -d quartz/ -L -F 'dxnt.cab' directx_feb2010_redist.exe || POL_Debug_Error "POL_Install_quartz : Failed te extract directx_feb2010_redist.exe"
cd quartz
cabextract dxnt.cab  -L -F 'quartz.dll' || POL_Debug_Error "POL_Install_quartz : Failed to extract dxnt.cab"

# Installing DLL
if [ "$POL_ARCH" == "amd64" ]; then
	cp "quartz.dll" "$WINEPREFIX/drive_c/windows/syswow64"
else
	cp "quartz.dll" "$WINEPREFIX/drive_c/windows/system32"
fi

# Overriding DLL
POL_Wine_OverrideDLL "native,builtin" "quartz"

POL_Wine regsvr32 quartz.dll
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYDvqvwAKCRDlMfrJqhPK
R3FUAKCp3UBl41rB9HAFIOEqluuL9c7HGQCgmGRvCJw3qxVRohLBDvg5p50uEZU=
=tmXv
-----END PGP SIGNATURE-----
