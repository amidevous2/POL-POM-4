#!/bin/bash
# Date : (2015-01-6 22-00)
# Distribution used to test : Linux Mint 20.1
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.3.4

POL_Debug_Message "Installing vcrun2012..."

# Checking wine arch
if [ "$POL_ARCH" = "amd64" ]; then
    Path32Bit="$WINEPREFIX/drive_c/windows/syswow64"
    Path64Bit="$WINEPREFIX/drive_c/windows/system32"
else
    Path32Bit="$WINEPREFIX/drive_c/windows/system32"
fi

POL_Download_Resource "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe" "7f52a19ecaf7db3c163dd164be3e592e" "vcrun2012"
mkdir -p $POL_USER_ROOT/tmp/vcrun2012
cd $POL_USER_ROOT/tmp/vcrun2012

cp -f $POL_USER_ROOT/ressources/vcrun2012/vcredist_x86.exe $POL_USER_ROOT/tmp/vcrun2012/
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/vcredist_x86.exe"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/a2"
POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/a3"

POL_Debug_Message "Copying DLL files..."

cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_atl110_x86 $Path32Bit/atl110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110_x86 $Path32Bit/mfc110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110u_x86 $Path32Bit/mfc110u.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_msvcp110_x86 $Path32Bit/msvcp110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_msvcr110_x86 $Path32Bit/msvcr110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_vcomp110_x86 $Path32Bit/vcomp110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_vccorlib110_x86 $Path32Bit/vccorlib110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfcm110_x86 $Path32Bit/mfcm110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfcm110u_x86 $Path32Bit/mfcm110u.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_vcamp110_x86 $Path32Bit/vcamp110.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110chs_x86 $Path32Bit/mfc110chs.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110cht_x86 $Path32Bit/mfc110cht.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110deu_x86 $Path32Bit/mfc110deu.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110enu_x86 $Path32Bit/mfc110enu.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110esn_x86 $Path32Bit/mfc110esn.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110fra_x86 $Path32Bit/mfc110fra.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110ita_x86 $Path32Bit/mfc110ita.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110jpn_x86 $Path32Bit/mfc110jpn.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110kor_x86 $Path32Bit/mfc110kor.dll
cp -f $POL_USER_ROOT/tmp/vcrun2012/F_CENTRAL_mfc110rus_x86 $Path32Bit/mfc110rus.dll

if [ "$POL_ARCH" = "amd64" ]; then
    POL_Download_Resource "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" "3c03562b5af9ed347614053d459d7778" "vcrun2012"
    mkdir -p $POL_USER_ROOT/tmp/vcrun2012/x64
    cd $POL_USER_ROOT/tmp/vcrun2012/x64

    cp -f $POL_USER_ROOT/ressources/vcrun2012/vcredist_x64.exe $POL_USER_ROOT/tmp/vcrun2012/x64/
    POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/x64/vcredist_x64.exe"
    POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/x64/a2"
    POL_System_cabextract "$POL_USER_ROOT/tmp/vcrun2012/x64/a3"

    POL_Debug_Message "Copying x64 DLL files..."

    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_atl110_x64 $Path64Bit/atl110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110_x64 $Path64Bit/mfc110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110u_x64 $Path64Bit/mfc110u.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_msvcp110_x64 $Path64Bit/msvcp110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_msvcr110_x64 $Path64Bit/msvcr110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_vcomp110_x64 $Path64Bit/vcomp110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_vccorlib110_x64 $Path64Bit/vccorlib110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfcm110_x64 $Path64Bit/mfcm110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfcm110u_x64 $Path64Bit/mfcm110u.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_vcamp110_x64 $Path64Bit/vcamp110.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110chs_x64 $Path64Bit/mfc110chs.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110cht_x64 $Path64Bit/mfc110cht.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110deu_x64 $Path64Bit/mfc110deu.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110enu_x64 $Path64Bit/mfc110enu.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110esn_x64 $Path64Bit/mfc110esn.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110fra_x64 $Path64Bit/mfc110fra.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110ita_x64 $Path64Bit/mfc110ita.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110jpn_x64 $Path64Bit/mfc110jpn.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110kor_x64 $Path64Bit/mfc110kor.dll
    cp -f $POL_USER_ROOT/tmp/vcrun2012/x64/F_CENTRAL_mfc110rus_x64 $Path64Bit/mfc110rus.dll

fi

POL_Wine_OverrideDLL "native,builtin" "atl110"
POL_Wine_OverrideDLL "native,builtin" "mfc110"
POL_Wine_OverrideDLL "native,builtin" "mfc110u"
POL_Wine_OverrideDLL "native,builtin" "msvcp110"
POL_Wine_OverrideDLL "native,builtin" "msvcr110"
POL_Wine_OverrideDLL "native,builtin" "vcomp110"
POL_Wine_OverrideDLL "native,builtin" "vccorlib110"
POL_Wine_OverrideDLL "native,builtin" "mfcm110"
POL_Wine_OverrideDLL "native,builtin" "mfcm110u"
POL_Wine_OverrideDLL "native,builtin" "vcamp110"


POL_Debug_Message "Cleaning tmp folder..."
rm -rf $POL_USER_ROOT/tmp/vcrun2012
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYLf6OwAKCRDlMfrJqhPK
RyW8AJ9Qrp3elbS63ljsCwTM21rATBIMqQCfTYz7u7e9KFc+sjz1JslotdvhHGA=
=Jc8E
-----END PGP SIGNATURE-----
