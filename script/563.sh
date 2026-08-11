#!/bin/bash
# PlayOnLinux Function
# Date : (2009-11-21 16:00)
# Last revision : (2013-04-12 21:00)
# Author : Berillions
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Check Kernel ptrace
if [ -e "/proc/sys/kernel/yama/ptrace_scope" ]; then
	PTRACE_CHECK=`cat /proc/sys/kernel/yama/ptrace_scope`
	if [ "$PTRACE_CHECK" != 0 ]; then
		MSG="$(eval_gettext 'Package installation will fail until you set /proc/sys/kernel/yama/ptrace_scope to 0')"
		URL="http://www.playonlinux.com/en/topic-10534-Regarding_ptrace_scope_fatal_error.html"
		POL_SetupWindow_question "$MSG\n$(eval_gettext 'Open $URL now?')"
		[ "$APP_ANSWER" = "TRUE" ] && POL_Browser "$URL"
		NOBUGREPORT="YES" POL_Debug_Fatal "$MSG"
	fi
fi

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Remove wine-mono if present
POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true

# Install dotnet20sp1 if needed
if [ ! -e "$WINEPREFIX/drive_c/windows/winsxs/manifests/x86_Microsoft.VC80.CRT_1fc8b3b9a1e18e3b_8.0.50727.3053_x-ww_b80fa8ca.cat" ]; then
	POL_Call POL_Install_dotnet20sp2
fi

# Setting OS check Fix
Set_OS "winxp" "sp3"
cat << EOF > "dotnet30_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "dotnet30_fix.reg"

# Ignore errors message
if VersionLower $(POL_Config_PrefixRead VERSION) 1.4.2; then
	POL_SetupWindow_message "$(eval_gettext 'If you see error messages during DotNet 3.0 installation, you can ignore them without issues')" "$TITLE"
fi

# Setting Fix 1
POL_Wine_WaitBefore ".NET Framework 3.0 fix"
if [ ! -e "$WINEPREFIX/drive_c/windows/SYSMSICache/Framework/v3.0" ]; then
	mkdir -p "$WINEPREFIX/drive_c/windows/SYSMSICache/Framework/v3.0"
fi

for lang in ar cs da de el es fi fr he it jp ko nb nl pl pt-BR pt-PT ru sv tr zh-CHS zh-CHT
do
ln -sf "$WINEPREFIX/drive_c/windows/system32/spupdsvc.exe" "$WINEPREFIX/drive_c/windows/SYSMSICache/Framework/v3.0/dotnetfx3langpack${lang}.exe"
done

mkdir "$POL_USER_ROOT/ressources/dotnet30"
cd "$POL_USER_ROOT/ressources/dotnet30"
POL_Download_Resource "https://web.archive.org/web/20061130220825if_/http://download.microsoft.com/download/3/F/0/3F0A922C-F239-4B9B-9CB0-DF53621C57D9/dotnetfx3.exe" "7b26435437e8d779ff0084d4ea96d15a" "dotnet30"

# Setting Fix 2
POL_Wine --ignore-errors sc delete "FontCache3.0.0.0"

# Setting Fix 3
if [ "$(POL_Config_PrefixRead VERSION)" = "1.5.6" ]; then
	WINEDLLOVERRIDES="ngen.exe,mscorsvw.exe=b"
	WINEDLLOVERRIDES="mscoree,fusion=n":$WINEDLLOVERRIDES
else
	WINEDLLOVERRIDES="ngen.exe,mscorsvw.exe=b"
fi
export WINEDLLOVERRIDES
wineserver -k
POL_Wine reg add "HKLM\\Software\\Microsoft\\.NETFramework" /v InstallRoot /d "C:\Windows\Microsoft.NET\Framework\\" /f

# Installing dotnet30
POL_Wine_WaitBefore ".NET Framework 3.0"
POL_Wine --ignore-errors dotnetfx3.exe /q /c:"install.exe /q"

# Restoring wine version
unset WINEDLLOVERRIDES
wineserver -k
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlps7S0ACgkQ5TH6yaoTykffAQCgi95lU0QqJ1Iw608KvNrOiO39
2OAAnibHguKxNGzthfZMPN4WxrxvMthr
=taqe
-----END PGP SIGNATURE-----
