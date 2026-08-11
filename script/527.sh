#!/bin/bash
# PlayOnLinux Function
# Date : (2009-11-21 21:00)
# Last revision : (2013-04-12 21:00)
# Author : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Remove wine-mono if present
POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true

# Setting OS check Fix
Set_OS "win2k"
cat << EOF > "dotnet11_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"=""
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000000
EOF
POL_Wine regedit "dotnet11_fix.reg"

mkdir "$POL_USER_ROOT/ressources/dotnet11"
cd "$POL_USER_ROOT/ressources/dotnet11"

# Downloading dotnet11
POL_Download_Resource "http://download.microsoft.com/download/a/a/c/aac39226-8825-44ce-90e3-bf8203e74006/dotnetfx.exe" "52456ac39bbb4640930d155c15160556" "dotnet11"

# Setting Fix 1
rm -rf "$WINEPREFIX"/Microsoft.NET/Framework/v1.1.4322/
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\.NETFramework\policy\v2.0" /f
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\.NETFramework" /v InstallRoot /f
POL_Wine_InstallFonts

# Setting Fix 2
WINEDLLOVERRIDES="regsvcs.exe=b"
WINEDLLOVERRIDES="fusion=n":$WINEDLLOVERRIDES
export WINEDLLOVERRIDES

# Installing dotnet11
POL_Wine_WaitBefore ".NET Framework 1.1"
POL_Wine --ignore-errors dotnetfx.exe /q /c:"install.exe /q"

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

iEYEABECAAYFAlFpzvoACgkQ5TH6yaoTyke2ogCgngC0p4MHS9G/iaXR/yyF302d
AT0AnROO1u3ZfZ2r5Gocuxl+l/Z3OCyb
=7afI
-----END PGP SIGNATURE-----
