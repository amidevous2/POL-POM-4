#!/bin/bash
# Date : (2009-07-06 12-00)
# Last revision : (2009-07-06 12-00)
# Wine version used : 1.1.25
# Distribution used to test : Fedora 11
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick, unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

if [ "$POL_LANG" == "de" ]; then
PODTYTUL="Die Nacht des Raben"

elif [ "$POL_LANG" == "pl" ]
then
PODTYTUL="Noc kruka"

else
PODTYTUL="The Night Of The Raven"
fi

TYTUL="Gothic 2 - $PODTYTUL"
PREFIX="Gothic2"
WORKINGWINEVERSION="1.1.29"

#procedure for patching Gothic 2
patch_gothic2()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

Get_Latest_Wine_Version()
{
wget http://mulx.playonlinux.com/wine/linux-i386/LIST --output-document="$REPERTOIRE/tmp/LIST"
xyz=`cat "$REPERTOIRE/tmp/LIST" | sed -e 's/\.//g' | cut -d';' -f2 | sort -n | tail -n1`
echo "$(echo $xyz | cut -c1-1).$(echo $xyz | cut -c2-2).$(echo $xyz | cut -c3-4)"
}

Change_Resolution()
{

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/JoWooD/Gothic II/System"
OLDX=`cat gothic.ini | grep "zVidResFullscreenX=" | cut -d"=" -f2`
OLDY=`cat gothic.ini | grep "zVidResFullscreenY=" | cut -d"=" -f2`
OLDBPP=`cat gothic.ini | grep "zVidResFullscreenBPP=" | cut -d"=" -f2`

POL_SetupWindow_menu_list "Choose display resolution" "Display resolution" "1024x768~800x600~640x480" "~"
RES="$APP_ANSWER"
POL_SetupWindow_menu_list "Choose color depth" "Color depth" "32~16" "~"
NEWBPP="$APP_ANSWER"

NEWX=`echo $RES | cut -d"x" -f1`
NEWY=`echo $RES | cut -d"x" -f2`
rm gothic.ini.bak
mv gothic.ini gothic.ini.bak

cat gothic.ini.bak | sed -e "s/zVidResFullscreenX=$OLDX/zVidResFullscreenX=$NEWX/g" | sed -e "s/zVidResFullscreenY=$OLDY/zVidResFullscreenY=$NEWY/g" | sed -e "s/zVidResFullscreenBPP=$OLDBPP/zVidResFullscreenBPP=$NEWBPP/g" > gothic.ini
}

