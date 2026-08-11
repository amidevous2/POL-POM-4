#!/bin/bash
# Date : (2019-09-22 13:27)
  
# Wine version used : 4.15
# Distribution used to test : Kubuntu 18.04 LTS amd64
# Author : Dadu042
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [Dadu042] (2019-09-27 13:27)
#   First script.
#   I have inspired from 'POL_Install_dotnet461' by LinuxScripter,
#   and from the Winetricks sourcecode at:  https://github.com/Winetricks/winetricks/blob/master/src/winetricks
# [Dadu042] (2019-09-27 19:23)
#   Add a warning. Little changes.
# [Dadu042] (2019-09-27 20:21)
#   Fix /norestart""
# [Dadu042] (2020-07-08 12:00)
#   Script does not end, so I remove  POL_SetupWindow_Close and exit 0, like in the Dotnet40 script.


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
  


# Dotnet471
POL_SetupWindow_message "Installing .NET 4.7.1"
POL_Download_Resource "https://download.microsoft.com/download/C/4/C/C4CF757F-7578-4608-B483-7C51E16FB58F/NDP471-KB4033342-x86-x64-AllOS-ENU.exe" "660e1a104f209f3cdb55b6d4e9ffa475" "dotnet47"
cd "$POL_USER_ROOT/ressources/dotnet47"
POL_Wine --ignore-errors "NDP471-KB4033342-x86-x64-AllOS-ENU.exe" /q /c:"--timeout 5 /sfxlang:1027 /q /norestart"
POL_Wine_WaitExit ".NET Framework"

POL_Wine_OverrideDLL "native" "mscoree"
wineserver -k
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxxbngAKCRDlMfrJqhPK
R91mAJ4oT4lzKvfeRsX75G4xXZksPfxjzQCfbF0UfZ0jIYBsUPpkEjOo/ZV886s=
=OSid
-----END PGP SIGNATURE-----
