#!/bin/bash
# PlayOnLinux Function
# Date : (2012-02-25 21:00)
# Last revision : (2013-04-15 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Remove wine-mono if present
POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true

# Ignore errors message
if VersionLower $(POL_Config_PrefixRead VERSION) 1.5.21 && [ ! -e "$WINEPREFIX"/drive_c/windows/Microsoft.NET/Framework/v3.5/MSBuild.exe ]; then
	POL_SetupWindow_message "$(eval_gettext 'If you see error messages during DotNet 4.0 installation, you can ignore them without issues')" "$TITLE"
fi

# Setting OS check Fix
Set_OS "winxp" "sp3"
cat << EOF > "dotnet40_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "dotnet40_fix.reg"

mkdir -p "$POL_USER_ROOT/ressources/dotnet40"
cd "$POL_USER_ROOT/ressources/dotnet40"
# Downloading dotnet40
POL_Download_Resource "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe" "251743dfd3fda414570524bac9e55381" "dotnet40"

# Downloading dotnet40 post-install fix - for wine 1.5.4 and older
if VersionLower $(POL_Config_PrefixRead VERSION) 1.5.5; then
	POL_Download_Resource "http://files.playonlinux.com/gacutil-net40.zip" "c6f6c18e70097538752b4e327b612846" "dotnet40"
fi

# Setting Fix 1
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4" /f
rm "$WINEPREFIX"/drive_c/windows/system32/mscoree.dll
WINEDLLOVERRIDES="fusion=b"
export WINEDLLOVERRIDES
wineserver -k

# Installing dotnet40 - it will hang with exit code 67, don't worry
POL_Wine_WaitBefore ".NET Framework 4.0"
POL_Wine --ignore-errors dotNetFx40_Full_x86_x64.exe /q /c:"install.exe /q"

# Overriding dll
POL_Wine_OverrideDLL "native" "mscoree"

# Setting Fix 2
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319" /f

# Setting Fix 3 - for wine 1.5.4 and older
if VersionLower $(POL_Config_PrefixRead VERSION) 1.5.5; then
	cd "$WINEPREFIX/drive_c/windows/temp/"
	unzip -o "$POL_USER_ROOT/ressources/dotnet40/gacutil-net40.zip"
	cd "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/"
	for assembly in *.[dD]ll
	do
		POL_Wine_WaitBefore "$assembly"
		POL_Wine start /unix "$WINEPREFIX/drive_c/windows/temp/gacutil.exe" /i "c:\\windows\\Microsoft.NET\\Framework\\v4.0.30319\\$assembly" /f
	done

	cd "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/WPF/"
	for assembly in *.[dD]ll
	do
		POL_Wine_WaitBefore "$assembly"
		POL_Wine start /unix "$WINEPREFIX/drive_c/windows/temp/gacutil.exe" /i "c:\\windows\\Microsoft.NET\\Framework\\v4.0.30319\\WPF\\$assembly" /f
	done

	# Setting Fix 4 - for wine 1.5.4 and older
	mkdir -p "$WINEPREFIX/drive_c/windows/Microsoft.NET/assembly/GAC_32/System.EnterpriseServices/v4.0_4.0.0.0__b03f5f7f11d50a3a"
	cp "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/System.EnterpriseServices.dll" "$WINEPREFIX/drive_c/windows/Microsoft.NET/assembly/GAC_32/System.EnterpriseServices/v4.0_4.0.0.0__b03f5f7f11d50a3a"
fi
unset WINEDLLOVERRIDES
wineserver -k
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVYjP8ACgkQ5TH6yaoTykfCZQCcCYxzMK3xX1Jh7YWrByOL/5iz
WbsAn3qOk6fW3H66y6JCnnWNv/JXY7ca
=Oa8d
-----END PGP SIGNATURE-----
