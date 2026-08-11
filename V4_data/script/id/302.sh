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

##Translation:
if [ "$POL_LANG" == "fr" ]; then
INSTALL="En attente de l'installation de Settlers 4 \nTrojans and the elixir of power..."
FINISH="Settlers 4 à été installé avec succes."
else
INSTALL="Installing Settlers 4 \nTrojans and the elixir of power..."
FINISH="Settlers 4 has been sucessfully installed."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 Settlers 4
#-----------------------------------------------------------------------------------

POL_SetupWindow_Init "" ""

#Game and script presentation
POL_SetupWindow_presentation "Settlers 4 Trojans and the elixir of power" "BlueByte" "http://www.bluebyte.net" "dl.bonsai" "Settlers4"

# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/Settlers4"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# BaldursGate2 Install
POL_SetupWindow_cdrom "1" 
POL_SetupWindow_check_cdrom /Autorun.exe
POL_SetupWindow_wait_next_signal "$INSTALL" "Settlers 4"
TEMP="$CDROM"

cd $REPERTOIRE/wineprefix/Settlers4

wine $TEMP/Autorun.exe

POL_SetupWindow_detect_exit

POL_SetupWindow_message "$FINISH" "Settlers 4"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 Settlers 4
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEkACgkQ5TH6yaoTykcQIQCdEFYUue3Du01HeVEWqbjro6/s
6MIAn14BV5MYXKBqkr9klsc8D6dVTqMf
=3PIB
-----END PGP SIGNATURE-----
