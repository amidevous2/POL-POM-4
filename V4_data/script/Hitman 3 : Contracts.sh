#!/bin/bash
# Date : (2009-05-23 15-00)
# Last revision : (2009-07-12 22-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

TITLE="Hitman 3 : Contracts"
PREFIX="Hitman3" 

Get_Latest_Wine_Version()
{
wget http://mulx.playonlinux.com/wine/linux-i386/LIST --output-document="$REPERTOIRE/tmp/LIST"
xyz=`cat "$REPERTOIRE/tmp/LIST" | sed -e 's/\.//g' | cut -d';' -f2 | sort -n | tail -n1`
echo "$(echo $xyz | cut -c1-1).$(echo $xyz | cut -c2-2).$(echo $xyz | cut -c3-4)"
}

wget http://upload.wikimedia.org/wikipedia/en/e/ef/Hitman_3_artwork.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Io Interactive" "http://www.hitmancontracts.com/" "The_Mystery_Machine and NSLW" "$PREFIX" 

#asking about Hitman 3 version
POL_SetupWindow_menu "What are your installation medias?" "Medias" "Two CDs~One DVD" "~"

if [ "$APP_ANSWER" == "Two CDs" ]; then

#Disk-2
POL_SetupWindow_message "Please insert second CD" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.w02"
POL_SetupWindow_wait_next_signal "Copying second CD" "$TITLE"
CDROM2="$CDROM"

#show files on second cd
echo "Content of second CD:" 
echo $CDROM
ls "$CDROM"

#Disk-1
POL_SetupWindow_message "Please insert first CD" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

#show files on second cd
echo "Content of first CD:"
echo $CDROM
ls "$CDROM"

elif [ "$APP_ANSWER" == "One DVD" ]
then
POL_SetupWindow_message "Please insert installation DVD" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
fi

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
LATESTVERSION=$(Get_Latest_Wine_Version)
CHOSENWINEVERSION=$LATESTVERSION
POL_SetupWindow_install_wine "$CHOSENWINEVERSION"
Use_WineVersion "$CHOSENWINEVERSION"
POL_SetupWindow_prefixcreate

cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" d:
ln -s "$CDROM2" e:

cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd "$CDROM"
wine "setup.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Eidos/Hitman Contracts" "HitmanContracts.exe" "" "$TITLE" "" ""
Set_WineVersion_Assign "$CHOSENWINEVERSION" "$TITLE"
POL_SetupWindow_reboot 
 
if [ "$POL_LANG" == "fr" ]
then
 
POL_SetupWindow_message "L'option graphique Post-Filter n'est pas supportée par toutes les configurations. Vous pouvez donc la décocher pour résoudre certains bugs graphiques." "/usr/share/playonlinux/themes/tango/warning.png"

else
 
POL_SetupWindow_message "The graphical option named Post-Filter is not support by all the configurations. So you can unselect it to solve some graphical bugs." "/usr/share/playonlinux/themes/tango/warning.png" 
 
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEQACgkQ5TH6yaoTykfs4gCfXGETAwZAF8/Ch1ZTPJYoA953
JXYAn0d43dYCP0rVgXfzO2z78JghO/Ly
=bDmP
-----END PGP SIGNATURE-----
