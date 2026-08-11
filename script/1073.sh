#!/bin/bash
# PlayOnLinux Function
# Date : (2012-02-25 21:00)
# Last revision : (2013-04-12 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install dotnet30 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v3.0/Microsoft .NET Framework 3.0/logo.bmp" ]; then
	POL_Call POL_Install_dotnet30
fi

# Setting OS check Fix
Set_OS "winxp" "sp3"
cat << EOF > "dotnet30sp1_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "dotnet30sp1_fix.reg"

cd "$POL_USER_ROOT/ressources/dotnet30"
# Downloading dotnet30sp1
POL_Download_Resource "http://download.microsoft.com/download/8/F/E/8FEEE89D-9E4F-4BA3-993E-0FFEA8E21E1B/NetFx30SP1_x86.exe" "bcef97b72a92a334acae8a6e4308e75c" "dotnet30"

# Setting Fix 1
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\Net Framework Setup\\NDP\\v3.0" /v Version /t REG_SZ /d "3.0" /f
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft-\\Net Framework Setup\\NDP\\v3.0" /v SP /t REG_DWORD /d 0001 /f
wineserver -k

# Setting Fix 2
POL_Download_Resource "http://download.microsoft.com/download/4/B/3/4B324900-E4A1-4BB0-9106-D796EB693FCD/RGB9RAST_x86.msi" "674353068d0290b0884b35b3b925dfe2" "dotnet30"
POL_Wine msiexec /i "RGB9RAST_x86.msi" /q
POL_Wine_WaitExit ".NET Framework 3.0 SP1 fix 1"
POL_Download_Resource "http://download.microsoft.com/download/8/D/4/8D4C4B2F-269B-44E1-80EA-BF59143D7BAC/XPSEPSC-x86-en-US.exe" "e171627735888dfa186dd9b2a538c3fd" "dotnet30"
POL_Wine "XPSEPSC-x86-en-US.exe" /quiet /passive /norestart
POL_Wine_WaitExit ".NET Framework 3.0 SP1 fix 2"
POL_Wine --ignore-errors sc delete "FontCache3.0.0.0"
if [ "$(POL_Config_PrefixRead VERSION)" = "1.5.6" ]; then
	WINEDLLOVERRIDES="ngen.exe,mscorsvw.exe=b"
	WINEDLLOVERRIDES="mscoree,fusion=n":$WINEDLLOVERRIDES
else
	WINEDLLOVERRIDES="ngen.exe,mscorsvw.exe=b"
fi
export WINEDLLOVERRIDES
wineserver -k

# Installing dotnet30sp1
POL_Wine_WaitBefore ".NET Framework 3.0 SP1 Update"
POL_Wine --ignore-errors NetFx30SP1_x86.exe /q /c:"install.exe /q"

# Restoring wine version
unset WINEDLLOVERRIDES
wineserver -k
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFp0IgACgkQ5TH6yaoTykel0QCfeCbzX4sFdLin8X5KrxfKbLrp
VVEAnj+1lg/XEhES70obZ4opjfdeYygr
=C333
-----END PGP SIGNATURE-----
