#!/bin/bash
# 
# CHANGELOG
# [SuperPlumus] (2013-05-11 23-15)
#   Add POL_Wine_WaitExit to fix bug #2278
# [Dadu042] (2019-10-05)
#   Upgrade Wine 1.4.1 to 2.22
#   Force WinXP.
#   Fix installation.
#   Add software category.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="PSPICE 9.1"
WINEVERSION="2.22"
EDITOR="Cadence Design Systems"
EDITOR_URL=""
PREFIX="pspice"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "winxp"

POL_Call POL_Install_LunaTheme
  
mkdir -p "$WINEPREFIX/drive_c/pspice"
cd "$WINEPREFIX/drive_c/pspice"
POL_Download "http://www.eng.auburn.edu/~troppel/91pspstu.exe" "6744a65ee3b3627945f0af0bc774e832"
  
POL_Wine_WaitBefore "$TITLE" --allow-kill
unzip "91pspstu.exe"
# POL_Wine --ignore-errors "Setup.exe"
POL_Wine start /unix "Setup.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
POL_Shortcut "psched.exe"  "$TITLE - Schematics" "" "" "Electronics;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXZgtpAAKCRDlMfrJqhPK
R0aZAJwP5L/1x/+dM/mzmnBntuMOucIzGgCeIj0joznI9ilRAgcv9gaP+tbkb5E=
=rZjg
-----END PGP SIGNATURE-----
