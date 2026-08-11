#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age Of Empires I - Gold Edition"
PREFIX="AgeOfEmpiresI"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Microsoft" "" "Tinou" "$PREFIX" 
POL_SetupWindow_cdrom

SETUPFILE="AOESETUP.EXE"
[ -e "$CDROM/AOEINST.EXE" ] && SETUPFILE="AOEINST.EXE"

POL_SetupWindow_check_cdrom "$SETUPFILE"

POL_Wine_SelectPrefix "$PREFIX" 
POL_Wine_PrefixCreate "1.4-rc1"

POL_Wine --ignore-errors "$CDROM/$SETUPFILE" 
POL_Wine_WaitExit

cd "$WINEPREFIX/drive_c/windows/system32"
POL_Download "$SITE/divers/dplaydlls-win98se.tar.bz2" "2cc36b915b901e7656ad3b533f83aa7d"
tar -xvf dplaydlls-win98se.tar.bz2

POL_Wine_OverrideDLL native,builtin dplayx dpnet dpnhpast dpwsockx


POL_Shortcut "EMPIRES.EXE" "Age Of Empire I"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+MUtwACgkQ5TH6yaoTykdbFACgjevJv8cV3rIGPnZP03P3vdkp
7n0AoI6iOebrW+A39fFLnrtj1qzf7ksF
=AHnM
-----END PGP SIGNATURE-----
