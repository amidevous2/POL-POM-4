#!/bin/bash
# Date : (2012-02-11 08-38)
# Last revision : (2019-05-23)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Author : Pierre Etchemaite pe-pol@concept-micro.com
#   Previous version by Panzer
# Script licence : GPL v.2
# Program licence : Freeware
# Depend :
#
# CHANGELOG
# [Dadu042] (2019-05-23)
#   Did not run on POL 4.3.4. Wine updated. Set_OS WinXP instead of Win98.
# [Panzer] (2012-02-11)
#   Initial writting.
 
# Tested with install archives:
# VMOnline.zip 19559265 "133067458043d0bca7e988d74dba52af"
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="VMOv2"
WORKING_WINE_VERSION="3.0"
 
TITLE="Vantage Master Online"
URL="http://www.falcom.co.jp/vantage/"
SHORTCUT_NAME="Vantage Master Online"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Falcom" "$URL" "Pierre Etchemaite" "$PREFIX"
 
POL_SetupWindow_question "$(eval_gettext 'Do you want to browse $TITLE website?')" "$TITLE"
[ "$APP_ANSWER" = "TRUE" ] && POL_Browser "$URL"
 
if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://file.4gamer.net/old2/demo2/VMOnline.zip" "133067458043d0bca7e988d74dba52af"
    ARCHIVE="$POL_USER_ROOT/tmp/VMOnline.zip"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp"
 
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
 
cd "$WINEPREFIX/drive_c"
unzip "$ARCHIVE"
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_VMS "2"
 
# Midi music (other choice is audio CD)
cat <<_EOFINI_ >> "$POL_USER_ROOT/tmp/vmomidi.reg"
REGEDIT4
 
[HKEY_LOCAL_MACHINE\Software\FALCOM\VMV2_WIN]
"BGM Device"=hex:01,00,00,00
 
_EOFINI_
POL_Wine regedit "$POL_USER_ROOT/tmp/vmomidi.reg"
rm "$POL_USER_ROOT/tmp/vmomidi.reg"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
POL_Shortcut "vmv2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" ""
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOZeswAKCRDlMfrJqhPK
R26jAKCuBVhKp47UcNQ0YllNTHIlodvmoACglcftxdqExTmQipwP61YxbHWTOxE=
=QI9N
-----END PGP SIGNATURE-----
