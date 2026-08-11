#!/bin/bash
# Changelog:
# (2014-07-06 00:50) - code standarization, initializing debug, add information
#                      about licence, add information in English
# (2014-07-06 13:33) - correct English translation, delete Polish section
# (2014-07-06 13:50) - code standarization (eval_gettext)
# (2014-07-06 15:20) - delete last window, replace POL_SetupWindow_wait_next_signal
#                      to POL_Wine_WaitBefore, delete POL_SetupWindow_detect_exit
#
# Date : (2014-07-06 15-30)
# Last revision : (2014-07-06 15-30)
# Wine version used : 1.7.21
# Distribution used to test : Linux Mint 17 "Qiana"
# Author : OdzioM
# Licence : Freeware
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="WTW"
PREFIX="WTWLinux"
WORKING_WINE_VERSION="1.7.21"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Tomek Nagisa (Kaworu)" "http://wtw.im/" "OdzioM" "$PREFIX"
 
POL_System_TmpCreate "WTWim"
cd "$POL_System_TmpDir"

POL_Download "http://download.k2t.eu/wtwInst/wtw-setup-web.exe"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_message "$(eval_gettext "After WTW instalation uncheck Run option in last window.\nDon't run a messenger, because it will won't work correctly.")" "$(eval_gettext 'Warning')"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/wtw-setup-web.exe"
 
POL_Call POL_Install_tahoma
POL_Call POL_Install_corefonts
POL_Call POL_Install_dsound
POL_Call POL_Install_ie8
 
POL_Shortcut "wtw.exe" "$TITLE"
 
POL_System_TmpDelete
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlZKSyEACgkQ5TH6yaoTykdFpgCbBzo0WeKiQLjIbqcoklceZ8C5
sTAAnjrKuY3y/JJAatiDRk0brkEyFZOz
=tEL9
-----END PGP SIGNATURE-----
