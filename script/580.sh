#!/bin/bash
# Date : (2010-09-01 22:00)
# Last revision : (2012-02-28 21:00)
# Author : Unknown
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" = "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install WMP9 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/system32/l3codeca.acm" ]; then
	POL_Call POL_Install_wmp9
fi

# Setting OS check Fix
Set_OS "win2k"
cat << EOF > "WMP9_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"=""
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000000
EOF
POL_Wine regedit "WMP9_fix.reg"

# Downloading WMP codecs
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://birds.camden.rutgers.edu/WM9Codecs9x.exe" "6560a06288752e36a5ccda0b9d115e31"

# Downloading WMP codecs2
#POL_Download_Resource "http://download.microsoft.com/download/8/1/f/81f9402f-efdd-439d-b2a4-089563199d47/WMEncoder.exe" "88a5d68d1b66fe736a2e8cb9ff3a39d2"
POL_Download_Resource "https://web.archive.org/web/20121003223319/http://download.microsoft.com/download/8/1/f/81f9402f-efdd-439d-b2a4-089563199d47/WMEncoder.exe" "88a5d68d1b66fe736a2e8cb9ff3a39d2"

# Begin installation
POL_Wine start /unix "WM9Codecs9x.exe" /q
POL_Wine_WaitExit "WM9 Codec 1"
POL_Wine start /unix "WMEncoder.exe" /q
POL_Wine_WaitExit "WM9 Codec 2"

# Cleaning
wineserver -k
Set_OS "winxp" "sp3"
cat << EOF > "Cleaning.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "Cleaning.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAly42agACgkQ5TH6yaoTyked1QCfdwZrWNt2yZ8BD6jiknc23Go/
5l0AnAqeDTi+zvOAmAxD9Voyn846XyzY
=FUyP
-----END PGP SIGNATURE-----
