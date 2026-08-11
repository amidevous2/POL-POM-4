#!/bin/bash
# Date : (2009-05-25 13-00)
# Last revision : (2009-05-25 13-00)
# Wine version used : 1.1.22
# Distribution used to test : Fedora 10
# Author : NSLW
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#procedure for patching NFS HP II
patch_nfshpII()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

TYTUL="Need For Speed Hot Pursuit 2"
PREFIX="NFSHP2"

wget http://upload.wikimedia.org/wikipedia/en/9/95/NFSHP2_PC.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Electronic Arts Inc." "N/A" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching
POL_SetupWindow_menu "What do you want to do?" "Actions" "install-game patch-game" " "
if [ "$APP_ANSWER" == "patch-game" ]; then
	if [ -e "$REPERTOIRE/wineprefix/$PREFIX" ]; then
	patch_nfshpII
	fi
POL_SetupWindow_Close
fi

POL_SetupWindow_prefixcreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "AutoRun.exe"

#adding CD-ROM as drive d: to winecfg
cd $WINEPREFIX/dosdevices
ln -s $CDROM d:

cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

POL_SetupWindow_message "Wait 5 seconds then click next" "$TYTUL"

#starting installation
cd $CDROM
wine "AutoRun.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

cd "$WINEPREFIX/drive_c/windows/temp/"

#setting OffscreenRenderingMode to fbo
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > fbo.reg
echo "\"OffscreenRenderingMode\"=\"fbo\"" >> fbo.reg
echo "\"Multisampling\"=\"enabled\"" >> fbo.reg
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
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/EA Games/Need For Speed Hot Pursuit 2" "NFSHP2.exe" "" "$TYTUL" ""

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_nfshpII
fi

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJE8ACgkQ5TH6yaoTykc9hgCfWo8oOUuKC8mq0pXG2pn6bWJw
gk8AniRrImtJc6WYRSqiri3OUc4fcDkm
=ddNd
-----END PGP SIGNATURE-----
