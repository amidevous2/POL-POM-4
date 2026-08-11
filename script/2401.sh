#!/bin/bash
# Windows Imaging Component
# Date: (2014-01-16 21-00)
# Author: Rob Loach

# See: http://winetricks.googlecode.com/svn/trunk/src/winetricks
# load_windowscodecs

# Download the x64 or x86 Version
if [ "$POL_ARCH" = "amd64" ]; then
  POL_Download_Resource "http://download.microsoft.com/download/6/4/5/645FED5F-A6E7-44D9-9D10-FE83348796B0/wic_x64_enu.exe" "2eb787be1deb373efc259d1f42146419"
else
  POL_Download_Resource "http://download.microsoft.com/download/f/f/1/ff178bb1-da91-48ed-89e5-478a99387d4f/wic_x86_enu.exe" "53f5ccbe5fe06c3b40cc9e34ac909df7"
fi

# Remove old files
rm -f "$WINEPREFIX/drive_c/windows/system32/windowscodecs.dll"
rm -f "$WINEPREFIX/drive_c/windows/system32/windowscodecsext.dll"
rm -f "$WINEPREFIX/drive_c/windows/system32/photometadatahandler.dll"

# Run the Installer
cd "$POL_USER_ROOT/ressources/"
POL_Wine_WaitBefore "Windows Imaging Component"
if [ "$POL_ARCH" = "amd64" ]; then
  POL_Wine wic_x64_enu.exe /q /passive /overwriteoem
else
  POL_Wine wic_x86_enu.exe /q /passive /overwriteoem
fi
POL_Wine_WaitExit "Windows Imaging Component"

# Override the DDL
POL_Wine_OverrideDLL "native" "windowscodecs" "windowscodecsext"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg6EDgAKCRDlMfrJqhPK
R2HyAJ9IHbks1pmjsCJlO5fjCBx5mMfs0QCfabINAUFKsWpLXlwx/sMnTPYkjrY=
=VngW
-----END PGP SIGNATURE-----
