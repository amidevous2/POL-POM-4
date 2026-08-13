#!/usr/bin/env playonlinux-bash

# CHANGELOG
# [Kukulo] (2016-02-14)
#   First script (Wine 1.9.3)
# [Dadu042] (2020-01-02)
#   Wine 1.9.3 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
WINE_VERSION="3.0.3"
TITLE="MesterMc Minecraft Client"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "MesterMc Minecraft Client" "Kukulo" "MesterMc"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "MesterMc2"
POL_Wine_PrefixCreate "$WINE_VERSION"
POL_System_TmpCreate "MesterMc2"
 
cd "$POL_System_TmpDir"
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jre-7u79-windows-i586.exe
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/jre-7u79-windows-i586.exe"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "http://rubugvkrwjee.mestermc.hu/3TtRL64MJ7yV1YQ/mestermchutelepito.exe"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$POL_System_TmpDir/mestermchutelepito.exe"
elif [ "$INSTALL_METHOD" = "LOCAL" ]
then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the install file.')" "$TITLE"
        SETUP_PATH="$APP_ANSWER"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$SETUP_PATH"
fi
  
POL_Wine_WaitExit "$TITLE"
  
POL_Shortcut "MesterMc.exe" "MesterMc" "" "" "Game;"
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg30kQAKCRDlMfrJqhPK
R2TqAJ9z0EQPHcPRp1jz3WmBT9nEKvMwzgCcDnqdGFNQ59c8Yk0EB7IoxDwujEI=
=EYqe
-----END PGP SIGNATURE-----
