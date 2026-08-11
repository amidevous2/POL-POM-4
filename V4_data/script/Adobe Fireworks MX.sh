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
INSTALL="En attente de l'installation de Fireworks MX..."
FINISH="Fireworks MX à été installé avec succes."
WARNING="Pour pouvoir installer le produit Macromedia Fireworks MX,\nvous devez télécharger le fichier .exe à cette adresse:\nhttp://www.soft32.com/Download/free-trial/Macromedia_Fireworks_MX/4-351-1.html"
FILELOCATION="Veuillez selectionner le fichier .exe d'installation."
else
INSTALL="Installing Fireworks MX..."
FINISH="Fireworks MX has been sucessfully installed."
WARNING="To be able to install Macromedia Fireworks MX product,\nyou need to download the file .exe at this address:\nhttp://www.soft32.com/Download/free-trial/Macromedia_Fireworks_MX/4-351-1.html"
FILELOCATION="Please select the .exe installation file."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 Fireworks MX
#-----------------------------------------------------------------------------------

POL_SetupWindow_Init "" ""

#Game and script presentation
POL_SetupWindow_presentation "Fireworks MX" "Adobe Macromedia" "http://www.macromedia.com/software/fireworks/" "dl.bonsai" "FireworksMX"
browser "http://www.soft32.com/Download/free-trial/Macromedia_Fireworks_MX/4-351-1.html"
POL_SetupWindow_message "$WARNING" "Fireworks MX"


# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/Fireworks MX"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# Fireworks MX Install
POL_SetupWindow_browse "$FILELOCATION" "Fireworks MX" 
FILE="$APP_ANSWER"
POL_SetupWindow_wait_next_signal "$INSTALL" "Fireworks MX"
wine $FILE

POL_SetupWindow_detect_exit

#Shortcut
POL_SetupWindow_make_shortcut "FireworksMX" "Program Files/Macromedia/Fireworks MX 2004/" "Fireworks.exe" "" "Fireworks MX"

POL_SetupWindow_message "$FINISH" "Fireworks MX"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 Fireworks MX
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEgACgkQ5TH6yaoTykeEPgCgk4XwP8UZAmdWLcn07nbWRvdT
pz8An0AOT61lwX5uEZEO5DSdlKCu3QlT
=iwPl
-----END PGP SIGNATURE-----
