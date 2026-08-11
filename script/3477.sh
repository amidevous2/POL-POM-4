#!/bin/bash
# Date : (2019-04-02 00-12)
# Last revision : (2019-06-26 00-18)
# Distribution used to test : Linux Mint 19.1 Cinnamon - 64-bit
# Author : Yaotl
# PlayOnLinux : 4.3.4

##  Beta script ##


cd "$POL_USER_ROOT/ressources/vcrun2017" "vcrun2017"
POL_Download_Resource "https://aka.ms/vs/15/release/vc_redist.x86.exe" "08d7a23f1a537867d862abd72ec407c9" "vcrun2017" #Version:14.16.27027

S32="$WINEPREFIX/drive_c/windows/system32"
mkdir -p $POL_USER_ROOT/tmp/vcrun2017
cabextract -F 'a10' vc_redist.x86.exe -d $POL_USER_ROOT/tmp/vcrun2017
cabextract -F 'a11' vc_redist.x86.exe -d $POL_USER_ROOT/tmp/vcrun2017
cd $POL_USER_ROOT/tmp/vcrun2017
cabextract a10
cabextract a11 -d $S32

cp concrt140.dll msvcp140.dll msvcp140_1.dll msvcp140_2.dll ucrtbase.dll vcamp140.dll vccorlib140.dll vcomp140.dll vcruntime140.dll $S32
cp api_ms_win_core_console_l1_1_0.dll            $S32/api-ms-win-core-console-l1-1-0.dll
cp api_ms_win_core_datetime_l1_1_0.dll           $S32/api-ms-win-core-datetime-l1-1-0.dll
cp api_ms_win_core_debug_l1_1_0.dll              $S32/api-ms-win-core-debug-l1-1-0.dll
cp api_ms_win_core_errorhandling_l1_1_0.dll      $S32/api-ms-win-core-errorhandling-l1-1-0.dll
cp api_ms_win_core_file_l1_1_0.dll               $S32/api-ms-win-core-file-l1-1-0.dll
cp api_ms_win_core_file_l1_2_0.dll               $S32/api-ms-win-core-file-l1-2-0.dll
cp api_ms_win_core_file_l2_1_0.dll               $S32/api-ms-win-core-file-l2-1-0.dll
cp api_ms_win_core_handle_l1_1_0.dll             $S32/api-ms-win-core-handle-l1-1-0.dll
cp api_ms_win_core_heap_l1_1_0.dll               $S32/api-ms-win-core-heap-l1-1-0.dll
cp api_ms_win_core_interlocked_l1_1_0.dll        $S32/api-ms-win-core-interlocked-l1-1-0.dll
cp api_ms_win_core_libraryloader_l1_1_0.dll      $S32/api-ms-win-core-libraryloader-l1-1-0.dll
cp api_ms_win_core_localization_l1_2_0.dll       $S32/api-ms-win-core-localization-l1-2-0.dll
cp api_ms_win_core_memory_l1_1_0.dll             $S32/api-ms-win-core-memory-l1-1-0.dll
cp api_ms_win_core_namedpipe_l1_1_0.dll          $S32/api-ms-win-core-namedpipe-l1-1-0.dll
cp api_ms_win_core_processenvironment_l1_1_0.dll $S32/api-ms-win-core-processenvironment-l1-1-0.dll
cp api_ms_win_core_processthreads_l1_1_0.dll     $S32/api-ms-win-core-processthreads-l1-1-0.dll
cp api_ms_win_core_processthreads_l1_1_1.dll     $S32/api-ms-win-core-processthreads-l1-1-1.dll
cp api_ms_win_core_profile_l1_1_0.dll            $S32/api-ms-win-core-profile-l1-1-0.dll
cp api_ms_win_core_rtlsupport_l1_1_0.dll         $S32/api-ms-win-core-rtlsupport-l1-1-0.dll
cp api_ms_win_core_string_l1_1_0.dll             $S32/api-ms-win-core-string-l1-1-0.dll
cp api_ms_win_core_synch_l1_1_0.dll              $S32/api-ms-win-core-synch-l1-1-0.dll
cp api_ms_win_core_synch_l1_2_0.dll              $S32/api-ms-win-core-synch-l1-2-0.dll
cp api_ms_win_core_sysinfo_l1_1_0.dll            $S32/api-ms-win-core-sysinfo-l1-1-0.dll
cp api_ms_win_core_timezone_l1_1_0.dll           $S32/api-ms-win-core-timezone-l1-1-0.dll
cp api_ms_win_core_util_l1_1_0.dll               $S32/api-ms-win-core-util-l1-1-0.dll
cp api_ms_win_crt_conio_l1_1_0.dll               $S32/api-ms-win-crt-conio-l1-1-0.dll
cp api_ms_win_crt_convert_l1_1_0.dll             $S32/api-ms-win-crt-convert-l1-1-0.dll
cp api_ms_win_crt_environment_l1_1_0.dll         $S32/api-ms-win-crt-environment-l1-1-0.dll
cp api_ms_win_crt_filesystem_l1_1_0.dll          $S32/api-ms-win-crt-filesystem-l1-1-0.dll
cp api_ms_win_crt_heap_l1_1_0.dll                $S32/api-ms-win-crt-heap-l1-1-0.dll
cp api_ms_win_crt_locale_l1_1_0.dll              $S32/api-ms-win-crt-locale-l1-1-0.dll
cp api_ms_win_crt_math_l1_1_0.dll                $S32/api-ms-win-crt-math-l1-1-0.dll
cp api_ms_win_crt_multibyte_l1_1_0.dll           $S32/api-ms-win-crt-multibyte-l1-1-0.dll
cp api_ms_win_crt_private_l1_1_0.dll             $S32/api-ms-win-crt-private-l1-1-0.dll
cp api_ms_win_crt_process_l1_1_0.dll             $S32/api-ms-win-crt-process-l1-1-0.dll
cp api_ms_win_crt_runtime_l1_1_0.dll             $S32/api-ms-win-crt-runtime-l1-1-0.dll
cp api_ms_win_crt_stdio_l1_1_0.dll               $S32/api-ms-win-crt-stdio-l1-1-0.dll
cp api_ms_win_crt_string_l1_1_0.dll              $S32/api-ms-win-crt-string-l1-1-0.dll
cp api_ms_win_crt_time_l1_1_0.dll                $S32/api-ms-win-crt-time-l1-1-0.dll
cp api_ms_win_crt_utility_l1_1_0.dll             $S32/api-ms-win-crt-utility-l1-1-0.dll

