#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init
 
POL_SetupWindow_message "Installing/Download Sumatra PDF!" "This will download sumatrapdf"

POL_SetupWindow_InstallMethod "DOWNLOAD"
POL_Download "https://www.sumatrapdfreader.org/dl/rel/3.4.6/SumatraPDF-3.4.6-64.zip" 

POL_Wine_SelectPrefix "SumatraPDF"
POL_Wine_PrefixCreate

unzip $POL_System_TmpDir/SumatraPDF-3.4.6-64.zip -d $PREFIX/SumatraPDF

POL_Shortcut "sumatrapdf.exe" "Sumatra PDF"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZFDlDAAKCRDlMfrJqhPK
RyrXAJsGF1m2dOxmXGc0eT1lPLK+hiHpBwCbBL48uG1SRBy3f67rkHkojdHraPs=
=qw1E
-----END PGP SIGNATURE-----
