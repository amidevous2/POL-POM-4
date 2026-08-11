#!/usr/bin/env playonlinux-bash
# Date : (2019-07-09 11-56)
# Last revision : (2021-10-10 08-09)
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Author : Yaotl
# PlayOnLinux : 4.3.4
# Script licence : GPL3
#
# CHANGELOG
# [Yaotl] (2019-09-24)
#    - Fix invalid hash.
#    - Update vcrun2019 14.22.27821 to 14.23.27820
# [Yaotl] (2019-10-30)
#    - Script repaired (Files are now copied to the correct location.)!
# [Yaotl] (2019-12-06)
#    - Fix invalid hash.
#    - Update vcrun2019 14.23.27820 to 14.24.28127
# [Yaotl] (2021-04-14)
#    - Update vcrun2019 14.24.28127 to 14.28.29914
#    - Necessary and cosmetic script adjustments.
# [Yaotl] (2021-10-10)
#    - Additionally v14.29.30135 installation

if [ "$POL_ARCH" = "amd64" ]; then
    Path32Bit="$WINEPREFIX/drive_c/windows/syswow64"
    Path64Bit="$WINEPREFIX/drive_c/windows/system32"
else
    Path32Bit="$WINEPREFIX/drive_c/windows/system32"
fi

cd "$POL_USER_ROOT/ressources/vcrun2019/14.28.29914"
POL_Download_Resource "https://download.visualstudio.microsoft.com/download/pr/85d47aa9-69ae-4162-8300-e6b7e4bf3cf3/14563755AC24A874241935EF2C22C5FCE973ACB001F99E524145113B2DC638C1/VC_redist.x86.exe" "ec00a28970a8ebd1c2963df8c3f54ad3" "vcrun2019/14.28.29914" # Version: 14.28.29914 x86 # Please do not change!
POL_Download_Resource "https://download.visualstudio.microsoft.com/download/pr/85d47aa9-69ae-4162-8300-e6b7e4bf3cf3/52B196BBE9016488C735E7B41805B651261FFA5D7AA86EB6A1D0095BE83687B2/VC_redist.x64.exe" "f7eef72822943c72bdbe9992fade5a5a" "vcrun2019/14.28.29914" # Version: 14.28.29914 x64 # Please do not change!
cd "$POL_USER_ROOT/ressources/vcrun2019" "vcrun2019"
POL_Download_Resource "https://download.visualstudio.microsoft.com/download/pr/73b58d04-0049-47d1-9f54-1784792c71cd/80C7969F4E05002A0CD820B746E0ACB7406D4B85E52EF096707315B390927824/VC_redist.x86.exe" "44b4932dad3cbb8ce7af149a3c155ef9" "vcrun2019" # Version: 14.29.30135 x86 # Can be changed
POL_Download_Resource "https://download.visualstudio.microsoft.com/download/pr/d3cbdace-2bb8-4dc5-a326-2c1c0f1ad5ae/9B9DD72C27AB1DB081DE56BB7B73BEE9A00F60D14ED8E6FDE45DAB3E619B5F04/VC_redist.x64.exe" "291e0c486cbe22cb000c5e541c9e8317" "vcrun2019" # Version: 14.29.30135 x64 # Can be changed

mkdir -p $POL_USER_ROOT/tmp/vcrun2019
cabextract -F 'a10' "$POL_USER_ROOT/ressources/vcrun2019/14.28.29914/VC_redist.x86.exe" -d "$POL_USER_ROOT/tmp/vcrun2019"
cabextract -F 'a11' "$POL_USER_ROOT/ressources/vcrun2019/14.28.29914/VC_redist.x86.exe" -d "$POL_USER_ROOT/tmp/vcrun2019"
cd $POL_USER_ROOT/tmp/vcrun2019
cabextract a10
cabextract a11

