#!/bin/bash
# Fecha : (06 Junio 2015)
# Distro : Manjaro Linux 64-bit
# Autor : Inukaze ( http://inukaze.wordpress.com / http://www.dailymotion.com/inukaze )
# Licencia : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [Inukaze ] (2015-06-06)
#   First script.
# [Dadu042] (2019-09-28)
#   Wine 1.7.22 -> 3.0.3
#   Replace 7zip's unrar with unrar.

# KNOWN ISSUES:
#  - Wine amd64 3.0.3: no music. Tried: force Alsa. Fix: POL_install_directmusic.
#  - Wine amd64 3.0.3: 'fixme:richedit:ME_HandleMessage ...'.  Fix: install_riched30
#  - Wine amd64 3.0.3: 'fixme:mciwave:MCIWAVE_DriverProc Unsupported command [2115]'. Fix: install dsound or directmusic.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GAME_VMS="64"
AUTHOR="Vlambeer"
WINEVERSION="3.0.3"
TITLE="Super Crate Box"
PREFIX="Super_Crate_Box"
GAME_URL="http://supercratebox.com/"
DOWNLOAD_GAME="http://www.supercratebox.com/download/supercratebox.rar"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# This was for Wine 1.7.22 (2015). Also required for Wine 3.0.3
POL_Call POL_Install_dsound
POL_Call POL_Install_dinput
POL_Call POL_Install_directmusic

## Sound problem fix - pulseaudio related
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

rm -rf "$WINEPREFIX/drive_c/SuperCrateBox"
mkdir -p "$WINEPREFIX/drive_c/SuperCrateBox"
cd "$WINEPREFIX/drive_c/SuperCrateBox"

POL_Download $DOWNLOAD_GAME 962d90ba1aa0e8095f2cbfd2940c5858
POL_System_unrar x "supercratebox.rar" "$WINEPREFIX/drive_c/SuperCrateBox/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
rm "$WINEPREFIX/drive_c/SuperCrateBox/supercratebox.rar"

# To avoid the surprising error:   wine: cannot find L"C:\\windows\\system32\\supercratebox.exe"
cp "$WINEPREFIX/drive_c/SuperCrateBox/supercratebox.exe" "$WINEPREFIX/drive_c/windows/system32/"

POL_SetupWindow_VMS $GAME_VMS
POL_Wine_Direct3D "OffscreenRenderingMode" "pbuffer"
POL_Wine_Direct3D "UseGLSL" "disabled"
POL_Shortcut "supercratebox.exe" "$TITLE" "$TITLE.png" "" "Game;ActionGame;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXd/VEgAKCRDlMfrJqhPK
R6/LAJ9A3UUtX99PzNiqBWLgTFRe3QES6wCfdeSgq4Hdp+bSVfoJIYPMNoPheEc=
=mie2
-----END PGP SIGNATURE-----
