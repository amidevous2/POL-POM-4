#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

if [ "$POL_LANG" = "fr" ] ; then
	DL_BLENDER="Patientez pendant le téléchargement de Blender"
	DL_PYTHON="Patientez pendant le téléchargement de Python 2.5"
else
	DL_BLENDER="Please wait during downlad of Blender"
	DL_PYTHON="Please wait during download of Python 2.5"
fi
cd $REPERTOIRE/tmp/
rm *.png
wget $SITE/setups/blender/left.png
POL_SetupWindow_Init "" "left.png"

POL_SetupWindow_presentation "Blender" "Blender" "http://www.blender.org/" "cgizmo" "Blender"

select_prefixe "$REPERTOIRE/wineprefix/Blender/"
POL_SetupWindow_prefixcreate  

Set_OS "winxp"
cd $REPERTOIRE/tmp

POL_SetupWindow_download "$DL_BLENDER" "Blender" "http://mulx.playonlinux.com/files/blender/blender-2.45-windows.exe"

POL_SetupWindow_download  "$DL_PYTHON" "Blender" "http://mulx.playonlinux.com/files/blender/python-2.5.1.msi"

POL_SetupWindow_wait_next_signal "Please wait while blender is installed" "Blender"
wine msiexec.exe /i /q "python-2.5.1.msi"
wine "blender-2.45-windows.exe" /quiet
POL_SetupWindow_detect_exit
POL_SetupWindow_reboot 
POL_SetupWindow_make_shortcut "Blender 2.45" "Program Files/Blender Foundation/Blender" "blender.exe" "" "Blender"
POL_SetupWindow_message "Blender has been successfully installed" "Blender"
POL_SetupWindow_Close
exit 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGOTwsACgkQ5TH6yaoTykdCuQCaAq2SfYglAeThlFB1jHoUmvWD
PaIAn3m4xr55CiQzZp1FzrilzBTDIO5V
=PE0K
-----END PGP SIGNATURE-----
