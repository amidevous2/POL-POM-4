#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-28 09-16)
# Last revision : see changelog
# Author : SuperPlumus
#
# CHANGELOG
# [SuperPlumus] (2010-11-28 09-16)
#   Initial script ?.
# [SuperPlumus] (2012-04-10 12-18)
#   ?
# [Dadu042] (2020-06-02 19-00)
#   Update URL because Microsoft removed their file...
 
POL_Call POL_Install_wsh57
 
cd "$POL_USER_ROOT/ressources"

# Dead URL as of 2020-11
# POL_Download_Resource "http://download.microsoft.com/download/1/2/A/12A31F29-2FA9-4F50-B95D-E45EF7013F87/MP10Setup.exe" "e57645c5ab34485d56d019aaa17c3150"

POL_Download_Resource "https://archive.org/download/mp10setup_201907/MP10Setup.exe" "e57645c5ab34485d56d019aaa17c3150"
POL_Download_Resource "http://download.microsoft.com/download/5/c/2/5c29d825-61eb-4b16-8eb8-58367d0464d5/WM9Codecs9x.exe" "6560a06288752e36a5ccda0b9d115e31"
 
POL_Wine_WaitBefore "Windows Media Player 10" 
POL_Wine "MP10Setup.exe" /q
 
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdr4_2K"
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdralw2k"
 
Set_OS "win2k"
 
POL_Wine "WM9Codecs9x.exe" /q
 
Set_OS "winxp"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX7zS2wAKCRDlMfrJqhPK
R5IFAJ9ne2kDu79ujdnF/5UWhMzdYkJDhQCeKzzCs00syuJTtYMWK/5oNJke3wU=
=LbFj
-----END PGP SIGNATURE-----
