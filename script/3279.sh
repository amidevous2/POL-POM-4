#!/bin/bash
# BayesFusion GeNIe - Play On Linux script
# Version: 0.1.0
# Installation Requirements:
#       wine 2.22
#		genie_setup.exe (32 bit, version 2.2)
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Globals
TITLE="BayesFusion GeNIe"
PREFIX="GeNIe"
FULL_POL_PREFIX="$HOME/.PlayOnLinux/wineprefix/$PREFIX"
APP_LOCATION="$HOME/.PlayOnLinux/wineprefix/genie/drive_c/Program Files/GeNIe 2.2"
 
# start the installation window
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE"

POL_SetupWindow_message "Before you run the installation setup, be sure to download BayesFusion GeNIe Business or Academic 32-bit version from their website: https://download.bayesfusion.com."

# CHECK FOR INTERNET CONNECTION!!!

# Use unique prefix for installing Wine
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "2.22"

# Picking setup file
POL_SetupWindow_browse "Please set GeNIe setup location"
POL_SetupWindow_message "Please uncheck 'Launch GeNIe' option at the end of installation!"
POL_Wine $APP_ANSWER

# Override dll-s
POL_Shortcut_InsertBeforeWine "export WINEDLLOVERRIDES=\"vcruntime140=n;ucrtbase=n;api-ms-win-core-console-l1-1-0.dll=n;api-ms-win-core-datetime-l1-1-0.dll=n;api-ms-win-core-debug-l1-1-0.dll=n;api-ms-win-core-errorhandling-l1-1-0.dll=n;api-ms-win-core-file-l1-1-0.dll=n;api-ms-win-core-file-l1-2-0.dll=n;api-ms-win-core-file-l2-1-0.dll=n;api-ms-win-core-handle-l1-1-0.dll=n;api-ms-win-core-heap-l1-1-0.dll=n;api-ms-win-core-interlocked-l1-1-0.dll=n;api-ms-win-core-libraryloader-l1-1-0.dll=n;api-ms-win-core-localization-l1-2-0.dll=n;api-ms-win-core-memory-l1-1-0.dll=n;api-ms-win-core-namedpipe-l1-1-0.dll=n;api-ms-win-core-processenvironment-l1-1-0.dll=n;api-ms-win-core-processthreads-l1-1-0.dll=n;api-ms-win-core-processthreads-l1-1-1.dll=n;api-ms-win-core-profile-l1-1-0.dll=n;api-ms-win-core-rtlsupport-l1-1-0.dll=n;api-ms-win-core-string-l1-1-0.dll=n;api-ms-win-core-synch-l1-1-0.dll=n;api-ms-win-core-synch-l1-2-0.dll=n;api-ms-win-core-sysinfo-l1-1-0.dll=n;api-ms-win-core-timezone-l1-1-0.dll=n;api-ms-win-core-util-l1-1-0.dll=n;api-ms-win-crt-conio-l1-1-0.dll=n;api-ms-win-crt-convert-l1-1-0.dll=n;api-ms-win-crt-environment-l1-1-0.dll=n;api-ms-win-crt-filesystem-l1-1-0.dll=n;api-ms-win-crt-heap-l1-1-0.dll=n;api-ms-win-crt-locale-l1-1-0.dll=n;api-ms-win-crt-math-l1-1-0.dll=n;api-ms-win-crt-multibyte-l1-1-0.dll=n;api-ms-win-crt-private-l1-1-0.dll=n;api-ms-win-crt-process-l1-1-0.dll=n;api-ms-win-crt-runtime-l1-1-0.dll=n;api-ms-win-crt-stdio-l1-1-0.dll=n;api-ms-win-crt-string-l1-1-0.dll=n;api-ms-win-crt-time-l1-1-0.dll=n;api-ms-win-crt-utility-l1-1-0.dll=n\""

POL_Shortcut "genie.exe" "GeNIe"

POL_SetupWindow_message "Installation successfully completed."
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNU1pQAKCRDlMfrJqhPK
R7oQAKCKnlzep3Rv/s3wEc5DkZrtJIeUhgCeO+Lfe957kTfSzkeje3fB35j9w1o=
=sW3Z
-----END PGP SIGNATURE-----
