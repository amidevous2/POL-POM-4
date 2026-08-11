#!/bin/bash
# PlayOnLinux Function
# Date : (2010-12-18 21:00)
# Last revision : (2021-06-04 22:29)
# Author : Unknown - Updated by GNU_Raziel
# Only For : http://www.playonlinux.com

# Install dotnet20 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v2.0.50727/mscorlib.dll" ]; then
	POL_Call POL_Install_dotnet20
fi

cd "$POL_USER_ROOT/ressources"
# Downloading XNA 3.1
POL_Download_Resource "https://download.microsoft.com/download/5/9/1/5912526C-B950-4662-99B6-119A83E60E5C/xnafx31_redist.msi" "6920657429e3cd8faaf472844eb5694b"

# Installing XNA 3.1
POL_Wine msiexec /i "xnafx31_redist.msi" /quiet
POL_Wine_WaitExit "XNA 3.1"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLqmQAAKCRDlMfrJqhPK
R/4BAJ9BN0JLKQJ8ptedmw3eHIuKk1p0KACbBydaOpdOdM96ug0zvph+y2AsSwU=
=JB/w
-----END PGP SIGNATURE-----
