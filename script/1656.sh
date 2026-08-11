#!/bin/bash
# PlayOnLinux Function
# Date : (2013-04-12 21:00)
# Last revision : N/A
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Install dotnet35 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v3.5/MSBuild.exe" ]; then
	POL_Call POL_Install_dotnet35
fi

# Ignore errors message
if VersionLower $(POL_Config_PrefixRead VERSION) 1.4.2; then
	POL_SetupWindow_message "$(eval_gettext 'If you see error messages during DotNet 3.5 SP1 installation, you can ignore them without issues')" "$TITLE"
fi

# Setting OS check Fix
Set_OS "winxp" "sp3"
cat << EOF > "dotnet35sp1_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "dotnet35sp1_fix.reg"

mkdir -p "$POL_USER_ROOT/ressources/dotnet35sp1"
cd "$POL_USER_ROOT/ressources/dotnet35sp1"
# Downloading dotnet35sp1
POL_Download_Resource "http://download.microsoft.com/download/2/0/e/20e90413-712f-438c-988e-fdaa79a8ac3d/dotnetfx35.exe" "d481cda2625d9dd2731a00f482484d86" "dotnet35sp1"

# Setting Fix 1
WINEDLLOVERRIDES="ngen.exe,regsvcs.exe,mscorsvw.exe=b"
export WINEDLLOVERRIDES
wineserver -k

# Installing dotnet35sp1
cabextract -d "$WINEPREFIX/drive_c/windows/temp/" -L -F '*' dotnetfx35.exe
cd "$WINEPREFIX/drive_c/windows/temp/wcu/dotnetframework/dotnetfx35/x86/"
cabextract -d . -L -F '*' netfx35_x86.exe
POL_Wine_WaitBefore ".NET Framework 3.5 SP1 Update"
POL_Wine --ignore-errors msiexec /i vs_setup.msi ADDEPLOY=1
POL_Wine_WaitExit ".NET Framework 3.5 SP1 Update"
unset WINEDLLOVERRIDES
wineserver -k
rm -rf "$WINEPREFIX"/drive_c/windows/temp/*
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFp0SAACgkQ5TH6yaoTykcfvACeMwv1O1L8Egza4Mk6eJYFtePy
2JIAn2LQMtRJODVhoHwY2d3Z0VPLedUu
=AQFZ
-----END PGP SIGNATURE-----
