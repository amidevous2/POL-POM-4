#!/bin/bash
# Date : see changelog
# Wine version used : 5.0.1
# Distribution used to test : Kubuntu 18.04 LTS amd64
# Author : Dadu042
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [Dadu042] (2019-09-27 20:05)
#   First script.
#   I have inspired from  'POL_Install_dotnet480' (insired by 'POL_Install_dotnet461' by LinuxScripter),
#   and from the Winetricks sourcecode at:  https://github.com/Winetricks/winetricks/blob/master/src/winetricks
# [Dadu042] (2020-07-19 20:00)
#   Remove useless code for a function.

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
 
POL_Wine_OverrideDLL "native" "mscoree"

POL_Wine_OverrideDLL "builtin" "fusion"
export WINEDLLOVERRIDES
wineserver -k
 
# Main part of the script
POL_SetupWindow_message "Installing .NET 4.5.2"
POL_Download_Resource "https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe" "ee01fc4110c73a8e5efc7cabda0f5ff7" "dotnet452"
cd "$POL_USER_ROOT/ressources/dotnet452"
 
POL_Wine --ignore-errors "NDP452-KB2901907-x86-x64-AllOS-ENU.exe" /q /c:"install.exe /q"
POL_Wine_WaitBefore ".NET Framework"

# Registry fix to let softwares know what Dotnet version is installed
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Install /t REG_DWORD /d 0001 /f
POL_Wine --ignore-errors reg add "HKLM\\Software\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" /v Version /t REG_SZ /d "4.0.30319.379893" /f
# Versions are listed at: https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed

POL_SetupWindow_message "Setting Windows version to 2003, otherwise applications using .NET 4.5 will subtly fail."
Set_OS "win2003"

unset WINEDLLOVERRIDES

POL_Wine_OverrideDLL "native" "mscoree"
wineserver -k
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxymkgAKCRDlMfrJqhPK
R8qXAJ4z5+tJ0VhyFm4V5ZDtKagij1TsPgCeJpSqPmFioPPIa19Of7ZPOs6JrcY=
=O00/
-----END PGP SIGNATURE-----
