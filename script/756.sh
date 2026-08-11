#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-28 09-16)
# Last revision : (2012-04-10 13-43)
# Author : SuperPlumus
 
cd "$POL_USER_ROOT/ressources"
 
POL_Download_Resource "http://download.microsoft.com/download/4/4/d/44de8a9e-630d-4c10-9f17-b9b34d3f6417/scripten.exe" "65a8ebf870420316a939ac44fd4c731d"

POL_Wine_WaitBefore "wsh57"
if [ "$POL_ARCH" = "amd64" ]; then
    cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" scripten.exe
else
    cabextract -d "$WINEPREFIX/drive_c/windows/system32" scripten.exe
fi
 
POL_Wine_OverrideDLL native,builtin jscript
 
POL_Wine regsvr32 dispex.dll jscript.dll scrobj.dll scrrun.dll vbscript.dll wshcon.dll wshext.dll

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+EHWUACgkQ5TH6yaoTykerHQCfTMCrplLvJN4GBCJibhvS/wVC
6soAn3Qbzq57mXWUUh+YR+jKmkOf6ng1
=7Iqz
-----END PGP SIGNATURE-----