download_pulseudio()
{
cd "$REPERTOIRE/ressources/"
if [ ! -e "$REPERTOIRE/ressources/$WORKINGWINEVERSION-mod.zip" ]; then
POL_SetupWindow_download "Downloading PulseAudio sound driver" "$TYTUL" "http://www.sigmirror.com/files/23682_vtvrr/$WORKINGWINEVERSION-mod.zip"
fi
cd "$WINEPREFIX/drive_c/windows/temp/"
unzip "$REPERTOIRE/ressources/$WORKINGWINEVERSION-mod.zip"
./$WORKINGWINEVERSION-mod -y
cp -f PulseAudio/* ./
}

prepare_patched_WineVersion()
{
POL_SetupWindow_install_wine "$1"
cd "$REPERTOIRE/WineVersions"
POL_SetupWindow_wait_next_signal "Removing old WineVersion" "$TYTUL"
rm -fr "$1-PA"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_wait_next_signal "Copying WineVersion" "$TYTUL"
cp -r "$1" "$1-PA"
cp "$WINEPREFIX/drive_c/windows/temp/winepulse.drv.so" "$REPERTOIRE/WineVersions/$1-PA/usr/lib/wine/winepulse.drv.so"
POL_SetupWindow_detect_exit
}

wget http://upload.wikimedia.org/wikipedia/en/9/93/G2-NotR_cover.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Piranha Bytes" "www.gothic2.com" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

LATESTVERSION=$(Get_Latest_Wine_Version)
CHOSENWINEVERSION="$LATESTVERSION"
Use_WineVersion "$CHOSENWINEVERSION"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game~Change resolution~Update Wine version to $WORKINGWINEVERSION" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
	patch_gothic2
elif [ "$APP_ANSWER" == "Change resolution" ]
then
Change_Resolution
elif [ "$APP_ANSWER" == "Update Wine version to $WORKINGWINEVERSION" ]
then
	CHOSENWINEVERSION="$LATESTVERSION-PA"
	download_pulseudio
	prepare_patched_WineVersion "$LATESTVERSION"
	cd "$WINEPREFIX/drive_c/windows/temp/" 
	echo "[HKEY_CURRENT_USER\\Software\\Wine\\Drivers]" > pa.reg
	echo "\"Audio\"=\"pulse\"" >> pa.reg
	regedit pa.reg
	Set_WineVersion_Assign "$CHOSENWINEVERSION" "$TYTUL"
fi

POL_SetupWindow_Close
exit
fi

if [ ! -e "$REPERTOIRE/configurations/installed/Gothic 2" ]
then
POL_SetupWindow_message "Install Gothic 2 first" "$TYTUL"
POL_SetupWindow_Close
fi

POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"

#taking icon from the game
convert "$CDROM/AutoRun.ico" -geometry 32X32 "$REPERTOIRE/icones/32/$TYTUL"

cd "$REPERTOIRE/ressources"
if [ ! -e "gothic2_vdfs-patch.zip" ]; then
POL_SetupWindow_wait_next_signal "Downloading VDFS patch..." "$TYTUL"
wget http://forum.jowood.de/attachment.php?attachmentid=25660 --output-document=gothic2_vdfs-patch.zip
POL_SetupWindow_detect_exit
fi

#adding CD-ROM as drive d: e: f: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" g:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"g:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

#starting installation
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
cd "$CDROM"
wine "Setup.exe"
POL_SetupWindow_detect_exit

#asking about Pulseaudio
POL_SetupWindow_question "Do you want to use PulseAudio sound driver?\nMore about this sound driver at art.ified.ca/?page_id=40" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ]; then
	CHOSENWINEVERSION="$LATESTVERSION-PA"
	download_pulseudio
	prepare_patched_WineVersion "$LATESTVERSION"
	cd "$WINEPREFIX/drive_c/windows/temp/" 
	echo "[HKEY_CURRENT_USER\\Software\\Wine\\Drivers]" > pa.reg
	echo "\"Audio\"=\"pulse\"" >> pa.reg
	regedit pa.reg
fi

#applying vdfs patch
POL_SetupWindow_wait_next_signal "Installing VDFS patch..." "$TYTUL"
cd "$WINEPREFIX/drive_c/windows/temp/"
unzip "$REPERTOIRE/ressources/gothic2_vdfs-patch.zip"
wine gothic2_vdfs-patch.exe
POL_SetupWindow_detect_exit

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#making shortcut
mv -f "$REPERTOIRE/configurations/installed/Gothic 2" "$REPERTOIRE/configurations/installed/$TYTUL"
Set_WineVersion_Assign "$CHOSENWINEVERSION" "$TYTUL"
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL" 
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_gothic2
fi

#asking about resolution
POL_SetupWindow_question "Every time you want to change game resolution\nyou'll have to run this script again\nDo you want to change resolution right now?" "$TYTUL" 
if [ "$APP_ANSWER" == "TRUE" ] ;then
Change_Resolution
fi

POL_SetupWindow_message "The game will show error about VDFS\neverytime you'll try to run it\nPlease don't be bothered by that and just hit OK\nThe game will start after" "Note about resolution" "$PLAYONLINUX/themes/tango/info.png"

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFMACgkQ5TH6yaoTykcmUwCgr0mXmfPG1nsyZs6uLHpch9sy
+LAAnizFj256vUCBQb7d0zCXBtQVp7tf
=sPq5
-----END PGP SIGNATURE-----
