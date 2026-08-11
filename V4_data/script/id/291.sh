#!/bin/bash
#INIT SCRIPT PLAYONLINUX.COM
#Is playonlinux running?
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
#Load & Check dependencies
source "$PLAYONLINUX/lib/sources"
cfg_check

#Cleaning temp directory:
cd $REPERTOIRE/tmp
rm *.*
#Downloading necessary files and text setup
#wget "http://medias.jeuxonline.info/www/logos/295/32.jpg"
#wget "http://medias.jeuxonline.info/www/captures/295/0/5020-160.jpg"  

##Translation:
if [ "$POL_LANG" == "fr" ]; then
INSTALL="En attente de l'installation de Fireworks 8..."
FINISH="Fireworks 8 à été installé avec succes."
WARNING="Pour pouvoir installer le produit Macromedia Fireworks 8,\nvous devez télécharger le fichier .exe à cette adresse:\nhttp://www.clubic.com/lancer-le-telechargement-22540-0-fireworks.html"
FILELOCATION="Veuillez selectionner le fichier .exe d'installation."
else
INSTALL="Installing Fireworks 8..."
FINISH="Fireworks 8 has been sucessfully installed."
WARNING="To be able to install Macromedia Fireworks 8 product,\nyou need to download the file .exe at this address:\nhttp://www.clubic.com/lancer-le-telechargement-22540-0-fireworks.html"
FILELOCATION="Please select the .exe installation file."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 Fireworks 8
#-----------------------------------------------------------------------------------

POL_SetupWindow_Init "" ""

#Game and script presentation
POL_SetupWindow_presentation "Fireworks 8" "Adobe Macromedia" "http://www.macromedia.com/software/fireworks/" "dl.bonsai" "Fireworks 8"
browser "http://www.clubic.com/lancer-le-telechargement-22540-0-fireworks.html"
POL_SetupWindow_message "$WARNING" "Fireworks 8"


# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/Fireworks8"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# Fireworks 8 Install
POL_SetupWindow_browse "$FILELOCATION" "Fireworks 8" 
FILE="$APP_ANSWER"
POL_SetupWindow_wait_next_signal "$INSTALL" "Fireworks 8"
wine $FILE

POL_SetupWindow_detect_exit

#Shortcut
POL_SetupWindow_make_shortcut "Fireworks8" "Program Files/Macromedia/Fireworks 8/" "Fireworks.exe" "" "Fireworks 8"

POL_SetupWindow_message "$FINISH" "Fireworks 8"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 Fireworks 8
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEgACgkQ5TH6yaoTykcLbgCdGmmTgbPZfgw4xblSTiZnIj47
sVEAnA+zo28Y7fdFQ4NBsYNqiDS0hzZW
=JoHk
-----END PGP SIGNATURE-----
