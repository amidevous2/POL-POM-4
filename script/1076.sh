#!/bin/bash
# PlayOnLinux Function
# Date : (2012-02-28 21:00)
# Last revision : (2013-04-12 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install dotnet11 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v1.1.4322/ndpsetup.ico" ]; then
	POL_Call POL_Install_dotnet11
fi

cd "$POL_USER_ROOT/ressources/dotnet11"
# Downloading dotnet11sp1
POL_Download_Resource "http://download.microsoft.com/download/8/b/4/8b4addd8-e957-4dea-bdb8-c4e00af5b94b/NDP1.1sp1-KB867460-X86.exe" "22e38a8a7d90c088064a0bbc882a69e5" "dotnet11"

# Setting OS check Fix
Set_OS "win2k"
cat << EOF > "dotnet11sp1_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"=""
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000000
EOF
POL_Wine regedit "dotnet11sp1_fix.reg"

# Setting Fix 1
WINEDLLOVERRIDES="regsvcs.exe=b"
WINEDLLOVERRIDES="fusion=n":$WINEDLLOVERRIDES
export WINEDLLOVERRIDES

# Installing dotnet11sp1
POL_Wine_WaitBefore ".NET Framework 1.1 SP1 Update"
POL_Wine --ignore-errors NDP1.1sp1-KB867460-X86.exe /q /c:"install.exe /q"

# Restoring wine version
unset WINEDLLOVERRIDES
wineserver -k
Set_OS "winxp" "sp3"
cat << EOF > "Default_OS_Version.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "Default_OS_Version.reg"

# Performing simulated wine reboot
POL_Wine_reboot
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFpzzkACgkQ5TH6yaoTykd7QwCfQJ4WsLFVAd5jSU4TqAFtgSp1
x28An2ONaN6h5UC8OGGLC6mGpjTnrha+
=15iO
-----END PGP SIGNATURE-----