cp -f concrt140.dll mfc140.dll mfc140chs.dll mfc140cht.dll mfc140deu.dll mfc140enu.dll mfc140esn.dll mfc140fra.dll mfc140ita.dll mfc140jpn.dll mfc140kor.dll mfc140rus.dll mfc140u.dll mfcm140.dll mfcm140u.dll msvcp140.dll msvcp140_1.dll msvcp140_2.dll msvcp140_atomic_wait.dll msvcp140_codecvt_ids.dll ucrtbase.dll vcamp140.dll vccorlib140.dll vcomp140.dll vcruntime140.dll $Path32Bit
cp -f api_ms_win_core_console_l1_1_0.dll $Path32Bit/api-ms-win-core-console-l1-1-0.dll
cp -f api_ms_win_core_datetime_l1_1_0.dll $Path32Bit/api-ms-win-core-datetime-l1-1-0.dll
cp -f api_ms_win_core_debug_l1_1_0.dll $Path32Bit/api-ms-win-core-debug-l1-1-0.dll
cp -f api_ms_win_core_errorhandling_l1_1_0.dll $Path32Bit/api-ms-win-core-errorhandling-l1-1-0.dll
cp -f api_ms_win_core_file_l1_1_0.dll $Path32Bit/api-ms-win-core-file-l1-1-0.dll
cp -f api_ms_win_core_file_l1_2_0.dll $Path32Bit/api-ms-win-core-file-l1-2-0.dll
cp -f api_ms_win_core_file_l2_1_0.dll $Path32Bit/api-ms-win-core-file-l2-1-0.dll
cp -f api_ms_win_core_handle_l1_1_0.dll $Path32Bit/api-ms-win-core-handle-l1-1-0.dll
cp -f api_ms_win_core_heap_l1_1_0.dll $Path32Bit/api-ms-win-core-heap-l1-1-0.dll
cp -f api_ms_win_core_interlocked_l1_1_0.dll $Path32Bit/api-ms-win-core-interlocked-l1-1-0.dll
cp -f api_ms_win_core_libraryloader_l1_1_0.dll $Path32Bit/api-ms-win-core-libraryloader-l1-1-0.dll
cp -f api_ms_win_core_localization_l1_2_0.dll $Path32Bit/api-ms-win-core-localization-l1-2-0.dll
cp -f api_ms_win_core_memory_l1_1_0.dll $Path32Bit/api-ms-win-core-memory-l1-1-0.dll
cp -f api_ms_win_core_namedpipe_l1_1_0.dll $Path32Bit/api-ms-win-core-namedpipe-l1-1-0.dll
cp -f api_ms_win_core_processenvironment_l1_1_0.dll $Path32Bit/api-ms-win-core-processenvironment-l1-1-0.dll
cp -f api_ms_win_core_processthreads_l1_1_0.dll $Path32Bit/api-ms-win-core-processthreads-l1-1-0.dll
cp -f api_ms_win_core_processthreads_l1_1_1.dll $Path32Bit/api-ms-win-core-processthreads-l1-1-1.dll
cp -f api_ms_win_core_profile_l1_1_0.dll $Path32Bit/api-ms-win-core-profile-l1-1-0.dll
cp -f api_ms_win_core_rtlsupport_l1_1_0.dll $Path32Bit/api-ms-win-core-rtlsupport-l1-1-0.dll
cp -f api_ms_win_core_string_l1_1_0.dll $Path32Bit/api-ms-win-core-string-l1-1-0.dll
cp -f api_ms_win_core_synch_l1_1_0.dll $Path32Bit/api-ms-win-core-synch-l1-1-0.dll
cp -f api_ms_win_core_synch_l1_2_0.dll $Path32Bit/api-ms-win-core-synch-l1-2-0.dll
cp -f api_ms_win_core_sysinfo_l1_1_0.dll $Path32Bit/api-ms-win-core-sysinfo-l1-1-0.dll
cp -f api_ms_win_core_timezone_l1_1_0.dll $Path32Bit/api-ms-win-core-timezone-l1-1-0.dll
cp -f api_ms_win_core_util_l1_1_0.dll $Path32Bit/api-ms-win-core-util-l1-1-0.dll
cp -f api_ms_win_crt_conio_l1_1_0.dll $Path32Bit/api-ms-win-crt-conio-l1-1-0.dll
cp -f api_ms_win_crt_convert_l1_1_0.dll $Path32Bit/api-ms-win-crt-convert-l1-1-0.dll
cp -f api_ms_win_crt_environment_l1_1_0.dll $Path32Bit/api-ms-win-crt-environment-l1-1-0.dll
cp -f api_ms_win_crt_filesystem_l1_1_0.dll $Path32Bit/api-ms-win-crt-filesystem-l1-1-0.dll
cp -f api_ms_win_crt_heap_l1_1_0.dll $Path32Bit/api-ms-win-crt-heap-l1-1-0.dll
cp -f api_ms_win_crt_locale_l1_1_0.dll $Path32Bit/api-ms-win-crt-locale-l1-1-0.dll
cp -f api_ms_win_crt_math_l1_1_0.dll $Path32Bit/api-ms-win-crt-math-l1-1-0.dll
cp -f api_ms_win_crt_multibyte_l1_1_0.dll $Path32Bit/api-ms-win-crt-multibyte-l1-1-0.dll
cp -f api_ms_win_crt_private_l1_1_0.dll $Path32Bit/api-ms-win-crt-private-l1-1-0.dll
cp -f api_ms_win_crt_process_l1_1_0.dll $Path32Bit/api-ms-win-crt-process-l1-1-0.dll
cp -f api_ms_win_crt_runtime_l1_1_0.dll $Path32Bit/api-ms-win-crt-runtime-l1-1-0.dll
cp -f api_ms_win_crt_stdio_l1_1_0.dll $Path32Bit/api-ms-win-crt-stdio-l1-1-0.dll
cp -f api_ms_win_crt_string_l1_1_0.dll $Path32Bit/api-ms-win-crt-string-l1-1-0.dll
cp -f api_ms_win_crt_time_l1_1_0.dll $Path32Bit/api-ms-win-crt-time-l1-1-0.dll
cp -f api_ms_win_crt_utility_l1_1_0.dll $Path32Bit/api-ms-win-crt-utility-l1-1-0.dll

POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2019/VC_redist.x86.exe" /Q

if [ "$POL_ARCH" = "amd64" ]; then
    mkdir -p $POL_USER_ROOT/tmp/vcrun2019/x64
    cabextract -F 'a10' "$POL_USER_ROOT/ressources/vcrun2019/14.28.29914/VC_redist.x64.exe" -d "$POL_USER_ROOT/tmp/vcrun2019/x64"
    cabextract -F 'a11' "$POL_USER_ROOT/ressources/vcrun2019/14.28.29914/VC_redist.x64.exe" -d "$POL_USER_ROOT/tmp/vcrun2019/x64"
    cd $POL_USER_ROOT/tmp/vcrun2019/x64
    cabextract a10
    cabextract a11

    cp -f concrt140.dll mfc140.dll mfc140chs.dll mfc140cht.dll mfc140deu.dll mfc140enu.dll mfc140esn.dll mfc140fra.dll mfc140ita.dll mfc140jpn.dll mfc140kor.dll mfc140rus.dll mfc140u.dll mfcm140.dll mfcm140u.dll msvcp140.dll msvcp140_1.dll msvcp140_2.dll msvcp140_atomic_wait.dll msvcp140_codecvt_ids.dll ucrtbase.dll vcamp140.dll vccorlib140.dll vcomp140.dll vcruntime140.dll vcruntime140_1.dll $Path64Bit
    cp -f api_ms_win_core_console_l1_1_0.dll $Path64Bit/api-ms-win-core-console-l1-1-0.dll
    cp -f api_ms_win_core_datetime_l1_1_0.dll $Path64Bit/api-ms-win-core-datetime-l1-1-0.dll
    cp -f api_ms_win_core_debug_l1_1_0.dll $Path64Bit/api-ms-win-core-debug-l1-1-0.dll
    cp -f api_ms_win_core_errorhandling_l1_1_0.dll $Path64Bit/api-ms-win-core-errorhandling-l1-1-0.dll
    cp -f api_ms_win_core_file_l1_1_0.dll $Path64Bit/api-ms-win-core-file-l1-1-0.dll
    cp -f api_ms_win_core_file_l1_2_0.dll $Path64Bit/api-ms-win-core-file-l1-2-0.dll
    cp -f api_ms_win_core_file_l2_1_0.dll $Path64Bit/api-ms-win-core-file-l2-1-0.dll
    cp -f api_ms_win_core_handle_l1_1_0.dll $Path64Bit/api-ms-win-core-handle-l1-1-0.dll
    cp -f api_ms_win_core_heap_l1_1_0.dll $Path64Bit/api-ms-win-core-heap-l1-1-0.dll
    cp -f api_ms_win_core_interlocked_l1_1_0.dll $Path64Bit/api-ms-win-core-interlocked-l1-1-0.dll
    cp -f api_ms_win_core_libraryloader_l1_1_0.dll $Path64Bit/api-ms-win-core-libraryloader-l1-1-0.dll
    cp -f api_ms_win_core_localization_l1_2_0.dll $Path64Bit/api-ms-win-core-localization-l1-2-0.dll
    cp -f api_ms_win_core_memory_l1_1_0.dll $Path64Bit/api-ms-win-core-memory-l1-1-0.dll
    cp -f api_ms_win_core_namedpipe_l1_1_0.dll $Path64Bit/api-ms-win-core-namedpipe-l1-1-0.dll
    cp -f api_ms_win_core_processenvironment_l1_1_0.dll $Path64Bit/api-ms-win-core-processenvironment-l1-1-0.dll
    cp -f api_ms_win_core_processthreads_l1_1_0.dll $Path64Bit/api-ms-win-core-processthreads-l1-1-0.dll
    cp -f api_ms_win_core_processthreads_l1_1_1.dll $Path64Bit/api-ms-win-core-processthreads-l1-1-1.dll
    cp -f api_ms_win_core_profile_l1_1_0.dll $Path64Bit/api-ms-win-core-profile-l1-1-0.dll
    cp -f api_ms_win_core_rtlsupport_l1_1_0.dll $Path64Bit/api-ms-win-core-rtlsupport-l1-1-0.dll
    cp -f api_ms_win_core_string_l1_1_0.dll $Path64Bit/api-ms-win-core-string-l1-1-0.dll
    cp -f api_ms_win_core_synch_l1_1_0.dll $Path64Bit/api-ms-win-core-synch-l1-1-0.dll
    cp -f api_ms_win_core_synch_l1_2_0.dll $Path64Bit/api-ms-win-core-synch-l1-2-0.dll
    cp -f api_ms_win_core_sysinfo_l1_1_0.dll $Path64Bit/api-ms-win-core-sysinfo-l1-1-0.dll
    cp -f api_ms_win_core_timezone_l1_1_0.dll $Path64Bit/api-ms-win-core-timezone-l1-1-0.dll
    cp -f api_ms_win_core_util_l1_1_0.dll $Path64Bit/api-ms-win-core-util-l1-1-0.dll
    cp -f api_ms_win_crt_conio_l1_1_0.dll $Path64Bit/api-ms-win-crt-conio-l1-1-0.dll
    cp -f api_ms_win_crt_convert_l1_1_0.dll $Path64Bit/api-ms-win-crt-convert-l1-1-0.dll
    cp -f api_ms_win_crt_environment_l1_1_0.dll $Path64Bit/api-ms-win-crt-environment-l1-1-0.dll
    cp -f api_ms_win_crt_filesystem_l1_1_0.dll $Path64Bit/api-ms-win-crt-filesystem-l1-1-0.dll
    cp -f api_ms_win_crt_heap_l1_1_0.dll $Path64Bit/api-ms-win-crt-heap-l1-1-0.dll
    cp -f api_ms_win_crt_locale_l1_1_0.dll $Path64Bit/api-ms-win-crt-locale-l1-1-0.dll
    cp -f api_ms_win_crt_math_l1_1_0.dll $Path64Bit/api-ms-win-crt-math-l1-1-0.dll
    cp -f api_ms_win_crt_multibyte_l1_1_0.dll $Path64Bit/api-ms-win-crt-multibyte-l1-1-0.dll
    cp -f api_ms_win_crt_private_l1_1_0.dll $Path64Bit/api-ms-win-crt-private-l1-1-0.dll
    cp -f api_ms_win_crt_process_l1_1_0.dll $Path64Bit/api-ms-win-crt-process-l1-1-0.dll
    cp -f api_ms_win_crt_runtime_l1_1_0.dll $Path64Bit/api-ms-win-crt-runtime-l1-1-0.dll
    cp -f api_ms_win_crt_stdio_l1_1_0.dll $Path64Bit/api-ms-win-crt-stdio-l1-1-0.dll
    cp -f api_ms_win_crt_string_l1_1_0.dll $Path64Bit/api-ms-win-crt-string-l1-1-0.dll
    cp -f api_ms_win_crt_time_l1_1_0.dll $Path64Bit/api-ms-win-crt-time-l1-1-0.dll
    cp -f api_ms_win_crt_utility_l1_1_0.dll $Path64Bit/api-ms-win-crt-utility-l1-1-0.dll

    POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2019/VC_redist.x64.exe" /Q

    POL_Wine_OverrideDLL "native,builtin" "vcruntime140_1"
