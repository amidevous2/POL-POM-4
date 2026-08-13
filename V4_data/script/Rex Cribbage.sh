#!/usr/bin/env playonlinux-bash
# Date : (2015-03-27 09-57)
# Last revision : (2015-03-27 12-55)
# Wine version used : 1.7.39
# Distribution used to test : Linux Mint 17.1 LTS
# Author : Will Wright
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Rex Cribbage"
PREFIX="Rex_Cribbage"

WINEVERSION="1.7.39"
 
POL_SetupWindow_Init

POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Hal Mueller" "http://www.halscrib.com" "Will Wright" "$PREFIX"
 
# Create a 32bit virtual drive
POL_System_SetArch "x86"

POL_SetupWindow_InstallMethod "LOCAL,CD"

if [ "$INSTALL_METHOD" = "CD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "installrex.exe"
        INSTALLER="$CDROM_SETUP"
        cd "$CDROM"
else
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "Rex Cribbage installation"
        INSTALLER="$APP_ANSWER"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "winxp"

POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "hhctrl.ocx"
POL_Wine_OverrideDLL "native,builtin" "odbc32"
POL_Wine_OverrideDLL "native,builtin" "odbccp32"
POL_Wine_OverrideDLL "native,builtin" "riched32"
POL_Wine_OverrideDLL "native,builtin" "urlmon"
POL_Wine_OverrideDLL "builtin" "ole32"
POL_Wine_OverrideDLL "builtin" "oleaut32"
POL_Wine_OverrideDLL "builtin" "olepro32"
POL_Wine_OverrideDLL "builtin" "rpcrt4"

POL_Wine_WaitExit "$TITLE"
POL_Wine "$INSTALLER"
 
POL_Shortcut "REXCRIB.EXE" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUVnfwACgkQ5TH6yaoTykdYMACgnsFuCMgqmJun6ZMJlCdNfSop
bT4AoJSjgZZkM6J1IThZhCPRy89QFz1N
=IOkt
-----END PGP SIGNATURE-----