if [ "$POL_ARCH" = "amd64" ]; then
    cd "$POL_USER_ROOT/ressources/vcrun2017" "vcrun2017"
    POL_Download_Resource "https://aka.ms/vs/15/release/vc_redist.x64.exe" "0af5748a2e790472af28e64105760eb7" "vcrun2017" #Version:14.16.27027

    S64="$WINEPREFIX/drive_c/windows/syswow64"
    mkdir -p $POL_USER_ROOT/tmp/vcrun2017/x64
    cabextract -F 'a10' vc_redist.x64.exe -d $POL_USER_ROOT/tmp/vcrun2017/x64
    cabextract -F 'a11' vc_redist.x64.exe -d $POL_USER_ROOT/tmp/vcrun2017/x64
    cd $POL_USER_ROOT/tmp/vcrun2017/x64
    cabextract a10
    cabextract a11 -d $S64

    cp concrt140.dll msvcp140.dll msvcp140_1.dll msvcp140_2.dll ucrtbase.dll vcamp140.dll vccorlib140.dll vcomp140.dll vcruntime140.dll $S64
    cp api_ms_win_core_console_l1_1_0.dll            $S64/api-ms-win-core-console-l1-1-0.dll
    cp api_ms_win_core_datetime_l1_1_0.dll           $S64/api-ms-win-core-datetime-l1-1-0.dll
    cp api_ms_win_core_debug_l1_1_0.dll              $S64/api-ms-win-core-debug-l1-1-0.dll
    cp api_ms_win_core_errorhandling_l1_1_0.dll      $S64/api-ms-win-core-errorhandling-l1-1-0.dll
    cp api_ms_win_core_file_l1_1_0.dll               $S64/api-ms-win-core-file-l1-1-0.dll
    cp api_ms_win_core_file_l1_2_0.dll               $S64/api-ms-win-core-file-l1-2-0.dll
    cp api_ms_win_core_file_l2_1_0.dll               $S64/api-ms-win-core-file-l2-1-0.dll
    cp api_ms_win_core_handle_l1_1_0.dll             $S64/api-ms-win-core-handle-l1-1-0.dll
    cp api_ms_win_core_heap_l1_1_0.dll               $S64/api-ms-win-core-heap-l1-1-0.dll
    cp api_ms_win_core_interlocked_l1_1_0.dll        $S64/api-ms-win-core-interlocked-l1-1-0.dll
    cp api_ms_win_core_libraryloader_l1_1_0.dll      $S64/api-ms-win-core-libraryloader-l1-1-0.dll
    cp api_ms_win_core_localization_l1_2_0.dll       $S64/api-ms-win-core-localization-l1-2-0.dll
    cp api_ms_win_core_memory_l1_1_0.dll             $S64/api-ms-win-core-memory-l1-1-0.dll
    cp api_ms_win_core_namedpipe_l1_1_0.dll          $S64/api-ms-win-core-namedpipe-l1-1-0.dll
    cp api_ms_win_core_processenvironment_l1_1_0.dll $S64/api-ms-win-core-processenvironment-l1-1-0.dll
    cp api_ms_win_core_processthreads_l1_1_0.dll     $S64/api-ms-win-core-processthreads-l1-1-0.dll
    cp api_ms_win_core_processthreads_l1_1_1.dll     $S64/api-ms-win-core-processthreads-l1-1-1.dll
    cp api_ms_win_core_profile_l1_1_0.dll            $S64/api-ms-win-core-profile-l1-1-0.dll
    cp api_ms_win_core_rtlsupport_l1_1_0.dll         $S64/api-ms-win-core-rtlsupport-l1-1-0.dll
    cp api_ms_win_core_string_l1_1_0.dll             $S64/api-ms-win-core-string-l1-1-0.dll
    cp api_ms_win_core_synch_l1_1_0.dll              $S64/api-ms-win-core-synch-l1-1-0.dll
    cp api_ms_win_core_synch_l1_2_0.dll              $S64/api-ms-win-core-synch-l1-2-0.dll
    cp api_ms_win_core_sysinfo_l1_1_0.dll            $S64/api-ms-win-core-sysinfo-l1-1-0.dll
    cp api_ms_win_core_timezone_l1_1_0.dll           $S64/api-ms-win-core-timezone-l1-1-0.dll
    cp api_ms_win_core_util_l1_1_0.dll               $S64/api-ms-win-core-util-l1-1-0.dll
    cp api_ms_win_crt_conio_l1_1_0.dll               $S64/api-ms-win-crt-conio-l1-1-0.dll
    cp api_ms_win_crt_convert_l1_1_0.dll             $S64/api-ms-win-crt-convert-l1-1-0.dll
    cp api_ms_win_crt_environment_l1_1_0.dll         $S64/api-ms-win-crt-environment-l1-1-0.dll
    cp api_ms_win_crt_filesystem_l1_1_0.dll          $S64/api-ms-win-crt-filesystem-l1-1-0.dll
    cp api_ms_win_crt_heap_l1_1_0.dll                $S64/api-ms-win-crt-heap-l1-1-0.dll
    cp api_ms_win_crt_locale_l1_1_0.dll              $S64/api-ms-win-crt-locale-l1-1-0.dll
    cp api_ms_win_crt_math_l1_1_0.dll                $S64/api-ms-win-crt-math-l1-1-0.dll
    cp api_ms_win_crt_multibyte_l1_1_0.dll           $S64/api-ms-win-crt-multibyte-l1-1-0.dll
    cp api_ms_win_crt_private_l1_1_0.dll             $S64/api-ms-win-crt-private-l1-1-0.dll
    cp api_ms_win_crt_process_l1_1_0.dll             $S64/api-ms-win-crt-process-l1-1-0.dll
    cp api_ms_win_crt_runtime_l1_1_0.dll             $S64/api-ms-win-crt-runtime-l1-1-0.dll
    cp api_ms_win_crt_stdio_l1_1_0.dll               $S64/api-ms-win-crt-stdio-l1-1-0.dll
    cp api_ms_win_crt_string_l1_1_0.dll              $S64/api-ms-win-crt-string-l1-1-0.dll
    cp api_ms_win_crt_time_l1_1_0.dll                $S64/api-ms-win-crt-time-l1-1-0.dll
    cp api_ms_win_crt_utility_l1_1_0.dll             $S64/api-ms-win-crt-utility-l1-1-0.dll
