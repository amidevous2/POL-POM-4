#!/bin/bash
# Date : (2019-09-13 10:34)
# Distribution used to test : Xubuntu 18.04 - 64-bit
# Author : Dadu042 (inspired from RoninDusette's vcrun2013 script)
# Licence : GPLv3
# PlayOnLinux: 4.3.4

POL_Debug_Message "Installing vcrun2015..."

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext 'WARNING: This 32bits package (vcrun2015) can not work on a 64-bit installation.')"
        # POL_SetupWindow_message "$(eval_gettext 'WARNING: This 32bits package (vcrun2015) can not work on a 64-bit installation.')" "$TITLE"
fi

POL_Download_Resource "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe" "1a15e6606bac9647e7ad3caa543377cf" "vcrun2015"
mkdir $POL_USER_ROOT/tmp/vcrun2015
cd $POL_USER_ROOT/tmp/vcrun2015

POL_Debug_Message "Extracting DLL files..."

cp $POL_USER_ROOT/ressources/vcrun2015/vc_redist.x86.exe $POL_USER_ROOT/tmp/vcrun2015/
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2015/vc_redist.x86.exe"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2015/a10"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2015/a11"
  
POL_Debug_Message "Copying DLL files..."
 
cp $POL_USER_ROOT/tmp/vcrun2015/mfc140.dll $WINEPREFIX/drive_c/windows/system32/mfc140.dll
cp $POL_USER_ROOT/tmp/vcrun2015/mfc140u.dll $WINEPREFIX/drive_c/windows/system32/mfc140u.dll
cp $POL_USER_ROOT/tmp/vcrun2015/msvcp140.dll $WINEPREFIX/drive_c/windows/system32/msvcp140.dll
cp $POL_USER_ROOT/tmp/vcrun2015/vcruntime140.dll $WINEPREFIX/drive_c/windows/system32/vcruntime140.dll
cp $POL_USER_ROOT/tmp/vcrun2015/vcomp140.dll $WINEPREFIX/drive_c/windows/system32/vcomp140.dll
cp $POL_USER_ROOT/tmp/vcrun2015/mfc140enu.dll $WINEPREFIX/drive_c/windows/system32/mfc140enu.dll
 
POL_Wine_OverrideDLL "native,builtin" "mfc140"
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
POL_Wine_OverrideDLL "native,builtin" "vcruntime140"
POL_Wine_OverrideDLL "native,builtin" "vcomp140"
POL_Wine_OverrideDLL "native,builtin" "vcomp140"
 
# Piece (unused here) from the Winetricks sourcecode (2019-09):
# w_override_dlls native,builtin api-ms-win-crt-conio-l1-1-0 api-ms-win-crt-heap-l1-1-0 api-ms-win-crt-locale-l1-1-0 api-ms-win-crt-math-l1-1-0 api-ms-win-crt-runtime-l1-1-0 api-ms-win-crt-stdio-l1-1-0 api-ms-win-crt-time-l1-1-0 atl140 concrt140 msvcp140 msvcr140 ucrtbase
  
POL_Debug_Message "Cleaning tmp folder..."
# rm -rf $POL_USER_ROOT/tmp/vcrun2015
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXuSa0wAKCRDlMfrJqhPK
R1MzAJ4yPAZUjhj6HnJyVxMwS1BgncUKkwCffWWBzcK3MQC9mnZigC+AFbAFVDk=
=68to
-----END PGP SIGNATURE-----
