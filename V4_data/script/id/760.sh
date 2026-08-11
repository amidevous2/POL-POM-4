#!/bin/bash
# Wine version used : 1.2
# Distribution used to test : Debian Lenny
# Author : Maximo90
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Fifa 2011"
PREFIX="fifa11"
WORKING_WINE_VERSION="1.2"
 
#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "EA Sports" "http://www.ea.com/soccer/fifa" "Maximo90" "$PREFIX"
 
#asking for CDROM and checking if it's correct one
POL_SetupWindow_message "Please insert $TITLE media into your disk drive."
POL_SetupWindow_cdrom
cd "$CDROM"
CHECK=$(find . -iwholename ./EASetup.exe | cut -d'/' -f2)
POL_SetupWindow_check_cdrom "$CHECK"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
 
#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
 
#Installing mandatory dependencies 
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_d3dx9
POL_Call POL_Install_gecko
POL_Call POL_Install_tahoma
POL_Call POL_Install_dotnet20
POL_Call POL_Install_vcrun2008
 
#starting installation
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine "$CDROM/$CHECK"
POL_SetupWindow_detect_exit
 
## PlayOnMac Section
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi
 
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "fifa.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$TITLE has been installed successfully." "$TITLE"
 
POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." $TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFUACgkQ5TH6yaoTykeRRACfY8o0mkmmXUhh81GKMLrU8Bsu
rwkAoJ6BOqj6NYX1OR7FTG9yH2si2JR7
=47zW
-----END PGP SIGNATURE-----
