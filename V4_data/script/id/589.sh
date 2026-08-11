#!/bin/bash
# Date : (2010-03-04 18-00)
# Last revision : (2010-03-05 16-00)
# Wine version used : 1.1.39
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Tropico 3"
PREFIX="Tropico3"
WORKINGWINEVERSION="1.1.43"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

is_checked ()
{
	if [ "$(echo "$PATCHSET" | grep -o "$1")" != "" ]; then
	echo "1"
	else
	echo "0"
	fi
}

PATCHFILE[0]="Tropico3_patch_v1.04_ddsetup.exe"
PATCHFILE[1]="Tropico3.patch.v1.09.exe"
PATCHFILE[2]="Tropico3Patch109-113_Installer.exe"
PATCHFILE[3]="trop3109fix_cz.exe"
PATCHFILE[4]="Tropico3Patch100Russian.exe"
PATCHFILE[5]="Tropico3Patch100-111Russian.exe"
PATCHFILE[6]="patchCD_Tropico3_v1.13.exe"
PATCHFILE[7]="Other patch"

#procedure for patching Tropico 3
patch_Tropico3()
{
POL_SetupWindow_checkbox_list "Check patch files you've got on your hard disk." "Patch list" "${PATCHFILE[0]}~${PATCHFILE[1]}~${PATCHFILE[2]}~${PATCHFILE[3]}~${PATCHFILE[4]}~${PATCHFILE[5]}~${PATCHFILE[6]}~${PATCHFILE[7]}" "~"
PATCHSET="$APP_ANSWER"

for i in `seq 0 7`;
do

if [ "$(is_checked "${PATCHFILE[$i]}")" = "1" ]
then
POL_SetupWindow_browse "Where is your ${PATCHFILE[$i]} located ?" "$TYTUL" ""
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
wine "$APP_ANSWER"
POL_SetupWindow_detect_exit
fi

done
POL_SetupWindow_message "Patches for $TYTUL have been installed successfully" "$TYTUL"
}

#starting the script
wget http://upload.wikimedia.org/wikipedia/en/2/26/Tropico_3_Box_Art.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Kalypso Media" "www.tropico3.com" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
patch_Tropico3
fi

POL_SetupWindow_Close
exit
fi

#asking for CDROM and checking if it's correct one
POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#creating application's own prefix
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

#adding CD-ROM as drive e: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

#installing .NET Framework 2.0 which is required to successfuly finish DirectX installation
POL_Call POL_Install_dotnet20

#starting installation
wine start /unix "$CDROM/setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

#asking about memory size of graphic card
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-890-1024-2048" "-" "256"
VMS="$APP_ANSWER"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
echo "\"Multisampling\"=\"enabled\"" >> vms.reg
regedit vms.reg

#overriding dlls required for playing sound (more can be red at http://bugs.winehq.org/show_bug.cgi?id=21248)
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > override.reg
echo "\"mmdevapi\"=\"\"" >> override.reg
regedit override.reg

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#making shortcut 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Kalypso/Tropico 3" "tropico3.exe" "" "$TYTUL" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
POL_SetupWindow_make_icon_for_shortcut "$TYTUL" "*_tropico3.0.png"

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL" 
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_Tropico3
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFoACgkQ5TH6yaoTykc8FQCcChHrK5grK8l6b4hm2o6OW5qY
pIUAn2ofqklDxodbOmP7HjLNviRxRbT1
=07uP
-----END PGP SIGNATURE-----
