#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

# Traductions
if [ "$POL_LANG" == "fr" ];
then 
	installation="Installation en cours"
	instruction_texte="Merci de sélectionner \"Installation complète\", de décocher \"Placer un icone sur le bureau\" lors de l'installation. A la fin de l'installation merci de décocher \"Lancer le jeu\"."
	instruction_titre="L'installation va commencer"
	resolution_texte="Sélectionnez la résolution du jeu"
	resolution_titre="Résolution"
else 
	installation="Installation underway"
	instruction_texte="Please select \"Installation complete\", uncheck \"Place an icon on the desktop\" during installation. At the end of the installation thank you uncheck \"Start the game\"."
	instruction_titre="Installation will start"
	resolution_texte="Select the resolution of the game"
	resolution_titre="Resolution"
fi 

# Presentation

wget http://upload.wikimedia.org/wikipedia/en/thumb/e/e3/Red_Faction_2_Front.jpg/256px-Red_Faction_2_Front.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "Red Faction II" "THQ" "" "WarsTime" "RedFaction2"

# Vérification du CD
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

# Préparation de Wine
select_prefixe "$REPERTOIRE/wineprefix/RedFaction2"
POL_SetupWindow_prefixcreate
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s $CDROM ./d:

# Instructions pour l'installation du jeu
POL_SetupWindow_message "$instruction_texte" "$instruction_titre"

# Installation du jeu
POL_SetupWindow_wait_next_signal "$installation" "Red Faction II"
wine $CDROM/setup.exe
POL_SetupWindow_detect_exit

# Configuration de Wine
Set_OS winXP

# Configuration du jeu (Quand on lance "Red Faction II.exe" on peut configurer le jeu mais le menu plante)
POL_SetupWindow_menu "$resolution_texte" "$resolution_titre" "640*480~800*640~1024*768~1280*1024~1600*1200" "~"
if [ "$APP_ANSWER" = "640*480" ];
then 
	largeur="640"
	hauteur="480"
elif [ "$APP_ANSWER" = "800*640" ];
then 
	largeur="800"
	hauteur="640"
elif [ "$APP_ANSWER" = "1024*768" ];
then 
	largeur="1024"
	hauteur="768"
elif [ "$APP_ANSWER" = "1280*1024" ];
then 
	largeur="1280"
	hauteur="1024"
else
	largeur="1600"
	hauteur="1200"
fi
cd $WINEPREFIX/drive_c/Program\ Files/THQ/Red\ Faction®\ II/
chmod 744 rf2_config.ini
cat < rf2_config.ini | while read ligne
do
	if [[ "$ligne" = *Screen_width* ]];
	then
		echo "Screen_width = $largeur		; 640, 800, 848, 1024, 1280, 1600, etc" >> rf2_config2.ini;
	elif [[ $ligne == *Screen_height* ]];
	then
		echo "Screen_height = $hauteur		;" >> rf2_config2.ini;
	else
		echo "$ligne" >> rf2_config2.ini;
	fi
done
rm rf2_config.ini
mv rf2_config2.ini rf2_config.ini

# Simulation du redémarage, création du lanceur et fermeture de la fenêtre
POL_SetupWindow_reboot

POL_SetupWindow_make_shortcut "RedFaction2" "Program Files/THQ/Red Faction® II" "rf2.exe" "" "Red Faction II"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEoACgkQ5TH6yaoTykdXUQCgkMUbAheXI4FplZowLGqfHxQk
k3MAoK1AC/yKFd4Obwy98kAW8ULDGXEu
=s3Cs
-----END PGP SIGNATURE-----
