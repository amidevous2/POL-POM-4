#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

cfg_check

POL_SetupWindow_Init
POL_SetupWindow_presentation "UFO : Enemy Unknown" "Microprose" "http://www.xcomufo.com" "Benji64" "Ufo1"

select_prefixe "$REPERTOIRE/wineprefix/Ufo1"
POL_SetupWindow_prefixcreate

cd "$REPERTOIRE/wineprefix/Ufo1/drive_c/"
POL_SetupWindow_download "Downloading UFO : Enemy Unknown..." "Downloading UFO : Enemy Unknown..." "http://tele500.abandonware-france.org/jeux/jeu-216-ufo.zip"
POL_SetupWindow_wait_next_signal "Installation in progress..." "UFO : Enemy Unknown"
mkdir ufo
unzip jeu-216-ufo.zip -d ufo/
rm jeu-216-ufo.zip
cd ufo
wine UFO.exe
rm UFO.exe
POL_SetupWindow_detect_exit


LNG_GAME_DESKTOP_ICONE="Créer un racourcis sur le bureau?"
LNG_GAME_MENU_ICONE="Créer un racourcis dans le menu?"
creer_lanceur_dos "Ufo1" "ufo" "GO.BAT" "" "UFO : Enemy Unknown"

POL_SetupWindow_reboot
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEgACgkQ5TH6yaoTykerhQCgrhi49pD+rA/HR7YAj4Irj/Gi
ElIAoJ5Xq8P8blF+AD/TQpwr6LxcZCpO
=GGod
-----END PGP SIGNATURE-----
