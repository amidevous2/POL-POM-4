#!/bin/bash
# Date : (2009-05-30 18-00)
# Last revision : (2010-04-03 08-00)
# Wine version used : 1.1.42
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Battlefield 2"
PREFIX="Battlefield2"
WORKINGWINEVERSION="1.1.42"
 
#procedure for patching Battlefield 2
patch_battlefield2()
{
POL_SetupWindow_browse "Select patch file downloaded from support.ea.com" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TYTUL" "Dice" "battlefield.ea.com/battlefield/bf2/" "NSLW" "$PREFIX" 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
	patch_battlefield2
fi

POL_SetupWindow_Close
exit
fi

POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"
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

#starting installation
wine start /unix "$CDROM/setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

cd "$WINEPREFIX/drive_c/windows/temp/"
#setting Multisampling to enabled
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > msa.reg
echo "\"Multisampling\"=\"enabled\"" >> msa.reg
regedit msa.reg

#asking about ATI cards
POL_SetupWindow_question "Do you've got ATI Radeon X1xxx or earlier graphic card?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ]; then
echo "\"UseGLSL\"=\"disabled\"" >> VideoDriver.reg
regedit VideoDriver.reg
fi
 
#asking about memory size
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "64-128-256-320-384-512-640-768-896-1024-1792-2048" "-" "256"
VMS="$APP_ANSWER"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

#setting decorated to N
echo "[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]" > decorated.reg
echo "\"Decorated\"=\"N\"" >> decorated.reg
regedit decorated.reg

Set_DXGrab "On"
Set_Desktop "On" "1920" "1440"

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi

#making shortcut
cp "$CDROM/BF2.ico" "$REPERTOIRE/icones/32/$TYTUL"
cp "$CDROM/BF2.ico" "$REPERTOIRE/icones/32/Play BF2 Online Now!"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/EA GAMES/Battlefield 2" "BF2.exe" "" "$TYTUL" "" "+menu 1 +fullscreen 1"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/EA GAMES/Battlefield 2" "BF2.exe" "" "Play BF2 Online Now!" "" "+playNow 1 +menu 1 +fullscreen 1"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "Play BF2 Online Now!"

POL_SetupWindow_menu "What is the version of your game?" "Version" "Deluxe Normal" " "
if [ "$APP_ANSWER" == "Deluxe" ]; then
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/EA GAMES/Battlefield 2/mods/xpack/bf2xpack.ico" "$REPERTOIRE/icones/32/$TYTUL Special Forces"
cp "$WINEPREFIX/drive_c/$PROGRAMFILES/EA GAMES/Battlefield 2/mods/xpack/bf2xpack.ico" "$REPERTOIRE/icones/32/Play BF2 SF Online Now!"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/EA GAMES/Battlefield 2" "BF2.exe" "" "$TYTUL Special Forces" "" "+menu 1 +fullscreen 1 +modPath mods/xpack"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL Special Forces"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/EA GAMES/Battlefield 2" "BF2.exe" "" "Play BF2 SF Online Now!" "" "+playNow 1 +menu 1 +fullscreen 1 +modPath mods/xpack"
Set_WineVersion_Assign "$WORKINGWINEVERSION" "Play BF2 SF Online Now!"
fi

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

POL_SetupWindow_message "It is recommended to set anti-aliasing\n to at least 2x in your system.
 That will prevent annoying black stripes\non the ground during play." "Note black stripes" "$PLAYONLINUX/themes/tango/info.png"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
patch_battlefield2
fi

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFAACgkQ5TH6yaoTykeByQCffQYfciXTS0PKNXMsckofGFBQ
eAUAoJ45NvOOjCG8RpRKmZT0dQbNlXY4
=MYTq
-----END PGP SIGNATURE-----
