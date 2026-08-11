#!/bin/bash
# Date : (2019-09-27 19:45)
  
# Wine version used : 4.15
# Distribution used to test : Kubuntu 18.04 LTS amd64
# Author : Dadu042
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [Dadu042] (2019-09-27 19:45)
#   First script.
#   I have inspired from 'POL_Install_dotnet461' by LinuxScripter,
#   and from the Winetricks sourcecode at:  https://github.com/Winetricks/winetricks/blob/master/src/winetricks
# [Dadu042] (2019-09-27 20:21)
#   Fix /norestart""
# [Dadu042] (2020-07-08 12:00)
#   Script does not end, so I remove  POL_SetupWindow_Close and exit 0, like in the Dotnet40 script.
#
# To see in Winetricks code:  "Running un-official repacked .NET 4.7.2 setup until the official version is fixed.",

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_Debug_Init
POL_SetupWindow_Init

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
# rm "$WINEPREFIX/drive_c/windows/system32/mscoree.dll"
    
# POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
# POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319" /f


# Dotnet472
POL_SetupWindow_message "Installing .NET 4.7.2"
POL_Download_Resource "https://download.microsoft.com/download/6/E/4/6E48E8AB-DC00-419E-9704-06DD46E5F81D/NDP472-KB4054530-x86-x64-AllOS-ENU.exe" "87450cfa175585b23a76bbd7052ee66b" "dotnet472"
cd "$POL_USER_ROOT/ressources/dotnet472"
POL_Wine --ignore-errors "NDP472-KB4054530-x86-x64-AllOS-ENU.exe" /q /c:"install.exe /sfxlang:1027 /q /norestart"


POL_Wine_OverrideDLL "native" "mscoree"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwW0UAAKCRDlMfrJqhPK
Rxl/AJ9i01Px6gcE8Gkx2cmxZ0yNUFpfPwCfRnwocYI2iCF228W3r1lUKC8Z1+k=
=csqy
-----END PGP SIGNATURE-----
