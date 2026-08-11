#!/bin/bash
# Date : (2010-09-01 22:00)
# Last revision : (2019-06-28 07:16)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

# Setting OS check Fix
Set_OS "win2k"
cat << EOF > "WMP9_fix.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows 2000"
"CSDVersion"=""
"CurrentVersion"="5.0"
"CurrentBuildNumber"="2195"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000000
EOF
POL_Wine regedit "WMP9_fix.reg"

# Downloading WMP9
cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://download.microsoft.com/download/4/4/d/44de8a9e-630d-4c10-9f17-b9b34d3f6417/scripten.exe" "65a8ebf870420316a939ac44fd4c731d"
POL_Download_Resource "https://web.archive.org/web/20180404022333/http://download.microsoft.com/download/1/b/c/1bc0b1a3-c839-4b36-8f3c-19847ba09299/MPSetup.exe" "e919c4e0050b32aebe83a5d2eb613dd4"

# Setting Fix 1
cabextract -d "$WINEPREFIX/drive_c/windows/system32" scripten.exe

# Overriding dll
POL_Wine_OverrideDLL "native,builtin" "jscript.dll"

POL_Wine regsvr32 dispex.dll jscript.dll scrobj.dll scrrun.dll vbscript.dll wshcon.dll wshext.dll

# Must be installed TWICE to work
POL_Wine start /unix "MPSetup.exe" /q
POL_Wine_WaitExit "WMP9 part 1"
POL_Wine start /unix "MPSetup.exe" /q
POL_Wine_WaitExit "WMP9 part 2"

# Setting Fix 2
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdr4_2K"
POL_Wine regedit /D "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Cdralw2k"

# Cleaning
wineserver -k
Set_OS "winxp" "sp3"
cat << EOF > "Cleaning.reg"
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"ProductName"="Microsoft Windows XP"
"CSDVersion"="Service Pack 3"
"CurrentVersion"="5.3"
"CurrentBuildNumber"="2600"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit "Cleaning.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRYLEwAKCRDlMfrJqhPK
R+WDAJ97wJb9ioQoSyvsN+VtUwjmH1XuUgCfRbf7nkZ37PvegLUTpJJeOKYrak4=
=3kZY
-----END PGP SIGNATURE-----
