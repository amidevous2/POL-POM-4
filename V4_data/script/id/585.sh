#!/usr/bin/env playonlinux-bash
# Date :
# Last revision :
# Wine version used : 1.7.49
# Distribution used to test : Ubuntu Karmic
# Author : wrigh347, Lennart Hansen - lahansen@gmail.com
# Depend : DirectX 9

# Application Specific Vars
TITLE="Poker Stove"
PREFIX="Poker_Stove"
APPEXEC="PokerStove.exe"
APPLINK="https://raw.githubusercontent.com/andrewprock/pokerstove/master/win32/PokerStoveSetup124.exe"
APPMD5="264ff501feb42e2610b9dd190e06fb80"
WINE="1.7.49"

# Install specific vars
ICONDIR="$HOME/.PlayOnLinux/icones"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Andrew Prock" "http://www.pokerstove.com/" "lennybhoy" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE"

POL_Wine_InstallFonts

POL_Download "$APPLINK" "$APPMD5"

APPINSTALLEXEC=$(basename $APPLINK)
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APPINSTALLEXEC"

POL_Wine_reboot

POL_Shortcut "$APPEXEC" "$TITLE" "$TITLE.png" ""

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXUv1MACgkQ5TH6yaoTykceOwCePgwLcgM6nNSNGatFe9AKH6YY
JxUAn3CARn8PxQDSGHuP2issENLs2dJK
=Rzw6
-----END PGP SIGNATURE-----
