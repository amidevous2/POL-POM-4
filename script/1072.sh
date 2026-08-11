#!/bin/bash
# PlayOnLinux Function
# Date : (2012-02-25 21:00)
# Last revision : (2013-04-12 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Check wine version before install
if VersionLower $(POL_Config_PrefixRead VERSION) 1.3.19; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work with wine 1.3.18 or lower')"
fi

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install dotnet20sp1 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/assembly/NativeImages_v2.0.50727_32/indexb.dat" ]; then
	POL_Call POL_Install_dotnet20sp1
fi

# Downloading dotnet20sp2
cd "$POL_USER_ROOT/ressources/dotnet20"
POL_Download_Resource "http://download.microsoft.com/download/c/6/e/c6e88215-0178-4c6c-b5f3-158ff77b1f38/NetFx20SP2_x86.exe" "c64fd1f972822ed84378c7058fea0744" "dotnet20"

# Setting OS check Fix
Set_OS "win2k" "sp4"
cat << EOF > "dotnet20sp2_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"="Service Pack 4"
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000400
EOF
POL_Wine regedit "dotnet20sp2_fix.reg"

# Setting Fix 1
WINEDLLOVERRIDES="regsvcs.exe,mscorsvw.exe=b"
export WINEDLLOVERRIDES
wineserver -k
POL_Wine --ignore-errors reg add "HKLM\\Software\Microsoft\\Net Framework Setup\\NDP\\v2.0.50727" /v Version /d "2.0.50727" /f

# Installing dotnet20sp2
POL_Wine_WaitBefore ".NET Framework 2.0 SP2 Update"
POL_Wine --ignore-errors NetFx20SP2_x86.exe /q /c:"install.exe /q"

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
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFpz/8ACgkQ5TH6yaoTykd/jQCfZvX5qMOp/C33jD2F0QAXOf1q
nmAAnRKCKwVYSOkU3Ed6SsHYTFNw0xUA
=CyU5
-----END PGP SIGNATURE-----
