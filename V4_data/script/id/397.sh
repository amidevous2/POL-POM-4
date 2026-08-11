#!/bin/bash
# Date : (2009-05-23 12-14)
# Last revision : 
# Wine version used : 2.22
# Distribution used to test : Fedora 12
# Author : NSLW
# Licence : Retail
#
# CHANGELOG
# [NSLW] (2009-05-23 12-14)
#   First script.
# [NSLW] (2009-12-26 15-00)
#   ?
# [Dadu042] (2020-01-29)
#   Wine 1.1.26 -> 2.22 (untested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Need for Speed 4: High Stakes"
PREFIX="NFS4"

LATKAD3D="NFS_HS_SP_Setup_(V3.0_beta_1.63)"
LATKAGLIDE="NFS_HS_SP_Setup_(V2.2_Build_1.43)"
TYTULLATKI=
WORKINGWINEVERSION="2.22"

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

wget http://upload.wikimedia.org/wikipedia/en/e/e2/NFS_High_Stakes_box.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TYTUL" "EA Games" "N/A" "NSLW" "$PREFIX" 

POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
cd "$CDROM"
CHECK=$(find . -iwholename ./setup.exe)

if [ "$CHECK" == "" ]; then
CHECK="setup.exe"
fi

POL_SetupWindow_check_cdrom "$CHECK"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

Set_OS "win98"

#adding CD-ROM as drive e: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" e:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"e:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

sleep 5

POL_SetupWindow_message "Installation process will start now.\nPlease choose Full installation." "Installation tips" "$PLAYONLINUX/themes/tango/info.png"

#starting installation
cd "$CDROM"
wine autorun.exe
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

if [ -d "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Need For Speed High Stakes" ]; then
SUBTYTUL="Need For Speed High Stakes"
elif [ -d "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Need For Speed Road Challenge" ]
then
SUBTYTUL="Need For Speed Road Challenge"
elif [ -d "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Need For Speed IV:High Stakes" ]
then
SUBTYTUL="Need For Speed IV:High Stakes"
else
SUBTYTUL="Need For Speed"
fi

#choosing display driver
POL_SetupWindow_menu "What display driver would you like to use?" "Display drivers" "Direct3D(recommended) Glide" " "
DDRV="$APP_ANSWER"


cd "$REPERTOIRE/ressources"
if [ "$DDRV" == "Glide" ]; then
TYTULLATKI="$LATKAGLIDE"
#downloading patch
if [ ! -e "NFS_HS_SP_Installer.zip" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading NFS_HS_SP_Installer.zip" "Downloading patch" "http://www.hsscoring.com/download/NFS_HS_SP_Installer.zip"
fi
POL_SetupWindow_message "Patching process will start now.\nPlease:\n -disable IP Racing Lounge\n-disable Set NTFS rights\n-disable Firewall entry\n-enable Zechensack's Glide Wrapper\nDon't run 3DSetup if prompted" "Installation tips" "$PLAYONLINUX/themes/tango/info.png"

cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$REPERTOIRE/ressources/NFS_HS_SP_Installer.zip"

else

TYTULLATKI="$LATKAD3D"
#downloading patch
if [ ! -e "$TYTULLATKI.zip" ]; then
POL_SetupWindow_download "PlayOnLinux is downloading $TYTULLATKI.zip" "Downloading patch" "http://www.hsscoring.com/download/$TYTULLATKI.zip"
fi
POL_SetupWindow_message "Patching process will start now.\nPlease:\n -disable IP Racing Lounge\n-disable Set NTFS rights\n-disable Firewall entry\n-disable Glide Wrapper\n-enable Movies\nDon't run 3DSetup" "Installation tips" "$PLAYONLINUX/themes/tango/info.png"

cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$REPERTOIRE/ressources/$TYTULLATKI.zip"

fi

POL_SetupWindow_wait_next_signal "Installation in progress..." "$SUBTYTUL"
Set_OS "win2k"
wine "$TYTULLATKI.exe"
POL_SetupWindow_message "Patch for $SUBTYTUL installed successfully" "$SUBTYTUL"


if [ "$DDRV" == "Direct3D(recommended)" ]; then
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/$SUBTYTUL"
cp -f "3dSetup.bak/d3da.dll" "d3da.dll"

cd "$REPERTOIRE/tmp/"
echo "[HKEY_LOCAL_MACHINE\Software\Electronic Arts\Need for Speed High Stakes]" > d3d.reg
echo "\"3D Card\"=\"NVidia TNT2\"" >> d3d.reg
echo "\"3D Device Description\"=\"NVIDIA RIVA TNT2\"" >> d3d.reg
echo "\"D3D Device\"=dword:00000001" >> d3d.reg
echo "\"Group\"=\"D3D\"" >> d3d.reg
echo "\"Hardware Acceleration\"=dword:00000001" >> d3d.reg
echo "\"InstallPath\"=\"C:\\\\$PROGRAMFILES\\\\Electronic Arts\\\\$SUBTYTUL\"" >> d3d.reg
echo "\"Thrash Driver\"=\"d3d\"" >> d3d.reg
echo "\"Thrash Resolution\"=\"1024x768\"" >> d3d.reg
echo "\"Triple Buffer\"=dword:00000000" >> d3d.reg
echo "\"Version\"=\"4.50\"" >> d3d.reg
regedit d3d.reg

elif [ "$DDRV" == "Glide" ]
then
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/$SUBTYTUL/3dSetup"
wine Spot3DSetup.exe

#set "Thread policy" to "One thread for both"
#cd "$WINEPREFIX/drive_c/users/$USER/Application Data"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/GlideWrapper"
cp glide_wrapper.zbag.ini glide_wrapper.zbag.bak
head glide_wrapper.zbag.ini -n 15 > glide_wrapper.zbag2.ini
echo thread_policy=1 >> glide_wrapper.zbag2.ini
tail glide_wrapper.zbag.ini -n+17 >> glide_wrapper.zbag2.ini
mv -f glide_wrapper.zbag2.ini glide_wrapper.zbag.ini
fi

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Electronic Arts/$SUBTYTUL" "nfshs.exe" "" "$SUBTYTUL" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION" "$SUBTYTUL"
POL_SetupWindow_make_icon_for_shortcut "$SUBTYTUL" "*_nfshs.0.xpm"

if [ "$DDRV" == "Glide" ]; then
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/GlideWrapper" "configurator.exe" "" "NFSHS GlideWrapper Configurator" ""
Set_WineVersion_Assign "$WORKINGWINEVERSION" "NFSHS GlideWrapper Configurator"
POL_SetupWindow_make_icon_for_shortcut "NFSHS GlideWrapper Configurator" "*_nfshs.0.xpm"
fi

POL_SetupWindow_message "$SUBTYTUL installed successfully" "$SUBTYTUL"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH2rQAKCRDlMfrJqhPK
R1AoAJ4tvfLD+4JyDAhcbSCHGwTLrKMznACdFrYoEVk5kISUi1XM8ESGdwsU3mQ=
=M7iz
-----END PGP SIGNATURE-----
