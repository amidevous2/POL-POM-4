#!/bin/bash
# Date : (2009-05-23 12-14)
# Last revision : (2009-05-23 12-14)
# Wine version used : 1.1.21
# Distribution used to test : Fedora 10
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

TYTUL="Silent Hill 2"
PREFIX="SH2"
 
#procedure for patching SH2
patch_sh2()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

wget http://upload.wikimedia.org/wikipedia/en/thumb/9/95/Silent_Hill_2.jpg/256px-Silent_Hill_2.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Konami" "N/A" "NSLW" "$PREFIX" 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching
POL_SetupWindow_menu "What do you want to do?" "Actions" "install-game patch-game" " "
if [ "$APP_ANSWER" == "patch-game" ]; then
	if [ -e "$REPERTOIRE/wineprefix/$PREFIX" ]; then
	patch_sh2
	POL_SetupWindow_Close
	fi
fi

POL_SetupWindow_prefixcreate 

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
 
#adding CD-ROM as drive d: to winecfg
CDROM2=${CDROM//"1"/"2"} #SH2DC_CD2
CDROM3=${CDROM//"1"/"3"} #SH2DC_CD3
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:
ln -s $CDROM2 e:
ln -s $CDROM3 f:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
echo "\"f:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
 
sleep 5
#POL_SetupWindow_message "Wait 5 seconds then click next" "$TYTUL"
 
#starting installation
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
cd $CDROM
wine "Setup.exe"
POL_SetupWindow_detect_exit

cd "$WINEPREFIX/drive_c/windows/temp/"  
#setting OffscreenRenderingMode to fbo
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > fbo.reg
echo "\"OffscreenRenderingMode\"=\"fbo\"" >> fbo.reg
regedit fbo.reg
 
#asking about memory size
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-1024-2048" "-" "256"
VMS="$APP_ANSWER"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
 
#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *
 
#making shortcut
cp "$CDROM/sh2.ico" "$REPERTOIRE/icones/32/$TYTUL"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Konami/$TYTUL" "sh2pc.exe" "" "$TYTUL" "" ""
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"
 
#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_sh2
fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJE8ACgkQ5TH6yaoTykcFegCfTt6t2CqQsd0lZv3BoFFlev7o
snEAoJfWtVZQOZ/ZzS5N164fB89NrYo/
=U0Bo
-----END PGP SIGNATURE-----
