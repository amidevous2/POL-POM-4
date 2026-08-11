#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi

source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init
POL_SetupWindow_free_presentation  "Jedi Knight II" "Bienvenue dans le script d'installation du patch 1.04 pour Jedi Knight II"
POL_SetupWindow_wait_next_signal "Downloading ..."
select_prefixe "$REPERTOIRE/wineprefix/JediKnightII"

cd "$REPERTOIRE/tmp/"
wget ftp://ftp.lucasarts.com/patches/pc/JKIIUp104.exe -q
POL_SetupWindow_wait_next_signal "Installing ..."
wine ./JKIIUp104.exe
#rm ./JKIIUp104.exe
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJDwACgkQ5TH6yaoTykc50gCfdw/sxL30n+62xws2vI/7TXZw
TKsAnjXmUBXgLy082eJrxj5kE7ZCKBLi
=W74I
-----END PGP SIGNATURE-----
