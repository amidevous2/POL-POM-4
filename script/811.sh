#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="La Panthere Rose 1 - Passport pour le Danger"
PREFIX="PanthereRose1"
EDITEUR="Wanderlust Interactive"

#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITEUR" "" "Tinou" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4"

POL_System_CopyDirectory "$CDROM/INSTALL/" "$WINEPREFIX/drive_c/Panthere"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
Set_OS win95
POL_System_TmpDelete

Set_Managed Off
POL_Shortcut "PPTP.EXE" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+pAr4ACgkQ5TH6yaoTykfbSgCghD+t9ctQVWGMei9X0iMdUbLL
6c8AoKVnb0VSUMd8Cl3JEh3g/dKu/Bwj
=skmN
-----END PGP SIGNATURE-----
