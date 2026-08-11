#!/bin/bash
# Date : (2015-01-8 11-30)
# Distribution used to test : Linux Mint 20.1
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.3.4

POL_Debug_Message "Installing vcrun2013..."

# Checking wine arch
if [ "$POL_ARCH" == "amd64" ]; then
    Path32Bit="$WINEPREFIX/drive_c/windows/syswow64"
    Path64Bit="$WINEPREFIX/drive_c/windows/system32"
else
    Path32Bit="$WINEPREFIX/drive_c/windows/system32"
fi

POL_Download_Resource "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe" "0fc525b6b7b96a87523daa7a0013c69d" "vcrun2013"
mkdir -p $POL_USER_ROOT/tmp/vcrun2013

POL_System_cabextract "$POL_USER_ROOT/ressources/vcrun2013/vcredist_x86.exe" -d "$POL_USER_ROOT/tmp/vcrun2013/"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2013/a2"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2013/a3"

POL_Debug_Message "Copying DLL files..."

cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120_x86 $Path32Bit/mfc120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120u_x86 $Path32Bit/mfc120u.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_msvcp120_x86 $Path32Bit/msvcp120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_msvcr120_x86 $Path32Bit/msvcr120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_vcomp120_x86 $Path32Bit/vcomp120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_vcamp120_x86 $Path32Bit/vcamp120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_vccorlib120_x86 $Path32Bit/vccorlib120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfcm120_x86 $Path32Bit/mfcm120.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfcm120u_x86 $Path32Bit/mfcm120u.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120chs_x86 $Path32Bit/mfc120chs.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120cht_x86 $Path32Bit/mfc120cht.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120deu_x86 $Path32Bit/mfc120deu.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120enu_x86 $Path32Bit/mfc120enu.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120esn_x86 $Path32Bit/mfc120esn.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120fra_x86 $Path32Bit/mfc120fra.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120ita_x86 $Path32Bit/mfc120ita.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120jpn_x86 $Path32Bit/mfc120jpn.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120kor_x86 $Path32Bit/mfc120kor.dll
cp -f $POL_USER_ROOT/tmp/vcrun2013/F_CENTRAL_mfc120rus_x86 $Path32Bit/mfc120rus.dll

if [ "$POL_ARCH" == "amd64" ]; then

    POL_Download_Resource "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe" "96b61b8e069832e6b809f24ea74567ba" "vcrun2013"
    mkdir -p $POL_USER_ROOT/tmp/vcrun2013/x64

    POL_System_cabextract "$POL_USER_ROOT/ressources/vcrun2013/vcredist_x64.exe" -d "$POL_USER_ROOT/tmp/vcrun2013/x64/"
    POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2013/x64/a2"
    POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2013/x64/a3"

    POL_Debug_Message "Copying x64 DLL files..."

    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120_x64 $Path64Bit/mfc120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120u_x64 $Path64Bit/mfc120u.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_msvcp120_x64 $Path64Bit/msvcp120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_msvcr120_x64 $Path64Bit/msvcr120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_vcomp120_x64 $Path64Bit/vcomp120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_vcamp120_x64 $Path64Bit/vcamp120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_vccorlib120_x64 $Path64Bit/vccorlib120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfcm120_x64 $Path64Bit/mfcm120.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfcm120u_x64 $Path64Bit/mfcm120u.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120chs_x64 $Path64Bit/mfc120chs.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120cht_x64 $Path64Bit/mfc120cht.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120deu_x64 $Path64Bit/mfc120deu.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120enu_x64 $Path64Bit/mfc120enu.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120esn_x64 $Path64Bit/mfc120esn.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120fra_x64 $Path64Bit/mfc120fra.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120ita_x64 $Path64Bit/mfc120ita.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120jpn_x64 $Path64Bit/mfc120jpn.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120kor_x64 $Path64Bit/mfc120kor.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2013/x64/F_CENTRAL_mfc120rus_x64 $Path64Bit/mfc120rus.dll
fi

POL_Wine_OverrideDLL "native,builtin" "mfc120"
POL_Wine_OverrideDLL "native,builtin" "mfc120u"
POL_Wine_OverrideDLL "native,builtin" "msvcp120"
POL_Wine_OverrideDLL "native,builtin" "msvcr120"
POL_Wine_OverrideDLL "native,builtin" "vcomp120"
POL_Wine_OverrideDLL "native,builtin" "vcamp120"
POL_Wine_OverrideDLL "native,builtin" "vccorlib120"
POL_Wine_OverrideDLL "native,builtin" "mfcm120"
POL_Wine_OverrideDLL "native,builtin" "mfcm120u"

POL_Debug_Message "Cleaning tmp folder..."
rm -rf $POL_USER_ROOT/tmp/vcrun2013
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLqmJwAKCRDlMfrJqhPK
R1CeAKCv6gz2C0hqJDtYlqJLhbZHI3tZSACfYg4EOjcpy6Pz7+u82UEim5gJtPM=
=WcDG
-----END PGP SIGNATURE-----
