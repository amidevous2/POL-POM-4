#!/bin/bash
# PlayOnLinux Function
# Date : (2012-02-25 21:00)
# Last revision : (2013-04-12 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Check wine version before install
if VersionLower $(POL_Config_PrefixRead VERSION) 1.3.23; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work with wine 1.3.22 or lower')"
fi

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install dotnet20 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v2.0.50727/mscorlib.dll" ]; then
	POL_Call POL_Install_dotnet20
fi

# Downloading dotnet20sp1
cd "$POL_USER_ROOT/ressources/dotnet20"
POL_Download_Resource "http://download.microsoft.com/download/0/8/c/08c19fa4-4c4f-4ffb-9d6c-150906578c9e/NetFx20SP1_x86.exe" "c61111d7d62306b997ce7dd04898b1ca" "dotnet20"

# Setting OS check Fix
Set_OS "win2k" "sp4"
cat << EOF > "dotnet20sp1_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"="Service Pack 4"
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000400
EOF
POL_Wine regedit "dotnet20sp1_fix.reg"

# Setting Fix 1
WINEDLLOVERRIDES="ngen.exe,regsvcs.exe,mscorsvw.exe=b"
export WINEDLLOVERRIDES
wineserver -k
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v2.0.50727" /v Version /t REG_SZ /d "2.0.50727" /f

# Installing dotnet20sp1
POL_Wine_WaitBefore ".NET Framework 2.0 SP1 Update"
POL_Wine --ignore-errors NetFx20SP1_x86.exe /q /c:"install.exe /q"

# Setting Fix 2
rm -f "$WINEPREFIX/drive_c/windows/system32/msvc?80.dll"

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

iEYEABECAAYFAlFpz80ACgkQ5TH6yaoTykftswCcCjZcKkHWZeSQ58bxXxMeKqZj
8/4AoKLUpUitv38QwUiid4xHLKs/tDE4
=QU3y
-----END PGP SIGNATURE-----
