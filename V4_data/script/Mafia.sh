#!/bin/bash
# Date : (2009-05-30 17-30)
# Last revision : (2009-05-30 17-30)
# Wine version used : 1.1.21
# Distribution used to test : Fedora 10
# Author : NSLW
# Licence : Retail
# Depend : unzip, ImageMagick

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


TYTUL="Mafia"
PREFIX="Mafia"
WORKINGWINEVERSION="1.1.35"
 
#procedure for patching Mafia
patch_mafia()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

copy_cd()
{
POL_SetupWindow_message "Please insert $1 cd" "$TYTUL"
POL_SetupWindow_cdrom
CDROM[$2]="$CDROM"
POL_SetupWindow_check_cdrom "/MafiaGame/$4"
POL_SetupWindow_wait_next_signal "Copying $1 CD" "$TYTUL"
rm -fr "$WINEPREFIX/drive_c/windows/temp/MAFIA_CD_$[$2-1]"
cd "$WINEPREFIX/drive_c/windows/temp"
mkdir "MAFIA_CD_$2"
cd "$CDROM"
cp -fr * "$WINEPREFIX/drive_c/windows/temp/MAFIA_CD_$2"
chmod 777 "$WINEPREFIX/drive_c/windows/temp/MAFIA_CD_$2" -R
cd "$WINEPREFIX/drive_c/windows/temp"
echo "MAFIA_CD_$2" > "./MAFIA_CD_$2/.windows-label"

cd "$WINEPREFIX/dosdevices"
ln -fs "$WINEPREFIX/drive_c/windows/temp/MAFIA_CD_$2" $3
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"$3\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

POL_SetupWindow_detect_exit
sleep 5
}

wget http://upload.wikimedia.org/wikipedia/en/b/ba/MafiaUSCov.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Illusion Softworks" "www.illusionsoftworks.com" "NSLW" "$PREFIX" 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching
POL_SetupWindow_menu "What do you want to do?" "Actions" "install-game patch-game" " "
if [ "$APP_ANSWER" == "patch-game" ]; then
	if [ -e "$REPERTOIRE/wineprefix/$PREFIX" ]; then
	patch_mafia
	POL_SetupWindow_Close
	fi
fi

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"
POL_SetupWindow_prefixcreate 

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%" |tr -d '\015' | tr -d '\010'`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#downloading MS Visual C++ 6 sp4 libraries
cd "$REPERTOIRE/ressources/"
if [ ! -e $REPERTOIRE/ressources/vc6redistsetup_enu.exe ]; then
POL_SetupWindow_download "Downloading MS Visual C++ 6 sp4 libraries" "$TYTUL" "http://download.microsoft.com/download/vc60pro/update/1/w9xnt4/en-us/vc6redistsetup_enu.exe"
fi

#copying mfc42.dll
cd "$WINEPREFIX/drive_c/windows/temp/"
cabextract "$REPERTOIRE/ressources/vc6redistsetup_enu.exe"
cabextract "vcredist.exe"
cp mfc42.dll "$WINEPREFIX/drive_c/windows/system32"

copy_cd "first" "1" "d:" "A1.dta"
POL_SetupWindow_message "ATL+TAB here if the game asks for second CD" "$TYTUL"

#starting installation
cp "$CDROM/m.ico" "$REPERTOIRE/icones/32/$TYTUL"
cp "$CDROM/m.ico" "$REPERTOIRE/icones/32/$TYTUL Setup"
#cd $CDROM
wine d:\MafiaLauncher.exe

copy_cd "second" "2" "d:" "A4.dta"
POL_SetupWindow_message "ATL+TAB here if the game asks for third CD\nPlease ALT+TAB to installer now" "$TYTUL"

copy_cd "third" "3" "d:" "A0.dta"

POL_SetupWindow_message "Please ALT+TAB to installer now\nPress \"Forward\" if installer finishes" "$TYTUL"

#adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -fs $CDROM[1] d:
cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
 
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
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Mafia" "Game.exe" "" "$TYTUL" "" ""
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Mafia" "Setup.exe" "" "$TYTUL Setup" "" ""
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL Setup"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_mafia
fi

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFAACgkQ5TH6yaoTykfHpACfTQpXZWhkIe7IvMge3O6wjg6n
2t4AnArVgDpCr2TNGO7EbwXtCu0cuecP
=Xind
-----END PGP SIGNATURE-----
