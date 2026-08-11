#!/bin/bash
# Date : (2009-11-13 10-00)
# Last revision : (2009-11-13 10-00)
# Wine version used : -
# Distribution used to test : -
# Author : -
# Licence : -

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Tunguska"
PREFIX="Tunguska"

wget http://upload.wikimedia.org/wikipedia/en/8/8b/Tunguska-EU.png --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_presentation "$TYTUL" "Deep Silver" "http://www.deepsilver.de" "otty and NSLW" "$PREFIX"

POL_SetupWindow_message "Please insert $TYTUL media into your disk drive."
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

cd "$REPERTOIRE/ressources"

#downloading winetricks
if [ "`sha1sum < winetricks | sed 's/ .*//'`" != "0e10e20bf6920e2ae32372e10b5872f7c21a8fd4" ]; then
wget http://winezeug.googlecode.com/svn/trunk/winetricks --output-document=winetricks
fi

WINETRICKSDX=`cat winetricks | grep \/directx | cut -d'_' -f2`
WINETRICKSDXLINK=`cat winetricks | grep \/directx | cut -d'/' -f5,6,7,8`

mkdir "$HOME/.winetrickscache"
cd "$HOME/.winetrickscache"
#downloading DirectX
if [ ! -e "directx_${WINETRICKSDX}_redist.exe" ]; then
POL_SetupWindow_download "$LNG_DOWNLOADING DirectX 9.0c libraries" "$TITLE" "http://download.microsoft.com/download/$WINETRICKSDXLINK/directx_${WINETRICKSDX}_redist.exe"
fi

# checking if ppviewer.exe is in winetricks cache if not then download
if [ ! -e "ppviewer.exe" ]
then
POL_SetupWindow_download "PlayOnLinux is downloading GdiPlus" "GdiPlus" "http://download.microsoft.com/download/a/1/a/a1adc39b-9827-4c7a-890b-91396aed2b86/ppviewer.exe"
fi

#installing DirectX
cd "$REPERTOIRE/ressources"
POL_SetupWindow_wait_next_signal "$LNG_INSTALLING DirectX 9.0c libraries..." "$TYTUL"
bash winetricks -q d3dx9
POL_SetupWindow_detect_exit

#installing GDIPlus
POL_SetupWindow_wait_next_signal "PlayOnLinux is installing GDIPLUS" "$TYTUL"
bash winetricks -q gdiplus
POL_SetupWindow_detect_exit

Set_OS "winxp"

cd "$CDROM"
wine "setup.exe"
POL_SetupWindow_message "Click \"Next\" when installation will finish." "$TYTUL"

Set_Managed "On"
Set_DXGrab "On"

POL_SetupWindow_reboot

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Deep Silver/Tunguska" "AutoStarter.exe" "tunguska.ico" "$TYTUL" "" ""
POL_SetupWindow_Close

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Deep Silver/"
ln -sf "Geheimakte Tunguska" "Tunguska"

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEsACgkQ5TH6yaoTykf/OgCgmJGjgWnlvOy9HXXH5v90uRtH
JbwAn1ImFZlzh3QsGn7GXrB/rWf3pxbP
=esCs
-----END PGP SIGNATURE-----
