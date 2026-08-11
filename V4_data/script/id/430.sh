#!/bin/bash
# Date : (2009-06-15 22-00)
# Last revision : (2009-06-15 22-00)
# Wine version used : 1.1.23
# Distribution used to test : Fedora 11
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick, icoutils

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

#fetching APPDATA environmental variable
APPDATA=`wine cmd /c echo "%AppData%"`
USER=`wine cmd /c echo "%User%"`
APPDATA=`echo $APPDATA | sed -e "s/$USER/\./" | cut -d'.' -f2 | cut -d'\' -f2`

LOCALSETTINGS="Local Settings"

TYTUL="Supreme Commander"
PREFIX="SupremeCommander"
#procedure for patching Supreme Commander
patch_SupremeCommander()
{
POL_SetupWindow_browse "Select patch file" "$TYTUL" ""
	POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
	wine "$APP_ANSWER"
	POL_SetupWindow_detect_exit
	POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"
}

Get_Latest_Wine_Version()
{
wget http://mulx.playonlinux.com/wine/linux-i386/LIST --output-document="$REPERTOIRE/tmp/LIST"
xyz=`cat "$REPERTOIRE/tmp/LIST" | sed -e 's/\.//g' | cut -d';' -f2 | sort -n | tail -n1`
echo "$(echo $xyz | cut -c1-1).$(echo $xyz | cut -c2-2).$(echo $xyz | cut -c3-4)"
}

POL_SetupWindow_make_icon_for_shortcut()
{
LAUNCHERFILENAME="$REPERTOIRE/configurations/installed/$1"
EXEPATH=`cat "$LAUNCHERFILENAME" | tail -n 2 | head -n 1 | cut -d'"' -f2`
EXENAME=`cat "$LAUNCHERFILENAME" | tail -n 1 | cut -d'"' -f2`

wrestool "$EXEPATH/$EXENAME" -x -t14 > "$REPERTOIRE/tmp/icon.ico"
ICOBITDEPTH=`icotool -l "$REPERTOIRE/tmp/icon.ico" | grep '\-\-width=32' | cut -d' ' -f5 | cut -d'=' -f2 | sort -n |tail -n 1`
ICOINDEX=`icotool -l "$REPERTOIRE/tmp/icon.ico" | grep "\-\-width=32" | grep "\-\-bit-depth=$ICOBITDEPTH" | tail -n 1 | cut -d' ' -f2 | cut -d'=' -f2`
icotool -x --index=$ICOINDEX "$REPERTOIRE/tmp/icon.ico" -o "$REPERTOIRE/icones/32/$1"
}


	GetXrandrModes()
	{
	cd  "$WINEPREFIX/drive_c/windows/temp/"
	rm -f xrandr2
	xrandr >& xrandr
	for i in `seq 3 10`;
        do
	x[$i-3]=`cat xrandr | head -n $i | tail -n 1 |cut -d'x' -f1 | sed -e 's/ //g'`
	y[$i-3]=`cat xrandr | head -n $i | tail -n 1 |cut -d'x' -f2 | cut -d' ' -f1`
	refreshrate[$i-3]=`cat xrandr | head -n $i | tail -n 1 |cut -d'x' -f2 | cut -d'.' -f1 | sed -e "s/${y[$i-3]}//g" | sed -e 's/ //g'`
	counter=`expr $i - 3`
	echo ${x[$i-3]},${y[$i-3]},${refreshrate[$i-3]} >> xrandr2
	if [ "${x[$i-3]}" == "1024" ]; then
	break
	fi
        done
	}


choose_SC_res()
{
GetXrandrModes
cd  "$WINEPREFIX/drive_c/windows/temp/"
MODESLIST=`cat xrandr2`
echo $MODESLIST >& xrandr3
MODESLIST=`cat xrandr3`
POL_SetupWindow_menu "Choose display resolution?" "Display resolution" "$MODESLIST" " "
SCMODE=$APP_ANSWER
TYTUL=`echo $TYTUL | sed -e "s/- //g"`

OLDMODE=`cat "$WINEPREFIX/drive_c/users/$USER/$LOCALSETTINGS/$APPDATA/Gas Powered Games/$TYTUL/Game.prefs" | grep "primary_adapter = '" | cut -d"'" -f2`
echo $OLDMODE
sed -e "s/$OLDMODE/$SCMODE/g" "$WINEPREFIX/drive_c/users/$USER/$LOCALSETTINGS/$APPDATA/Gas Powered Games/$TYTUL/Game.prefs" >& "Game.prefs"

rm -f "$WINEPREFIX/drive_c/users/$USER/$LOCALSETTINGS/$APPDATA/Gas Powered Games/$TYTUL/Game.prefs"
mv "Game.prefs" "$WINEPREFIX/drive_c/users/$USER/$LOCALSETTINGS/$APPDATA/Gas Powered Games/$TYTUL/Game.prefs"
}