fi

POL_Wine_OverrideDLL "native,builtin" "concrt140" "mfc140" "mfc140u" "mfcm140" "mfcm140" "mfcm140u" "msvcp140" "msvcp140_1" "msvcp140_2" "msvcp140_atomic_wait" "msvcp140_codecvt_ids" "ucrtbase" "vcamp140" "vccorlib140" "vcomp140" "vcruntime140" "api-ms-win-core-console-l1-1-0" "api-ms-win-core-datetime-l1-1-0" "api-ms-win-core-debug-l1-1-0" "api-ms-win-core-errorhandling-l1-1-0" "api-ms-win-core-file-l1-1-0" "api-ms-win-core-file-l1-2-0" "api-ms-win-core-file-l2-1-0" "api-ms-win-core-handle-l1-1-0" "api-ms-win-core-heap-l1-1-0" "api-ms-win-core-interlocked-l1-1-0" "api-ms-win-core-libraryloader-l1-1-0" "api-ms-win-core-localization-l1-2-0" "api-ms-win-core-memory-l1-1-0" "api-ms-win-core-namedpipe-l1-1-0" "api-ms-win-core-processenvironment-l1-1-0" "api-ms-win-core-processthreads-l1-1-0" "api-ms-win-core-processthreads-l1-1-1" "api-ms-win-core-profile-l1-1-0" "api-ms-win-core-rtlsupport-l1-1-0" "api-ms-win-core-string-l1-1-0" "api-ms-win-core-synch-l1-1-0" "api-ms-win-core-synch-l1-2-0" "api-ms-win-core-sysinfo-l1-1-0" "api-ms-win-core-timezone-l1-1-0" "api-ms-win-core-util-l1-1-0" "api-ms-win-crt-conio-l1-1-0" "api-ms-win-crt-convert-l1-1-0" "api-ms-win-crt-environment-l1-1-0" "api-ms-win-crt-filesystem-l1-1-0" "api-ms-win-crt-heap-l1-1-0" "api-ms-win-crt-locale-l1-1-0" "api-ms-win-crt-math-l1-1-0" "api-ms-win-crt-multibyte-l1-1-0" "api-ms-win-crt-private-l1-1-0" "api-ms-win-crt-process-l1-1-0" "api-ms-win-crt-runtime-l1-1-0" "api-ms-win-crt-stdio-l1-1-0" "api-ms-win-crt-string-l1-1-0" "api-ms-win-crt-time-l1-1-0" "api-ms-win-crt-utility-l1-1-0"

rm -rf $POL_USER_ROOT/tmp/vcrun2019
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYWKyLgAKCRDlMfrJqhPK
R+3wAKCWp2KaavSDsReLYnThrHnYfNSEhgCfQw4UhUZCp4mrgV1UFdKMC3zwyVo=
=yJuI
-----END PGP SIGNATURE-----