fi

POL_Wine_OverrideDLL "native,builtin" "concrt140" "mfc140" "mfc140u" "mfcm140" "mfcm140u" "msvcp140" "msvcp140_1" "msvcp140_2" "ucrtbase" "vcamp140" "vccorlib140" "vcomp140" "vcruntime140"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-console-l1-1-0"        "api-ms-win-core-datetime-l1-1-0"    "api-ms-win-core-debug-l1-1-0"              "api-ms-win-core-errorhandling-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-file-l1-1-0"           "api-ms-win-core-file-l1-2-0"        "api-ms-win-core-file-l2-1-0"               "api-ms-win-core-handle-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-heap-l1-1-0"           "api-ms-win-core-interlocked-l1-1-0" "api-ms-win-core-libraryloader-l1-1-0"      "api-ms-win-core-localization-l1-2-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-memory-l1-1-0"         "api-ms-win-core-namedpipe-l1-1-0"   "api-ms-win-core-processenvironment-l1-1-0" "api-ms-win-core-processthreads-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-processthreads-l1-1-1" "api-ms-win-core-profile-l1-1-0"     "api-ms-win-core-rtlsupport-l1-1-0"         "api-ms-win-core-string-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-synch-l1-1-0"          "api-ms-win-core-synch-l1-2-0"       "api-ms-win-core-sysinfo-l1-1-0"            "api-ms-win-core-timezone-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-core-util-l1-1-0"           "api-ms-win-crt-conio-l1-1-0"        "api-ms-win-crt-convert-l1-1-0"             "api-ms-win-crt-environment-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-filesystem-l1-1-0"      "api-ms-win-crt-heap-l1-1-0"         "api-ms-win-crt-locale-l1-1-0"              "api-ms-win-crt-math-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-multibyte-l1-1-0"       "api-ms-win-crt-private-l1-1-0"      "api-ms-win-crt-process-l1-1-0"             "api-ms-win-crt-runtime-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-stdio-l1-1-0"           "api-ms-win-crt-string-l1-1-0"       "api-ms-win-crt-time-l1-1-0"                "api-ms-win-crt-utility-l1-1-0"

rm -rf $POL_USER_ROOT/tmp/vcrun2017
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXWo9VQAKCRDlMfrJqhPK
R94KAJ4lJxQeQLysrwliBYY+3lmOCCyyFgCaAlFMUaHtKWPzZrRUZ2ZQBUoObBI=
=dlib
-----END PGP SIGNATURE-----
