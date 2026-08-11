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
INSTALL="En attente de l'installation de Settlers 4..."
FINISH="Settlers 4 à été installé avec succes."
else
INSTALL="Installing Settlers 4..."
FINISH="Settlers 4 has been sucessfully installed."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 Settlers 4
#-----------------------------------------------------------------------------------

POL_SetupWindow_Init "" ""

#Game and script presentation
POL_SetupWindow_presentation "Settlers 4" "BlueByte" "http://www.bluebyte.net" "dl.bonsai" "Settlers4"

# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/Settlers4"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# BaldursGate2 Install
POL_SetupWindow_cdrom "1" 
POL_SetupWindow_check_cdrom /Autorun.exe
POL_SetupWindow_wait_next_signal "$INSTALL" "Settlers 4"
TEMP="$CDROM"
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s / z:
ln -s $TEMP f:
cd $REPERTOIRE/wineprefix/Settlers4

wine $TEMP/Autorun.exe

POL_SetupWindow_detect_exit

#Shortcut
POL_SetupWindow_make_shortcut "Settlers4" "BlueByte/The Settlers IV/" "S4.exe" "" "Settlers 4"

POL_SetupWindow_message "$FINISH" "Settlers 4"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 Settlers 4
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEkACgkQ5TH6yaoTykc/aQCghLIkSqe24HBopDQ58zgZ8Fnq
9mkAoJ2ECg3y/PvNIwNwOpKG6FAI27YK
=9ekn
-----END PGP SIGNATURE-----
