#!/usr/bin/env playonlinux-bash
# Date : (2015-06-4 12-30)
# Distribution used to test : Arch Linux, Cinnamon - 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.8
#
# Function to install .NET 4.5 through PlayOnLinux/PlayOnMac
#

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext 'This package does not work on a 64-bit installation')"
fi

local INSTALLER="dotnetfx45_full_x86_x64.exe"
local INSTALLER_MD5="d02dc8b69a702a47c083278938c4d2f1"
local INSTALLER_URL="http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"

# Removing mono
POL_Call POL_Remove_winemono

# Removing some leftover stuff that conflict with the installation
POL_Wine --ignore-errors reg delete "HKLM\Software\Microsoft\NET Framework Setup\NDP\v4" /f
rm "$WINEPREFIX/drive_c/windows/system32/mscoree.dll"

# Dependencies, overrides, and Windows version settings
POL_Call POL_Install_dotnet35
POL_Call POL_Install_dotnet40
Set_OS "win7"
POL_Wine_OverrideDLL "builtin" "fusion"

# Creating Temp directory
POL_Download_Resource "$INSTALLER_URL" "$INSTALLER_MD5" "dotnet45"

# Installing .NET 4.5
POL_Wine_WaitBefore ".NET Framework 4.5"
cd "$POL_USER_ROOT/ressources/dotnet45"
POL_Wine --ignore-errors "$INSTALLER" /q /c:"install.exe /q"

# More overrides
POL_Wine_OverrideDLL "builtin" "fusion"
Set_OS "win2003"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXPI3wACgkQ5TH6yaoTykdTvgCgo2h9ak8wenimx40pMuNS9vx9
HY8An3R015OlWkRyz5K4X5/e6XhvQV2c
=6neD
-----END PGP SIGNATURE-----
