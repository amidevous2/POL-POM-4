#!/bin/bash

# Date : (2017-03-19)
# Wine version used : 1.6
# Distribution used to test : Linux Mint 18.1 Cinnamon
# Author : theel0ja
# Licence : Retail

# Script based on this: https://www.playonlinux.com/en/app-467-Theme_Park_World.html that's modified "Tuesday 22 December 2015 at 21:08" by MTRes
# Works at least with CD distributed by Wendros AB (Nordics)
# BUG: Sounds don't work :(

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="German Truck Simulator"
PREFIX="GermanTruckSimulator"
WINEVERSION="1.6"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "SCS Software" "" "theel0ja" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_SetupWindow_cdrom
POL_Wine_InstallCDROM "d"
 
Set_OS "winxp"
 
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "germantrucks.exe" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNWwIgAKCRDlMfrJqhPK
R8UfAJsGIMVDjV3tZEzWCTKVpOtPDAgUXgCZAb1rzGusApME6fF/+lJOT63Vij0=
=tQh9
-----END PGP SIGNATURE-----
