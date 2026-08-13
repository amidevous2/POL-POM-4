#!/bin/bash
# Date : (2009-06-26 13-00)
# Last revision : (2009-06-26 13-00)
# Wine version used : N/A
# Distribution used to test : N/A
# Author : thib25
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_Init
POL_SetupWindow_presentation "Opera" "Opera Software ASA" "http://www.opera.com/" "thib25" "Opera"

select_prefixe "$REPERTOIRE/wineprefix/Opera"
POL_SetupWindow_prefixcreate 

cd "$REPERTOIRE/wineprefix/Opera/drive_c/"
POL_SetupWindow_download "Downloading Opera..." "Downloading Opera..." "ftp://ftp.task.gda.pl/pub/opera/win/964/int/Opera_964_int_Setup.exe"
POL_SetupWindow_wait_next_signal "Installation in progress..." "Opera"
wine "$REPERTOIRE/wineprefix/Opera/drive_c/Opera_964_int_Setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "Opera" "$PROGRAMFILES/Opera/" "opera.exe" "" "Opera"

POL_SetupWindow_reboot
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJE0ACgkQ5TH6yaoTykfYpgCfXDRLE1oOc3LDB7Pk5WcUFhfX
JLIAnAljqcKIfGRiGVSQ9gBqDHC1Edt2
=UVQG
-----END PGP SIGNATURE-----
