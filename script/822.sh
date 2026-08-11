#!/bin/bash
# PlayOnLinux Function
# Date : (2011-03-17 21:00)
# Last revision : (2013-04-12 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com
# [xplicit] (2014-01-11 00:45)
#   fix for versions >= 1.5.21


# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Remove wine-mono if present
POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true

# Install dotnet30sp1 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/system32/XpsFilt.dll" ]; then
	POL_Call POL_Install_dotnet30sp1
fi

# Workaround the bug http://code.google.com/p/winetricks/issues/detail?id=311
if ! (VersionLower $(POL_Config_PrefixRead VERSION) 1.5.21); then
	POL_Call POL_Install_msxml3
fi

# Ignore errors message
if VersionLower $(POL_Config_PrefixRead VERSION) 1.4.2; then
	POL_SetupWindow_message "$(eval_gettext 'If you see error messages during DotNet 3.5 installation, you can ignore them without issues')" "$TITLE"
fi

# Setting OS check Fix
Set_OS "winxp" "sp3"
cat << EOF > "dotnet35_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "dotnet35_fix.reg"

mkdir -p "$POL_USER_ROOT/ressources/dotnet35"
cd "$POL_USER_ROOT/ressources/dotnet35"
# Downloading dotnet35
POL_Download_Resource "http://download.microsoft.com/download/6/0/f/60fc5854-3cb8-4892-b6db-bd4f42510f28/dotnetfx35.exe" "d1b341c1bc8b96e4898450c9881b1425" "dotnet35"

# Setting Fix 1
POL_Wine --ignore-errors reg delete "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v3.5" /f
WINEDLLOVERRIDES="ngen.exe,regsvcs.exe,mscorsvw.exe=b"
export WINEDLLOVERRIDES
wineserver -k

# Installing dotnet35
cabextract -d "$WINEPREFIX/drive_c/windows/temp/" -L -F '*' dotnetfx35.exe
cd "$WINEPREFIX/drive_c/windows/temp/wcu/dotnetframework/dotnetfx35/x86/"
cabextract -d . -L -F '*' netfx35_x86.exe
POL_Wine_WaitBefore ".NET Framework 3.5"
POL_Wine --ignore-errors msiexec /i vs_setup.msi ADDEPLOY=1
POL_Wine_WaitExit ".NET Framework 3.5"
unset WINEDLLOVERRIDES
wineserver -k
rm -rf "$WINEPREFIX"/drive_c/windows/temp/*
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwmCcYACgkQ5TH6yaoTykfWpwCfQEa+rBDaB1dXFiLUykNVF7TI
US4AnRoSwZUWtAdREafdiRVvtGDwvP8G
=IiNU
-----END PGP SIGNATURE-----
