#!/bin/bash
# Date : (2019-09-27 20:05)
  
# Wine version used : 4.15
# Distribution used to test : Kubuntu 18.04 LTS amd64
# Author : Dadu042
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [Dadu042] (2019-09-27 20:05)
#   First script.
#   I have inspired from 'POL_Install_dotnet461' by LinuxScripter,
#   and from the Winetricks sourcecode at:  https://github.com/Winetricks/winetricks/blob/master/src/winetricks
# [Dadu042] (2019-09-27 20:11)
#   Change arguments.
# [Dadu042] (2020-07-08 12:00)
#   Script does not end, so I remove  POL_SetupWindow_Close and exit 0, like in the Dotnet40 script.
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_Debug_Init
POL_SetupWindow_Init

# This part does not appear in the Winetricks code
if [ "$POL_ARCH" == "amd64" ]; then
    # POL_Debug_Fatal "$(eval_gettext '64-bit not supported')"
    POL_SetupWindow_message "This package may not fully work on a 64-bit installation. 32-bit prefixes may work better." 
fi

#remove mono
POL_SetupWindow_message "Removing Mono..."
POL_Call POL_Remove_winemono
  
#cleanup
# POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v3.5" /f
# POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4" /f
rm "$WINEPREFIX/drive_c/windows/system32/mscoree.dll"

# POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
# POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319" /f


POL_Wine_OverrideDLL "native" "mscoree"

# Dotnet480
POL_SetupWindow_message "Installing .NET 4.8.0"
POL_Download_Resource "https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe" "aebcb9fcafa2becf8bb30458a7e1f0a2" "dotnet480"
cd "$POL_USER_ROOT/ressources/dotnet480"

POL_Wine --ignore-errors "ndp48-x86-x64-allos-enu.exe" /q /c:"install.exe /sfxlang:1027 /q /norestart"

# NOK (does never end): POL_Wine --ignore-errors "ndp48-x86-x64-allos-enu.exe" /q /c:"install.exe /sfxlang:1027 /q /norestart""

# To test? :  POL_Wine --ignore-errors "ndp48-x86-x64-allos-enu.exe" /q /sfxlang:1027 /norestart /c:"install.exe /q"
# dotnet461: POL_Wine --ignore-errors "NDP461-KB3102436-x86-x64-AllOS-ENU.exe" /q /c:"install.exe /q"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwW1mQAKCRDlMfrJqhPK
R3oaAJ9sF8GmKlfroCul1mHNL62TUSAwKgCdEHca0zj1UlqyrHjPCQ35jNm0miI=
=BtCX
-----END PGP SIGNATURE-----
