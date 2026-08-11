#!/bin/bash
# Date: (2010-09-15  12-39)
# Last revision: (2011-06-24  16-40)
# Wine version used: 1.2
# Distribution used to test: Debian Sid 64bit
# Author: LeTic
# Licence: http://www.google.com/intl/en/adwordseditor/terms.html
# Depend:
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Adwords Editor"
PREFIX="AdwordsEditor"
URL="http://dl.google.com/adwords_editor/9.0.1/win32/en-US/adwords_editor_en-US.msi"
 
DOWNLOAD="Download in progress..."
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
 
#wget     http://www.google.com/images/logos/adwords_editor_logo.gif --output-document="$REPERTOIRE/tmp/leftnotscaled.gif"
#convert "$REPERTOIRE/tmp/leftnotscaled.gif" -resize 150x21 -gravity center -repage 150x356+0+167 -flatten -unsharp 0x1 "$REPERTOIRE/tmp/left.jpeg"
 
#wget "http://www.mozilla.org/images/projects/adwords.png" --output-document="$REPERTOIRE/tmp/topnotscaled.png"
#convert "$REPERTOIRE/tmp/topnotscaled.png" -repage 60x60+5 -flatten "$REPERTOIRE/tmp/top.jpeg"
 
POL_SetupWindow_Init #"$REPERTOIRE/tmp/top.jpeg" "$REPERTOIRE/tmp/left.jpeg"
 
POL_SetupWindow_presentation "$NAME" "Google Inc" "http://www.google.com/intl/en/adwordseditor/index.html" "LeTic" "$PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
 
POL_LoadVar_PROGRAMFILES
 
#Install vcrun2005
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_gecko
 
cd "$REPERTOIRE/tmp/"
 
POL_SetupWindow_download "$DOWNLOAD" "$NAME" "$URL"
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
msiexec /i adwords_editor_en-US.msi /q
POL_SetupWindow_detect_exit
 
rm adwords_editor_en-US.msi
 
convert ~/.local/share/icons/*__19536f6e05de1cfef02b79.png -scale 32x32\! "$REPERTOIRE/icones/32/$NAME"
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Google/Google AdWords Editor" "adwords_editor.exe" "" "$NAME"
 
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4otVsACgkQ5TH6yaoTykfu6QCeIFT9f7RFrn6zn7vZ9g9frzej
+XoAn2nHzUx1YLzm5y2A1Db1ioamLO3S
=Cp22
-----END PGP SIGNATURE-----
