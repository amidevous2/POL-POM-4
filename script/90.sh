#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Pluto Strikes Back"

#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Pluto Strikes Back" "Kloonigames" "http://www.kloonigames.com/blog/games/pluto/" "Twinoatl" "PlutoStrikesBack"

POL_Wine_SelectPrefix "PlutoStrikesBack"
POL_Wine_PrefixCreate

cd $WINEPREFIX/drive_c || POL_SetupWindow_Fatal "Drive_c does not exist"
POL_Download "http://www.kloonigames.com/download.php?file=pluto_r1.5.zip"

mv "download.php?file=pluto_r1.5.zip" pluto_r1.5.zip 

POL_SetupWindow_Wait "Extracting the game and the libraries" "Extracting..."
unzip pluto_r1.5.zip

POL_Call POL_Install_vcrun6

POL_Shortcut "pluto.exe" "Pluto Strikes Back"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOUqVQACgkQ5TH6yaoTykdX4wCggjVNx4MFdUUPW23H70H6zA03
J+MAoKVPb0PWB3bQNjnvA+5Wx+MJ28hN
=ORa4
-----END PGP SIGNATURE-----
