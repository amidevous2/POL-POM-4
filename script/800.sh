#!/bin/bash
# PlayOnLinux Function
  
# Date : (2011-02-20 06-04)
# Last revision : (2012-04-09 19-05)
# Author : SuperPlumus

cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "https://web.archive.org/web/20080222203526if_/http://download.microsoft.com/download/d/1/3/d13cd456-f0cf-4fb2-a17f-20afc79f8a51/DCOM98.EXE" "9a7bc7ff37168217123a5e28aadef897"

Set_OS "win98"

if [ "$POL_ARCH" = "amd64" ]; then
    POL_Debug_Warning "dcom98 package is not tested on 64bits!"
    cd "$WINEPREFIX/drive_c/windows/syswow64"
    rm -f ole32.dll olepro32.dll oleaut32.dll rpcrt4.dll
else
    cd "$WINEPREFIX/drive_c/windows/system32"
    rm -f ole32.dll olepro32.dll oleaut32.dll rpcrt4.dll
fi

POL_Call POL_SP2_Extract ole32.dll
POL_Call POL_SP2_Extract olepro32.dll
POL_Call POL_SP2_Extract oleaut32.dll
POL_Call POL_SP2_Extract rpcrt4.dll

POL_Wine_OverrideDLL native,builtin ole32 oleaut32 rpcrt4
POL_Wine_OverrideDLL_App explorer.exe builtin ole32 oleaut32 rpcrt4
POL_Wine_OverrideDLL_App iexplore.exe builtin ole32 oleaut32 rpcrt4
POL_Wine_OverrideDLL_App services.exe builtin ole32 oleaut32 rpcrt4
POL_Wine_OverrideDLL_App wineboot.exe builtin ole32 oleaut32 rpcrt4
POL_Wine_OverrideDLL_App winedevice.exe builtin ole32 oleaut32 rpcrt4
 
Set_OS "winxp"

POL_Wine_WaitExit "dcom98"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX/RSqQAKCRDlMfrJqhPK
Ry5DAJ9Qv4+qkpFK8zKZsMZlMJWnLAXyqACglLTMsM5J6nu/SHHiuMWSsfvzR8o=
=TqOw
-----END PGP SIGNATURE-----
