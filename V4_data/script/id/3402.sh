#!/bin/bash
# Date : (2018-11-07 21:00)
 
# Wine version used : 3.1
# Distribution used to test : Kubuntu 16.04 LTS amd64
# Author : der Papst
# Licence : GPLv3
# PlayOnLinux: 4.2.12

# CHANGELOG
# [Der Papst] (2018-11-07 21:00)
#   First script.
# [Dadu042] (2020-07-25 12:00)
#   Script does not end, so I remove  POL_SetupWindow_Close and exit 0, like in the Dotnet40 script.
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

POL_Debug_Init
POL_SetupWindow_Init

if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext '64-bit not supported')"
fi
  
#remove mono
POL_SetupWindow_message "Removing Mono..."
POL_Call POL_Remove_winemono
 
#cleanup
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v3.5" /f
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4" /f
rm "$WINEPREFIX/drive_c/windows/system32/mscoree.dll"
 
# Dotnet 40
POL_SetupWindow_message "Installing .NET 4.0"
Set_OS "winxp"
POL_Download_Resource "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe" "251743dfd3fda414570524bac9e55381" "dotnet40"
cd "$POL_USER_ROOT/ressources/dotnet40"
POL_Wine --ignore-errors "dotNetFx40_Full_x86_x64.exe" /q /c:"install.exe /q"
 
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319" /f
 
# Dotnet 45
POL_SetupWindow_message "Installing .NET 4.5"
Set_OS "win7"
POL_Download_Resource "http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe" "d02dc8b69a702a47c083278938c4d2f1" "dotnet45"
cd "$POL_USER_ROOT/ressources/dotnet45"
POL_Wine --ignore-errors "dotnetfx45_full_x86_x64.exe" /q /c:"install.exe /q"
 
POL_Wine_OverrideDLL "native" "mscoree"
 
# Dotnet461
POL_SetupWindow_message "Installing .NET 4.6.1"
POL_Download_Resource "https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe" "864056903748706e251fec9f5d887ef9" "dotnet46"
cd "$POL_USER_ROOT/ressources/dotnet46"
POL_Wine --ignore-errors "NDP461-KB3102436-x86-x64-AllOS-ENU.exe" /q /c:"install.exe /q"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxxUGgAKCRDlMfrJqhPK
R+R8AKCNDAcDxA920zyABaE93i9FL72JowCdFAg+nWSxDUmtkZxPP0VHz5mKvK8=
=qfpu
-----END PGP SIGNATURE-----
