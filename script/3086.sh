#!/bin/bash
# Date :  2016-12-04 20:00
# Last revision :
# Wine version used : 1.9.24
# Distributions used to test : manjaro x64
# Author : ThanosApostolou
# Depend :
#
# CHANGELOG
# [Dadu042] (2016-12-04 20:00)
#   Initial script.
# [Dadu042] (2020-01-30 13:30)
#   Wine 1.9.24 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Medieval II Total War"
PREFIX="Medieval II Total War"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Creative Assembly" "https://www.totalwar.com/" "ThanosAPostolou" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
 
# Libraries overrides:
POL_Wine_OverrideDLL "native,builtin" "msvcp71"
POL_Wine_OverrideDLL "native,builtin" "msvcr71"

 
# Choose mounted image:
POL_SetupWindow_message "$(eval_gettext 'Please insert $TITLE media into your disk drive.')"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

#starting installation:
POL_Wine_WaitBefore "$TITLE"
cd "$CDROM"
POL_Wine "setup.exe"
POL_Wine_WaitExit "$TITLE"

 
POL_SetupWindow_VMS "64"
POL_Wine_reboot
 
POL_Shortcut "medieval2.exe" "$TITLE" "$TITLE.png" "" "Game;"
POL_SetupWindow_Close
 
exit 0 
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNYRgAKCRDlMfrJqhPK
R7aBAJ9wRpBFNnA1XRYC3Jic70PhXetIgACfZEJwhA4XSxRS+OsEQja/AregKe0=
=CkRF
-----END PGP SIGNATURE-----
