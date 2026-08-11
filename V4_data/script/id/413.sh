#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
 
VERSIONWINE=$(wine --version)
TYTUL="Planescape Torment"
PREFIX="PT"
 
#procedure for patching Planescape Torment
patch_pt()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}
 
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TYTUL" "Black Isle" "N/A" "NSLW" "$PREFIX" 
 
select_prefixe "$REPERTOIRE/wineprefix/$PREFIX"
 
#asking about patching
POL_SetupWindow_menu "What do you want to do?" "Actions" "install-game patch-game" " "
if [ "$APP_ANSWER" == "patch-game" ]; then
	if [ -e "$REPERTOIRE/wineprefix/$PREFIX" ]; then
	patch_pt
	POL_SetupWindow_Close
	fi
fi
 
POL_SetupWindow_prefixcreate 
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
 
#adding CD-ROM as drive d: to winecfg
CDROM2=${CDROM//"1"/"2"} #CD2
CDROM3=${CDROM//"1"/"3"} #CD3
CDROM4=${CDROM//"1"/"4"} #CD4
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d: #not sure about CD1 label
ln -s $CDROM2 e:
ln -s $CDROM3 f:
ln -s $CDROM4 g:
 
echo "\"d:\"=\"cdrom\"" >> "$REPERTOIRE/tmp/cdrom.reg"
echo "\"e:\"=\"cdrom\"" >> "$REPERTOIRE/tmp/cdrom.reg"
echo "\"f:\"=\"cdrom\"" >> "$REPERTOIRE/tmp/cdrom.reg"
echo "\"g:\"=\"cdrom\"" >> "$REPERTOIRE/tmp/cdrom.reg"
regedit "$REPERTOIRE/tmp/cdrom.reg"
 
POL_SetupWindow_message "Wait 5 seconds then click next" "$TYTUL"
 
#starting installation
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
cd $CDROM
wine "SETUP.EXE"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"
 
#switching to windowed mode
cd "$WINEPREFIX/drive_c/Program Files/Black Isle/Torment"
mv Torment.ini Torment.ini.bak
cat Torment.ini.bak | sed s/Full\ Screen=1/Full\ Screen=0/ >& Torment.ini
 
#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *
 
#making shortcut
cp "$CDROM/TORMENT.ICO" "$REPERTOIRE/icones/32/$TYTUL"
POL_SetupWindow_make_shortcut "$PREFIX" "Program Files/Black Isle/Torment" "Torment.exe" "" "$TYTUL" "" "-opengl"
 
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"
 
#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_pt
fi
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFAACgkQ5TH6yaoTykf0OQCffMgtFm1ZeMNlTIIJtn8y6I9f
zuEAnj7JkAWUcESrAuI0g5QWT4cjDqLc
=REv1
-----END PGP SIGNATURE-----
