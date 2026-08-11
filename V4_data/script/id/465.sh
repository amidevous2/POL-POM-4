#!/bin/bash
# Date : (2009-07-06 12-00)
# Last revision : (2010-01-16 10-00)
# Wine version used : 1.1.25
# Distribution used to test : Fedora 11
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick, unzip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Gothic 2"
PREFIX="Gothic2"
WORKINGWINEVERSION="1.1.36"

#procedure for patching Gothic 2
patch_gothic2()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
wine "$APP_ANSWER"
POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
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

wget http://upload.wikimedia.org/wikipedia/en/d/de/Gothic2cover.png --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "Piranha Bytes" "www.gothic2.com" "NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

LATESTVERSION=$(Get_Latest_Wine_Version)
CHOSENWINEVERSION="$LATESTVERSION"
Use_WineVersion "$CHOSENWINEVERSION"

#asking about patching or updating Wine version
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game~Change resolution" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
	patch_gothic2
elif [ "$APP_ANSWER" == "Change resolution" ]
then
Change_Resolution
fi

POL_SetupWindow_Close
exit
fi

POL_SetupWindow_message "Please insert first $TYTUL media into your disk drive."
POL_SetupWindow_cdrom

cd "$CDROM"
CHECK=$(find . -iwholename ./Gothic2-Setup.exe)

if [ "$CHECK" == "" ]; then
CHECK="Gothic2-Setup.exe"
else
CHECK="Setup.exe"
fi

POL_SetupWindow_check_cdrom "$CHECK"

#taking icon from the game
convert "$CDROM/Gothic2.ico" -geometry 32X32 "$REPERTOIRE/icones/32/$TYTUL"

POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%" |tr -d '\015' | tr -d '\010'`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#adding CD-ROM as drive e: f: g: to winecfg
CDROM2=${CDROM//"1"/"2"} #GOTHIC2_CD2
CDROM3=${CDROM//"1"/"3"} #GOTHIC2_CD3
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:
ln -s "$CDROM2" f:
ln -s "$CDROM3" g:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
echo "\"f:\"=\"cdrom\"" >> cdrom.reg
echo "\"g:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

cd "$REPERTOIRE/ressources/"
#downloading dlls required for music
POL_SetupWindow_wait_next_signal "PlayOnLinux is downloading DLLs required for playing music" "$TYTUL"

#dmband.dll (size 28.0KB)
if [ "`sha1sum < dmband.dll | sed 's/ .*//'`" != "72d574b557865850247e58ee69af84e37ef75ac2" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmband.dll" --output-document=dmband.dll
fi

#dmcompos.dll (size 60.0KB)
if [ "`sha1sum < dmcompos.dll | sed 's/ .*//'`" != "bc775f826398e9c6a656acbd41808217c995781e" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmcompos.dll" --output-document=dmcompos.dll
fi

#dmime.dll (size 177.0KB)
if [ "`sha1sum < dmime.dll | sed 's/ .*//'`" != "4dd11c042fd420325044ea379935a10102b0cc00" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmime.dll" --output-document=dmime.dll
fi

#dmloader.dll (size 35.0KB)
if [ "`sha1sum < dmloader.dll | sed 's/ .*//'`" != "4250676edacc33c54c6db511c812ff71571c305a" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmloader.dll" --output-document=dmloader.dll
fi

#dmsynth.dll (size 101.0KB)
if [ "`sha1sum < dmsynth.dll | sed 's/ .*//'`" != "7a7843d5f385795d6cc18f86e78c191ecd524424" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmsynth.dll" --output-document=dmsynth.dll
fi

#dmusic.dll (size 102.0KB)
if [ "`sha1sum < dmusic.dll | sed 's/ .*//'`" != "4eb4aa8f545c0073d012bfc69ceb837098db4f2e" ]; then
wget --referer="http://www.dlldump.com" "http://www.dlldump.com/dllfiles/D/dmusic.dll" --output-document=dmusic.dll
fi

#dmstyle.dll (size 103.5KB)
if [ "`sha1sum < dmstyle.dll.zip | sed 's/ .*//'`" != "e860c26e23310a5765c2e2110e40c5c076503643" ]; then
wget "http://www.dllbank.com/zip/d/dmstyle.dll.zip" --output-document=dmstyle.dll.zip
fi
unzip dmstyle.dll.zip

POL_SetupWindow_detect_exit

#starting installation
#POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
wine "$CDROM/$CHECK"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"
#POL_SetupWindow_detect_exit

#asking about memory size
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-890-1024-2048" "-" "256"
VMS="$APP_ANSWER"
 
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg

#copying dlls required for music
cd "$WINEPREFIX/drive_c/windows/system32"
cp -f "$REPERTOIRE/ressources/dmband.dll" dmband.dll
cp -f "$REPERTOIRE/ressources/dmcompos.dll" dmcompos.dll
cp -f "$REPERTOIRE/ressources/dmime.dll" dmime.dll
cp -f "$REPERTOIRE/ressources/dmloader.dll" dmloader.dll
cp -f "$REPERTOIRE/ressources/dmsynth.dll" dmsynth.dll
cp -f "$REPERTOIRE/ressources/dmusic.dll" dmusic.dll
cp -f "$REPERTOIRE/ressources/dmstyle.dll" dmstyle.dll

#overriding dlls required for music
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DllOverrides]" > override.reg
echo "\"dmband\"=\"native\"" >> override.reg
echo "\"dmcompos\"=\"native\"" >> override.reg
echo "\"dmime\"=\"native\"" >> override.reg
echo "\"dmloader\"=\"native\"" >> override.reg
echo "\"dmsynth\"=\"native\"" >> override.reg
echo "\"dmusic\"=\"native\"" >> override.reg
echo "\"dmstyle\"=\"native\"" >> override.reg
regedit override.reg

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#making shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/JoWooD/Gothic II/System" "Gothic2.exe" "" "$TYTUL" "" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$TYTUL"
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

POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFMACgkQ5TH6yaoTykedvwCffosNoNElKyqFARGlZCVP0jkU
xloAoJVxc2Ia+kAfmgHh6EwNrsSQ53Hy
=isid
-----END PGP SIGNATURE-----
