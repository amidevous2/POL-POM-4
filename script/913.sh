#!/bin/bash
# PlayOnLinux Function
# Date : (2010-02-08 21:00)
# Last revision : (2021-06-04 21:43)
# Author : Unknown - Updated by GNU_Raziel
# Only For : http://www.playonlinux.com

# Install dotnet40 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/System.EnterpriseServices.dll" ]; then
	POL_Call POL_Install_dotnet40
fi

cd "$POL_USER_ROOT/ressources/"
# Downloading XNA 4.0
POL_Download_Resource "https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi" "ff1c0202ab7147c9dfd34b582f1da13f"

# Installing XNA 4.0
POL_Wine msiexec /i "xnafx40_redist.msi" /quiet
POL_Wine_WaitExit "XNA 4.0"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLqmSAAKCRDlMfrJqhPK
R+rzAKCf7RrFDpZnWwMm0YNyc8M7Oa7NzQCfYLpJoa+BniNkwKJBky/Z/fc/1U8=
=Yjt/
-----END PGP SIGNATURE-----
