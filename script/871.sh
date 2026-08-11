#!/bin/bash
# Date : (2011-07-16 21:00)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://download.microsoft.com/download/E/E/1/EE17FF74-6C45-4575-9CF4-7FC2597ACD18/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

# Extracting DLL
cd "$POL_USER_ROOT/ressources"
mkdir -p dsound
cabextract -d dsound/ -L -F 'dxnt.cab' directx_feb2010_redist.exe || POL_Debug_Error "POL_Install_dsound : Failed te extract directx_feb2010_redist.exe"
cd dsound
cabextract dxnt.cab  -L -F 'dsound.dll' || POL_Debug_Error "POL_Install_dsound : Failed to extract dxnt.cab"

# Installing DLL
if [ "$POL_ARCH" == "amd64" ]; then
	cp "dsound.dll" "$WINEPREFIX/drive_c/windows/syswow64"
else
	cp "dsound.dll" "$WINEPREFIX/drive_c/windows/system32"
fi

# Registering dll
POL_Wine regsvr32 dsound.dll

# Overriding DLL
POL_Wine_OverrideDLL "native,builtin" "dsound"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDf1QACgkQ5TH6yaoTykc3JQCff0GI45K7nbrD/ZGHw+Lp0grE
ef8AoLAgDnGWfI3o0t2pa3jXdwuuaoKA
=NOkT
-----END PGP SIGNATURE-----
