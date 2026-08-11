#!/bin/bash
# Date : (2009-12-22 21-00)
# Last revision : (2009-12-22 21-00)
# Wine version used : Fedora 12
# Distribution used to test : 1.1.35
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

TITLE="Tomb Raider The Angel Of Darkness"
PREFIX="TRVI"
WORKINGWINEVERSION="1.1.35"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

#procedure for patching TombRaider VI
patch_trVI()
{
POL_SetupWindow_browse "Select patch file" "$TITLE" ""
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine "$APP_ANSWER"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "Patch for $TITLE has been installed successfully" "$TITLE"
}

wget http://upload.wikimedia.org/wikipedia/en/5/5f/TombRaiderChronicles.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Eidos Interactive" "www.eidos.com" "NSLW" "$PREFIX" 

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TITLE" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
patch_trVI
POL_SetupWindow_Close
exit
fi
fi

POL_SetupWindow_prefixcreate
#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

#copying first CD
POL_SetupWindow_message "Please insert first CD into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Lara Croft Tomb Raider The Angel Of Darkness.msi"
cd "$WINEPREFIX/drive_c/windows/temp"
mkdir "TRAOD"
cd "$WINEPREFIX/drive_c/windows/temp/TRAOD"
echo "TRAOD2" >& .windows-label
POL_SetupWindow_wait_next_signal "Copying first CD" "$TITLE"
cd "$CDROM"
cp -fr * "$WINEPREFIX/drive_c/windows/temp/TRAOD"
chmod 777 "$WINEPREFIX/drive_c/windows/temp/TRAOD" -R
POL_SetupWindow_detect_exit


#copying second CD
POL_SetupWindow_message "Please insert second CD into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Release.cab"
POL_SetupWindow_wait_next_signal "Copying second CD" "$TITLE"
cd "$CDROM"
cp -fr * "$WINEPREFIX/drive_c/windows/temp/TRAOD"
chmod 777 "$WINEPREFIX/drive_c/windows/temp/TRAOD" -R
POL_SetupWindow_detect_exit
 
#adding CD-ROM as drive e: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$WINEPREFIX/drive_c/windows/temp/TRAOD" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

sleep 5

POL_SetupWindow_message "Installation will start now.\nPlease choose Full installation\nand disable both DirectX 9.0a and EAX installation checkbox" "Installation tips" "$PLAYONLINUX/themes/tango/info.png"

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd "$WINEPREFIX/drive_c/windows/temp/TRAOD"
wine "setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_wait_next_signal "Copying Data..." "$TITLE"
cd "$WINEPREFIX/drive_c/Data"
mv -f * "$WINEPREFIX/drive_c/$PROGRAMFILES/Eidos Interactive/TRAOD/data"
cd "$WINEPREFIX/drive_c/Data/FMV"
mv -f * "$WINEPREFIX/drive_c/$PROGRAMFILES/Eidos Interactive/TRAOD/data/FMV"
POL_SetupWindow_detect_exit

POL_SetupWindow_wait_next_signal "Cleaning temp directory..." "$TITLE"
cd "$WINEPREFIX/drive_c/windows/temp"
rm -fr *
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Eidos Interactive/TRAOD" "Launcher.exe" "" "$TITLE" "" ""
POL_SetupWindow_make_icon_for_shortcut "$TITLE" "*_launcher.0.png"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TITLE"

cd "$REPERTOIRE/ressources"
#downloading patch v42
if [ ! -e "TRAOD_PC_PATCH_V42.exe" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading TRAOD_PC_PATCH_V42.exe" "Downloading patch" "http://ftp.eidos.co.uk/pub/uk//tomb_raider_AOD/patch/TRAOD_PC_PATCH_V42.exe"
fi

#downloading patch v52
if [ ! -e "TRAOD_V52_Patch.exe" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading TRAOD_V52_Patch.exe" "Downloading patch" "http://ftp.eidos.co.uk/pub/uk//tomb_raider_AOD/patch/TRAOD_V52_Patch.exe"
fi

POL_SetupWindow_wait_next_signal "Installation of v42 patch in progress..." "$TITLE"
wine "TRAOD_PC_PATCH_V42.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_wait_next_signal "Installation of v52 patch in progress..." "$TITLE"
wine "TRAOD_V52_Patch.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"

POL_SetupWindow_message "The movies won't be played due to deficiencies in Wine.\nIt'll also cause black screens in game which can stay for long time.\nTo skip movies and therefore black screens press any key then.\nTo watch movies from outside of the game go to\n$WINEPREFIX/drive_c/$PROGRAMFILES/Eidos Interactive/TRAOD/data/FMV" "Skip movie" "$PLAYONLINUX/themes/tango/info.png"

POL_SetupWindow_message "Please do not enable:\n-Depth Of Field PS 2.0\n-nVidia Shadows" "Note about non-working options" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFgACgkQ5TH6yaoTykf/YwCfTym/71rTwk9QHXTZTJkt9Beq
xfsAnjkLOWRql1ZY9JxquIsiYaFNCyfG
=6gk/
-----END PGP SIGNATURE-----
