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
cat << EOF > "dotnet20_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"=""
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000000
EOF
POL_Wine regedit "dotnet20_fix.reg"

mkdir "$POL_USER_ROOT/ressources/dotnet20"
cd "$POL_USER_ROOT/ressources/dotnet20"

# Downloading dotnet20 pre-install fix
POL_Download_Resource "http://files.playonlinux.com/l_intl.nls" "3f138c7677ede64e8ad41e3277c86e9e" "dotnet20"

# Downloading dotnet20
POL_Download_Resource "http://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkvantage_en/dotnetfx.exe" "93a13358898a54643adbca67d1533462" "dotnet20"

# Setting Fix 1
cp -f "l_intl.nls" "$WINEPREFIX/drive_c/windows/system32"
rm -rf "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v2.0.50727"
POL_Wine_InstallFonts

# Fix Fatal install error in wine 1.5.3 to 1.5.6 and wine current stable branch
if VersionLower $(POL_Config_PrefixRead VERSION) 1.5.7 && ! (VersionLower $(POL_Config_PrefixRead VERSION) 1.5.3) || VersionLower $(POL_Config_PrefixRead VERSION) 1.4.10; then
	POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\.NETFramework" /v InstallRoot /d "C:\Windows\Microsoft.NET\Framework\\" /f
fi

# Setting Fix 2
WINEDLLOVERRIDES="mscoree,fusion=n"
export WINEDLLOVERRIDES

# Installing dotnet20
cd "$POL_USER_ROOT/ressources/dotnet20"
POL_Wine_WaitBefore ".NET Framework 2.0"
POL_Wine --ignore-errors dotnetfx.exe /q /c:"install.exe /q"

# Setting Fix 3
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYiUd+QAKCRDlMfrJqhPK
R5cDAJ9O2+5kdR/cbFemuFG1D3ba3J6NLgCfXEFJ8JuBc9/C18UI4PrMukNkNgY=
=89th
-----END PGP SIGNATURE-----
