#!/bin/bash
#
# CHANGELOG
# [DemonHypnos] (201x ?)
#   First script.
# [Dadu042] (2019-12-09)
#   Standardize NoCD, shortcut.

if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

wget http://upload.wikimedia.org/wikipedia/en/9/91/Systemshock2box.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "System Shock 2" "Irrational Games" "http://www.irrationalgames.com/shock2/index.php" "DemonHypnos" "SS2"

POL_Call POL_Function_NoCDWarning

select_prefix "$REPERTOIRE/wineprefix/SS2/"
POL_SetupWindow_prefixcreate
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

Set_OS win98

POL_SetupWindow_wait_next_signal "Installing System Shock 2...please wait patiently..." "System Shock 2"
wine "$CDROM/setup.exe"

POL_SetupWindow_detect_exit

echo "[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]" > $REPERTOIRE/tmp/Res.reg
Set_Desktop "On" "1024" "768"
regedit $REPERTOIRE/tmp/Res.reg
rm -f $REPERTOIRE/tmp/Res.reg 

mv -r $WINEPREFIX/Sshock2/cutscenes $WINEPREFIX/Sshock2/cutsceness
POL_SetupWindow_reboot

POL_Shortcut "shock2.exe" "System Shock 2" "" "" "Game;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXe1MgwAKCRDlMfrJqhPK
R/rDAJ4+RTiCJly8EvlUFio+dTsTXWE4YwCfXVOpyQ/AAAsZl+gAeWsjOErQSJ0=
=wMwq
-----END PGP SIGNATURE-----
