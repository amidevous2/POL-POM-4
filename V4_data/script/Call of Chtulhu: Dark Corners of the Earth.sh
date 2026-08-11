#!/bin/bash
# Last Revision: (2010-03-28)
# Distribution used to test: Ubuntu 9.10
# Wine version used: 1.1.25
# Author: Bacatta
# Script updated by: Jompa
[ "$PLAYONLINUX" = "" ] && exit 0 
#
# CHANGELOG
# [Bacatta] (2010-03-28)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Standardize.
 
source "$PLAYONLINUX/lib/sources"
 
Title="Call of Chtulhu: Dark Corners of the Earth"
Prefix="CoCDCotE"
 
if [ "$POL_LANG" = "sv" ]; then
LNG_MEM="Hur mycke minne har ditt grafikkort?"
LNG_INSTALL="Installerar..."
else
LNG_MEM="How much memory do your graphic card have got?"
LNG_INSTALL="Installing..."
fi
 
POL_SetupWindow_Init 
 
#Presentation
POL_SetupWindow_presentation "$Title" "Bethesda Softworks" "http://www.callofcthulhu.com/" "Bacatta" "$Prefix"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate
 
# fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
POL_SetupWindow_menu "$LNG_MEM" "$Title" "32-64-128-256-384-512-768-896-1024-2048" "-" "128"
VMS="$APP_ANSWER"
 
# Setup Direct3D
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"OffscreenRenderingMode\"=\"fbo\"" >> OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
regedit OGL.reg
 
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$Title"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit
 
POL_Shortcut "CoCDCoTELauncher.exe" "$TITLE" "" "" "Game;"
        
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlIzogAKCRDlMfrJqhPK
R/NwAJ9LnUIF7rYxwZYrQCc7rRNSCKzDKgCbBPFoKtfT03U939q2Rc+S/qD2GBU=
=RRp+
-----END PGP SIGNATURE-----
