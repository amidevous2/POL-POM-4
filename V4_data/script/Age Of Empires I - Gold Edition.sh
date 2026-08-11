#!/bin/bash

# CHANGELOG
# [?] (2014)
#   First script.
# [Dadu042] (2019-11-05)
#   Wine 1.7.22 -> 2.22 (this sould debug some user cases).

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
POL_Wine_PrefixCreate "2.22"

POL_Wine --ignore-errors "$CDROM/$SETUPFILE" 
POL_Wine_WaitExit

cd "$WINEPREFIX/drive_c/windows/system32"
POL_Download "$SITE/divers/dplaydlls-win98se.tar.bz2" "2cc36b915b901e7656ad3b533f83aa7d"
#tar -xvf dplaydlls-win98se.tar.bz2

#POL_Wine_OverrideDLL native,builtin dplayx dpnet dpnhpast dpwsockx

POL_Shortcut "EMPIRES.EXE" "Age Of Empire I"
POL_Shortcut "EMPIRESX.EXE" "Age Of Empire I - Extension"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcH+mgAKCRDlMfrJqhPK
R4eLAJ4gjg5OB/E5W3VZiw2YlpnxyQYaJgCgmcLVXFv5rSTTDPwwzEg1Ed46OK0=
=Mzp5
-----END PGP SIGNATURE-----
