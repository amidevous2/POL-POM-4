#!/bin/bash
 
# Date : (16.10.2014 15:50)
# Distribution used to test : Ubuntu 14.04
# Author : wwfkk

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Camfrog Video Chat"
PREFIX="CamfrogVideoChat"

POL_GetSetupImages "http://i.imgur.com/sdM1c0o.jpg" "http://i.imgur.com/CxZtqm6.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Camfrog Video Chat" "http://www.camfrog.com/" "wwfkk" "$PREFIX"

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.7.22"

POL_Call POL_Install_LunaTheme
POL_Call POL_Function_FontsSmoothRGB
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msls31
POL_Call POL_Install_msxml3
POL_Call POL_Install_riched20
POL_Call POL_Install_DisableCrashDialog
POL_Call POL_Install_ie8
 
cd "$WINEPREFIX/drive_c"
POL_Download "https://download.camfrog.com/distr/camfrog.exe"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "camfrog.exe"
 
POL_Shortcut "Camfrog Video Chat.exe" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRApXgACgkQ5TH6yaoTykfTsQCgsdV5M1XfoKZKjeEwQVc36VGA
VuUAnjfcrpk/dgDSDJrx2Dxsg6CDFxMB
=5pvQ
-----END PGP SIGNATURE-----
