#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2012-04-25 21-49)
#   Initial release
# [SuperPlumus] (2013-12-08 18-49)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="ISIS Draw 2.3"
PREFIX="IsisDraw23"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Isis Draw" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "$PREFIX"

cd "$POL_System_TmpDir"
POL_Download "$SITE/divers/Draw23.exe" "a6c9b6cc783ba833d3b149a0fa854719"
POL_Call POL_Install_LunaTheme
POL_Wine_WaitBefore "$TITLE"
POL_Wine "Draw23.exe"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "IDraw32.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKksbIACgkQ5TH6yaoTykfw+ACgmq0pRslL4PXnoMWtBstSZYtb
MuoAn2zEkq8VOwSi6371OIUD9BtSQPEu
=EQFI
-----END PGP SIGNATURE-----
