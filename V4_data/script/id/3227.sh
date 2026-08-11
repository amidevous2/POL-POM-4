#!/usr/bin/env playonlinux-bash


# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_1:_Getting_to_know_Bash

 

# https://s3.amazonaws.com/SQLyog_Community/SQLyog+12.4.3/SQLyog-12.4.3-0.x86Community.exe

 

POL_WIN_TITLE="Install SQLYog Community 12.4.3 - 32bits"


POL_URL_PROG="https://s3.amazonaws.com/SQLyog_Community/SQLyog+12.4.3/SQLyog-12.4.3-0.x86Community.exe"

 

[ "$PLAYONLINUX" = "" ] && exit 0


source "$PLAYONLINUX/lib/sources"


 


POL_SetupWindow_Init

 

POL_SetupWindow_message "Hello" "$POL_WIN_TITLE"

 

POL_SetupWindow_message "Download and install: $POL_URL_PROG" "$POL_WIN_TITLE"

 

POL_SetupWindow_InstallMethod "DOWNLOAD"

 

POL_System_TmpCreate "SQLyog-tmp"


cd "$POL_System_TmpDir"


POL_Download "$POL_URL_PROG" "1bbb01b2c8dbdc905cbfce3c64b40b42"

 

INSTALLER="$POL_System_TmpDir/SQLyog-12.4.3-0.x86Community.exe"

 

POL_Wine_SelectPrefix "SQLyogCommunity"


POL_Wine_PrefixCreate


 


POL_SetupWindow_wait "Installation in progress." "SQLyog community"


POL_Wine "$INSTALLER"


 


POL_System_TmpDelete


 


POL_Shortcut "SQLyogCommunity.exe" "SQLyog Community"

 

POL_SetupWindow_message "Goodbye" "Test"

 

POL_SetupWindow_Close


exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNUDgAKCRDlMfrJqhPK
R7eHAJ9xttcMb0MFFqR5XBhizj8V9sfWvACfSuJoQSTaxZ+JVPgnUoQ6ThHRfnI=
=Ym7c
-----END PGP SIGNATURE-----
