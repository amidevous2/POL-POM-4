#!/bin/bash
# Date : (2009-09-17 18-00)
# Last revision : (2009-09-17 18-00)
# Wine version used : 1.1.29
# Distribution used to test : Fedora 11
# Author : NSLW
# Licence : Retail
# Depend : unzip, icotools

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable

TYTUL="Re-Volt"
PREFIX="ReVolt"
ABANDONIASUM="39c68216faf3af9c2e30afede4d9e46dea034dfd"
UTOPIASUM="8f45478076c8b5ccd327ce2ce6163f3b20f58114"


POL_SetupWindow_Init 

POL_SetupWindow_presentation "$TYTUL" "Acclaim Entertainment" "N/A" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

cd "$REPERTOIRE/ressources"

POL_SetupWindow_message "Please download Re-Volt by yourself\nhttp://www.abandonia.com/en/downloadgame/908" "$TYTUL"
browser http://www.abandonia.com/en/downloadgame/908

REVOLTSUM="$ABANDONIASUM"
POL_SetupWindow_browse "Select Re-Volt.zip archive" "$TYTUL" ""
REVOLTARCHIVE="$APP_ANSWER"

POL_SetupWindow_prefixcreate
cd "$WINEPREFIX/drive_c"


if [ "$REVOLTSUM" == "$UTOPIASUM" ]; then

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
unzip "$REVOLTARCHIVE"
cd "./Re-Volt"
wine Re-Volt.part01.exe -s
rm -f Re-Volt.part*
POL_SetupWindow_detect_exit

elif [ "$REVOLTSUM" == "$ABANDONIASUM" ]; then

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
unzip "$REVOLTARCHIVE"
POL_SetupWindow_detect_exit

fi

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about memory size
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-890-1024-2048" "-" "256"
VMS="$APP_ANSWER"

cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

echo "[HKEY_LOCAL_MACHINE\\Software\\Acclaim\\Re-Volt\\1.0]" > 24bit.reg
echo "\"Texture24\"=dword:1" >> 24bit.reg
regedit 24bit.reg

#cleaning temp

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX"  "REVOLT.EXE" "$TYTUL"

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFUACgkQ5TH6yaoTykda9gCeON0qtJxdfnGKi/oRDxIm9+EU
B3oAnip1um9bh6I5YC6onTnk5k96CXFb
=2w7P
-----END PGP SIGNATURE-----
