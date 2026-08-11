#!/bin/bash
# CHANGELOG
# [SuperPlumus] (2012-04-07 19-14)
#   Update script to standards
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Alone In The Dark : The New Nightmare"
PREFIX="AloneInTheDarkTNN"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infogrames" "" "david" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

Set_Desktop "On" "1024" "768"
Set_OS "winxp"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
POL_SetupWindow_message "$(eval_gettext 'You dont have to install DirectX or use GLSetup.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/SETUP.EXE"
POL_Wine_WaitExit "$TITLE"

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'You dont have to install DirectX or use GLSetup.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

Set_Desktop "Off"

POL_Shortcut "launch.exe" "$TITLE"

#POL_SetupWindow_message "Don't forget to create a CD-ROM device (named D:) pointing\nto your CD-ROM unit." "Warning"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+AfTQACgkQ5TH6yaoTykeQ6wCdEvv8UysK66WAGyTaLs2QtdKC
+iYAniCiAyXCKx+7IBO2t30haieCQ8vs
=4d5E
-----END PGP SIGNATURE-----
