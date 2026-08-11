#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init
POL_SetupWindow_free_presentation "Jedi Knight Academy" "This setup will patch Jedi Knight Academy"

cd $REPERTOIRE/tmp

POL_SetupWindow_wait_next_signal "Please wait will the patch is downloaded" "Jedi Knight Academy"


POL_SetupWindow_wait_next_signal "Please wait will the patch is installed" "Jedi Knight Academy"

select_prefixe "$REPERTOIRE/wineprefix/JediKnightAcademy"
wget ftp://ftp.lucasarts.com/patches/pc/JKAcademy1_01.exe
wine ./JKAcademy1_01.exe
rm ./JKAcademy1_01.exe

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJDwACgkQ5TH6yaoTykeMDgCfZ1tVZM0ZGtPz+JOarScqOgiW
iHYAn0X+jOU0UFty9a+mvoblCmL5XLOY
=Cszv
-----END PGP SIGNATURE-----
