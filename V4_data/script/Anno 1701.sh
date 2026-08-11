#!/bin/bash
# Date : (2011-03-23 10-00)
# Last revision : 
# Wine version used : 1.3.16
# Distribution used to test : Kubuntu 10.10 64bits
# Author : Benji64 & GNU_Raziel
# Licence : Retail
# Only for : http://www.playonlinux.com

# CHANGELOG
# [Benji64 & GNU_Raziel] (2011-03-23 10-00)
#   First script.
# [Dadu042] (2019-12-31)
#   Some updates.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Anno 1701"
PREFIX="Anno1701"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_ANNO_INSTALL="Anno 1701 est en cours d'installation..."
LNG_FIN="Installation terminée !\n\n\nScript créé d'après les informations tirées du site de Wine :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=6822\n\nINFORMATION : vous devez contourner les protections anti-piratage pour faire fonctionner ce jeu."
else
LNG_ANNO_INSTALL="Installing Anno 1701..."
LNG_FIN="Installation complete !\n\n\nThis script has been d from Wine Website information :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=3775\n\nINFORMATION : you'll have to disable anti-piracy protections to run this game."
fi
 
# Présentation
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Related Designs" "http://www.related-designs.de/" "Benji64 & GNU_Raziel" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"

POL_Wine_PrefixCreate
 
# Installation de Anno 1701
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
POL_SetupWindow_wait_next_signal "$LNG_ANNO_INSTALL" "$TITLE"
wine $CDROM/setup.exe
INSTALL_ON="1"
until [ "$INSTALL_ON" == "" ]; do
sleep 5
INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
done
POL_SetupWindow_detect_exit
 
# Fix for this game
cd "$POL_USER_ROOT/tmp"
cat << EOF > anno_fix.reg
[HKEY_CURRENT_USER\Software\Wine\Direct3D]
"OffscreenRenderingMode"="fbo"
"UseGLSL"="enable"
EOF
regedit anno_fix.reg
POL_Call POL_Function_OverrideDLL "native" "dbghelp"
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
chmod -R 777 "$POL_USER_ROOT/tmp/"
rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Fin de l'installation
POL_SetupWindow_auto_shortcut "$PREFIX" "Anno1701.exe" "$TITLE" "" "Game;"
 
POL_SetupWindow_message "$LNG_FIN" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtHDgAKCRDlMfrJqhPK
R20DAJ0ftlU8DRQhF0eKts1mSrE4qIqOBACfbk5MFPIEzb6PbJdWcZhq/tdbUzs=
=n/E9
-----END PGP SIGNATURE-----
