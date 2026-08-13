#!/bin/bash
# Date : (2011-03-13 21-00)
# Last revision : (2011-03-13 21-00)
# Wine version used : 1.3.15
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Super Chuck Norris Bros."
PREFIX="scnb"
WORKING_WINE_VERSION="3.0"
  
if [ "$POL_LANG" == "fr" ]; then
LNG_SCNB_DL="Téléchargement du Freeware $TITLE..."
LNG_INSTALL_ON="Installation en cours..."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_SCNB_DL="Downloading $TITLE Freeware..."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
fi
  
#starting the script
cd "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Vidas Plu" "http://sites.google.com/site/ctfdoh/home" "GNU_Raziel" "$PREFIX"
  
select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"
 
#downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
        POL_Call POL_Install_wine64b
else
        POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"
 
#Creating prefix 
POL_SetupWindow_prefixcreate
 
#Downloading SCNB game (it's a freeware)
cd "$POL_USER_ROOT/ressources"
if [ ! -e "Super_Chuck_Norris_Bros._Demo.exe" ]; then
        POL_SetupWindow_download "$LNG_SCNB_DL" "$TITLE" "http://sites.google.com/site/ctfdoh/Super_Chuck_Norris_Bros._Demo.exe"
fi
 
#Installing game
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
cd "$WINEPREFIX/drive_c/Program Files/"
cp "$POL_USER_ROOT/ressources/Super_Chuck_Norris_Bros._Demo.exe" .
POL_SetupWindow_detect_exit

### PlayOnMac Section
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section

POL_Call POL_Install_quartz

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$REPERTOIRE/tmp/"
        rm -rf "$REPERTOIRE/tmp/*"
fi
 
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "Super_Chuck_Norris_Bros._Demo.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOXQKAAKCRDlMfrJqhPK
Rza8AKCRdeEVZCIgAcECL9CG9gs3WD3isACePwfCm4ewS+VP61p9FU5XzF0AiuM=
=s1Mm
-----END PGP SIGNATURE-----
