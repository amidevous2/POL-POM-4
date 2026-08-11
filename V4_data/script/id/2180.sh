#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init

TITLE="Winebottler Wrapper Import"

[ "$POL_OS" = "Mac" ] || POL_Debug_Fatal "This script is made for PlayOnMac only"

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'This tool will allow you to import a Winebottler Wrapper into PlayOnMac')" 

POL_SetupWindow_browse "$(eval_gettext "Select the Winebottler .dmg")" "$TITLE"


POL_SetupWindow_wait "$(eval_gettext "Please wait...")" "$TITLE"

dmg="$APP_ANSWER"

POL_Open "$APP_ANSWER" 

while [ ! -e "/Volumes/WineBottler Combo/" ]; do
    sleep 5
    i=$((i+1))
    [ "$i" = "5" ] && POL_Debug_Fatal "$(eval_gettext "The file does not seem to be a Winebottler dmg")"
done

version="$(/Volumes/WineBottler\ Combo/Wine.app/Contents/Resources/bin/wine --version)"

[ "$?" = "0" ] ||  POL_Debug_Fatal "$(eval_gettext "The file does not seem to be a Winebottler dmg")"

realver="${version/wine-/}-winebottler"

mkdir -p "$POL_USER_ROOT/wine/darwin-x86/$realver"

cp -r "/Volumes/WineBottler Combo/Wine.app/Contents/Resources/bin/" "$POL_USER_ROOT/wine/darwin-x86/$realver/bin"
cp -r "/Volumes/WineBottler Combo/Wine.app/Contents/Resources/lib/" "$POL_USER_ROOT/wine/darwin-x86/$realver/lib"
cp -r "/Volumes/WineBottler Combo/Wine.app/Contents/Resources/share/" "$POL_USER_ROOT/wine/darwin-x86/$realver/share"
rm "$POL_USER_ROOT/wine/darwin-x86/$realver/lib/libfreetype"*
umount "/Volumes/WineBottler Combo/"
POL_SetupWindow_message "Wine $realver has been successfully imported! You can now use it with your PlayOnMac programs" "$TITLE"


POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPJfy8ACgkQ5TH6yaoTyke1ZACfYqt84pj8SmHWGEqkM5xRs6R3
wKAAoKvIb2N5fwqIPgFCcMDou56wZ713
=HhnO
-----END PGP SIGNATURE-----
