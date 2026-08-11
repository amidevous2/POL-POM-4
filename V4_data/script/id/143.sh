#!/bin/bash
# Date : (2009-09-19 18-00)
# Last revision : (2010-12-22 18-03)
# Wine version used : 1.1.29
# Distribution used to test : Fedora 11
# Author : NSLW
# Licence : Retail
# Depend : ImageMagick
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

Get_Latest_Wine_Version()
{
wget http://mulx.playonlinux.com/wine/linux-i386/LIST --output-document="$REPERTOIRE/tmp/LIST"
xyz=`cat "$REPERTOIRE/tmp/LIST" | sed -e 's/\.//g' | cut -d';' -f2 | sort -n | tail -n1`
echo "$(echo $xyz | cut -c1-1).$(echo $xyz | cut -c2-2).$(echo $xyz | cut -c3-4)"
}

POL_SetupWindow_make_icon_for_shortcut()
{
convert "$HOME/.local/share/icons/$2" -geometry 32X32 "$REPERTOIRE/icones/32/$1"
}

TYTUL="MS Office 2000"
PREFIX="Office2000"
WOKRINGVERSION="1.1.28"

EXENAME[0]="WINWORD"
APPNAME[0]="Word"
ICOINDEX[0]="0c5e_wordicon.0.xpm"

EXENAME[1]="EXCEL"
APPNAME[1]="Excel"
ICOINDEX[1]="0c5e_xlicons.0.xpm"

EXENAME[2]="POWERPNT"
APPNAME[2]="PowerPoint"
ICOINDEX[2]="0c5e_pptico.0.xpm"

EXENAME[3]="MSACCESS"
APPNAME[3]="Access"
ICOINDEX[3]="0c5e_accicons.0.xpm"

EXENAME[4]="FRONTPG"
APPNAME[4]="Frontpage"
ICOINDEX[4]="0c5e_misc.9.xpm"

EXENAME[5]="OUTLOOK"
APPNAME[5]="Outlook"
ICOINDEX[5]="0c5e_outicon.0.xpm"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TYTUL" "Microsoft" "www.microsoft.com" "NSLW" "$PREFIX" 

LATESTVERSION=$(Get_Latest_Wine_Version)
CHOSENWINEVERSION="$LATESTVERSION"
CHOSENWINEVERSION="$WOKRINGVERSION"
POL_SetupWindow_install_wine "$CHOSENWINEVERSION"
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
Use_WineVersion "$CHOSENWINEVERSION" 
POL_SetupWindow_prefixcreate
 
POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom

#checking if installer is setup.exe, INSTALAR.EXE or install.exe
cd "$CDROM"
CHECK=$(find . -iwholename ./setup.exe)
if [ "$CHECK" == "" ]; then
CHECK=$(find . -iwholename ./INSTALAR.EXE)
fi
if [ "$CHECK" == "" ]; then
CHECK="install.exe"
fi

POL_SetupWindow_check_cdrom "$CHECK" 

#starting installation
cd "$CDROM"
wine "$CHECK"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

mkdir "$HOME/.winetrickscache"
cd "$HOME/.winetrickscache"
# checking if jet40sp8_9xnt.exe is in winetricks cache if not then download
if [ ! -e "jet40sp8_9xnt.exe" ]
then
POL_SetupWindow_download "PlayOnLinux is downloading MS Jet 4.0 Service Pack 8" "MS Jet 4.0 Service Pack 8" "http://download.microsoft.com/download/4/3/9/4393c9ac-e69e-458d-9f6d-2fe191c51469/jet40sp8_9xnt.exe"
fi

# checking if MDAC_TYP.EXE is in winetricks cache if not then download
if [ ! -e "MDAC_TYP.EXE" ]
then
POL_SetupWindow_download "PlayOnLinux is downloading MS MDAC 2.8" "MS MDAC 2.8" "http://download.microsoft.com/download/c/d/f/cdfd58f1-3973-4c51-8851-49ae3777586f/MDAC_TYP.EXE"
fi

# checking if vc6redistsetup_enu.exe is in winetricks cache if not then download
if [ ! -e "vc6redistsetup_enu.exe" ]
then
POL_SetupWindow_download "PlayOnLinux is downloading MS Visual C++ 6 sp4 libraries" "MS Visual C++ 6 sp4 libraries" "http://download.microsoft.com/download/vc60pro/update/1/w9xnt4/en-us/vc6redistsetup_enu.exe"
fi


cd "$REPERTOIRE/ressources/"
#downloading winetricks
if [ "`sha1sum < winetricks | sed 's/ .*//'`" != "1bc6af44c8584f01d8e3db0abce6ae869b55e1e4" ]; then
wget http://winezeug.googlecode.com/svn/trunk/winetricks --output-document=winetricks
fi

#installing mdac28
POL_SetupWindow_wait_next_signal "Installing MS MDAC 2.8..." "$TYTUL"
bash winetricks -q mdac28
POL_SetupWindow_detect_exit

#installing jet40
POL_SetupWindow_wait_next_signal "Installing MS Jet 4.0 Service Pack 8..." "$TYTUL"
bash winetricks -q jet40
POL_SetupWindow_detect_exit

#installing mfc42
POL_SetupWindow_wait_next_signal "MS Visual C++ 6 sp4 libraries..." "$TYTUL"
bash winetricks -q mfc42
POL_SetupWindow_detect_exit

#making shortcuts
for i in `seq 0 5`;
do
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/Office"
if [ -e "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Office/Office/${EXENAME[$i]}.EXE" ]; then
POL_SetupWindow_make_icon_for_shortcut "Microsoft Office ${APPNAME[$i]} 2000" "${ICOINDEX[$i]}"
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Microsoft Office/Office" "${EXENAME[$i]}.EXE" "" "Microsoft Office ${APPNAME[$i]} 2000" "" ""
Set_WineVersion_Assign "$CHOSENWINEVERSION" "Microsoft Office ${APPNAME[$i]} 2000"
fi
done 
POL_SetupWindow_reboot
POL_SetupWindow_message "$TYTUL has been installed successfully" "$TYTUL"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEIACgkQ5TH6yaoTykfxTwCfbnGSn2s5ElrvVlkkSxOwHkiK
4BsAnRT3s+KhcgYGHlmTSbn8lkod5bUs
=mWy0
-----END PGP SIGNATURE-----
