#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Supaplex"
PREFIX="Supaplex"
  
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "" "Quentin PÂRIS" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.6.2-dos_support_0.6"
 
cd "$WINEPREFIX/drive_c"
POL_Download "http://www.elmerproductions.com/sp/software/supaplex.zip" "50643570a58c8f13a79d49eab199aba8"
unzip supaplex.zip
  
POL_Shortcut "spfix63.exe" "$TITLE" "Game;LogicGame;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOXNFQAKCRDlMfrJqhPK
RzSxAKCgsLjK5aur2IspiJBpbLZgEPQ7lACeJkwwZu0WKeFs9xG5bfB8X0iTDn8=
=eFe5
-----END PGP SIGNATURE-----
