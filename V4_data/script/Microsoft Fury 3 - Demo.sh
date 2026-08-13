#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#
# CHANGELOG
# [Quentin PÂRIS] (2009 ?)
#   Initial script.
# [Dadu042] (2020-01-22 13:30)
#   Wine 1.4 -> 2.22
#   Repair download link.

# KNOWN ISSUES:
#  - Wine amd64-x86 3.0.3, 3.20: keyboard does not work.
  
TITLE="Microsoft Fury 3 - Demo"
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com" "Tinou" "Fury3Demo"
 
POL_Wine_SelectPrefix "Fury3Demo"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "2.22"
 
cd "$WINEPREFIX/drive_c"

# Dead link as of 2020-01-30
# POL_Download "ftp://ftp.microsoft.com/deskapps/games/public/Fury3/FURYDEMO.EXE" "7a52389925a7d305f57cc95d36e56382"

POL_Download "https://archive.org/download/Fury3_1020/FURY3X.ZIP"
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
POL_System_unzip "FURY3X.ZIP" -d "$WINEPREFIX/drive_c/game/"
   
POL_Wine_OverrideDLL "" "iccvid"
 
 
Set_Managed Off
POL_Shortcut "FURY3X.EXE" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "README.TXT"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNhNgAKCRDlMfrJqhPK
R6tLAKCkKSMpDWmrnVJNjHD/E/D6MjwRTwCbBbofhxxAiRrK6wzm2R3c6Siri6A=
=qjUq
-----END PGP SIGNATURE-----
