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

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

##Translation:
if [ "$POL_LANG" == "fr" ]; then
INSTALL="En attente de l'installation de Dawn Of War Soulstorm..."
FINISH="Dawn Of War Soulstorm à été installé avec succes."
else
INSTALL="Installing Dawn Of War Soulstorm..."
FINISH="Dawn Of War Soulstorm has been sucessfully installed."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 DawnOfWar_Soulstorm
#-----------------------------------------------------------------------------------


POL_SetupWindow_Init

#Game and script presentation
POL_SetupWindow_presentation "Dawn Of War : Soulstorm" "THQ" "http://www.thq-games.com/" "dl.bonsai" "DawnOfWar_Soulstorm"

# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/DawnOfWar_Soulstorm"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# DawnOfWar_Soulstorm Install
cd $REPERTOIRE/tmp
POL_SetupWindow_cdrom "DawnOfWar_Soulstorm" 
POL_SetupWindow_check_cdrom "/setup.exe"
THEFILE="$CDROM"
POL_SetupWindow_wait_next_signal "$INSTALL" "DawnOfWar_Soulstorm"
wine "$THEFILE/setup.exe"
POL_SetupWindow_detect_exit

#Shortcut
POL_SetupWindow_make_shortcut "DawnOfWar_Soulstorm" "$PROGRAMFILES/THQ/Dawn of War - Soulstorm/" "Soulstorm.exe" "DawnOfWar_DarkCrusade.xpm" "Dawn Of War : Soulstorm"

POL_SetupWindow_message "$FINISH" "DawnOfWar_Soulstorm"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 DawnOfWar_Soulstorm
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEgACgkQ5TH6yaoTykdvOACeKTAxr7iytyvpCzNxCfVYndpz
9ZwAn2gtCV9+uQebtXqrIXPQc1vbFe94
=nPHU
-----END PGP SIGNATURE-----