wget http://upload.wikimedia.org/wikipedia/en/f/f7/SupCom-win-cover.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "THQ" "supremecommander.com" "NSLW" "$PREFIX" 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#asking about Addon
POL_SetupWindow_question "Is this Supreme Commander Forged Alliance?" "$TYTUL"
if [ "$APP_ANSWER" == "TRUE" ] ;then
TYTUL="Supreme Commander - Forged Alliance"
SSRate="44100"
SCEXEC="ForgedAlliance.exe"
PATCHFILE="supcom_fa_patch_1.5.3596_to_1.5.3599.exe"
else
SSRate="48000"
SCEXEC="SupremeCommander.exe"
PATCHFILE="supcom_patch_1.0.3189_to_1.1.3280.exe"
fi

#asking about patching or changing resolution
if [ -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_menu "What do you want to do?" "Actions" "Patch game~Change resolution" "~"

if [ "$APP_ANSWER" == "Patch game" ]; then
	patch_SupremeCommander
elif [ "$APP_ANSWER" == "Change resolution" ]
then
	choose_SC_res
fi
POL_SetupWindow_Close
exit
fi
	cd "$REPERTOIRE/ressources/"
	#determining which Version is the latest
	LATESTVERSION=$(Get_Latest_Wine_Version)
	CHOSENWINEVERSION="$LATESTVERSION"
	POL_SetupWindow_install_wine "$CHOSENWINEVERSION"
	Use_WineVersion "$CHOSENWINEVERSION"
POL_SetupWindow_message "Please install icoutils\nif you wan't to have nice icon for the game in PlayOnLinux main menu" "Note about icon" "/usr/share/playonlinux/themes/tango/info.png"
POL_SetupWindow_prefixcreate

cd "$REPERTOIRE/ressources"
#downloading winetricks
if [ "`sha1sum < winetricks | sed 's/ .*//'`" != "bf24bc6d84a40a836d7ce6de41ff04f910b34434" ]; then
wget http://winezeug.googlecode.com/svn/trunk/winetricks --output-document=winetricks
fi

#downloading .NET Framework 2.0
if [ ! -e "$HOME/.winetrickscache/dotnet20/dotnetfx.exe" ]
then
mkdir "$HOME/.winetrickscache"
mkdir "$HOME/.winetrickscache/dotnet20"
cd "$HOME/.winetrickscache/dotnet20"
POL_SetupWindow_download "PlayOnLinux is downloading .NET Framework" ".NET Framework 2.0" "http://download.microsoft.com/download/5/6/7/567758a3-759e-473e-bf8f-52154438565a/dotnetfx.exe"
POL_SetupWindow_download "PlayOnLinux is downloading .NET Framework" ".NET Framework 2.0" "http://kegel.com/wine/l_intl.nls"
fi

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
#adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
sleep 5

cd "$REPERTOIRE/ressources"
#installing .NET Framework 2.0
POL_SetupWindow_wait_next_signal "Installing .NET Framework 2.0..." "$TYTUL"
bash winetricks -q dotnet20 fontsmooth-enable
POL_SetupWindow_detect_exit

#starting installation
cd $CDROM
wine "setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

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

#part to get sound working
Set_SoundDriver "alsa"
Set_SoundSampleRate "$SSRate"

#cleaning temp
cd "$WINEPREFIX/drive_c/windows/temp/"
rm -rf *

#making shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/THQ/Gas Powered Games/$TYTUL/bin" "$SCEXEC" "" "$TYTUL" "" ""
Set_WineVersion_Assign "$CHOSENWINEVERSION" "$TYTUL"
POL_SetupWindow_make_icon_for_shortcut "$TYTUL"

POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

POL_SetupWindow_message "Make sure your Color Depth is set to 24 bits.\nOtherwise the game will not render fonts or 3D models correctly\n(Note by HAARP)" "Note about Color Depth" "$PLAYONLINUX/themes/tango/info.png"

POL_SetupWindow_message "To change game resolution\nrun this script again after running the game" "Note about resolution" "$PLAYONLINUX/themes/tango/info.png"

#asking about patching
POL_SetupWindow_question "Do you want to patch your game?" "$TYTUL" 
if [ "$APP_ANSWER" == "TRUE" ]; then

POL_SetupWindow_menu "What installer should do?" "Actions" "Let me choose patch manually~Download patch automatically" "~"

if [ "$APP_ANSWER" == "Let me choose patch manually" ]; then
patch_SupremeCommander
elif [ "$APP_ANSWER" == "Download patch automatically" ]
	then
	cd "$REPERTOIRE/ressources"
	#downloading patch
	if [ ! -e "$REPERTOIRE/ressources/$PATCHFILE" ]; then
	POL_SetupWindow_download "PlayOnLinux is downloading $PATCHFILE" "Downloading patch" "http://thq.vo.llnwd.net/o10/SC/live/$PATCHFILE"
	fi
	POL_SetupWindow_wait_next_signal "Installation in progress..." "$TYTUL"
	wine "$PATCHFILE"
	POL_SetupWindow_detect_exit
	POL_SetupWindow_message "Patch for $TYTUL has been installed successfully" "$TYTUL"	
fi

fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAk1cJFEACgkQ5TH6yaoTykfjZwCXQWUvxCiBdnEhE9gnUIpg1wAx
FACfbeJ4eDyjYvGLukUsArLmVI93krQ=
=5/6+
-----END PGP SIGNATURE-----
