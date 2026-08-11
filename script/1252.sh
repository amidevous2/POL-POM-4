#!/bin/bash
# PlayOnLinux Function
# Date : (2012-06-10 21-00)
# Last revision : N/A
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Setting default path for installers
POL_LoadVar_PROGRAMFILES

# Downloading "Rockstar Social Club" setup
POL_Download_Resource "http://files.playonlinux.com/Rockstar_Social_Club_v1.0.9.5.exe" "dac572e52a23abbc74f3f1a3420bdff3"

# Installing mandatory dependencies
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dotnet20sp2

# Installing Steam
cd "$POL_USER_ROOT/ressources/"
POL_Wine Rockstar_Social_Club_v1.0.9.5.exe /silent
POL_Wine_WaitExit "Rockstar Social Club"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/U4qQACgkQ5TH6yaoTykchZgCgjCNDKAJ8l2lzihS3q+fTGQ1M
/6gAoLB5np79D5h2lMNjA6KibxDYrNGU
=nkZ3
-----END PGP SIGNATURE-----
