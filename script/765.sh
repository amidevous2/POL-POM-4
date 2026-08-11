#!/bin/bash
# Last revision : (2013-06-20 21:00)
# Creator : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://download.microsoft.com/download/E/E/1/EE17FF74-6C45-4575-9CF4-7FC2597ACD18/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

# Extracting DLL
cd "$POL_USER_ROOT/ressources"
mkdir -p devenum
cabextract -d devenum/ -L -F 'dxnt.cab' directx_feb2010_redist.exe || POL_Debug_Error "POL_Install_devenum : Failed te extract directx_feb2010_redist.exe"
cd devenum
cabextract dxnt.cab  -L -F 'devenum.dll' || POL_Debug_Error "POL_Install_devenum : Failed to extract dxnt.cab"

# Installing DLL
if [ "$POL_ARCH" == "amd64" ]; then
	cp "devenum.dll" "$WINEPREFIX/drive_c/windows/syswow64"
else
	cp "devenum.dll" "$WINEPREFIX/drive_c/windows/system32"
fi

# Overriding DLL
POL_Wine_OverrideDLL "native,builtin" "devenum"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHElWAACgkQ5TH6yaoTykc9AwCfYidULIuAW+lN93RL7QvVAOHb
66oAoKTHAAwZ3y6pGD3Q4yzFtL6mRe/0
=3xNw
-----END PGP SIGNATURE-----
