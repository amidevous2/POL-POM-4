#!/bin/bash
# Date: (2010-09-15  12-39)
# Last revision: (2010-09-15  15-57)
# Wine version used: 1.2
# Distribution used to test: Debian Sid 64bit
# Author: LeTic
# Licence: http://www.google.com/intl/en/adwordseditor/terms.html
# Depend:
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Adwords Editor"
PREFIX="AdwordsEditor"
URL="http://dl.google.com/adwords_editor/8.0.1/win32/en-US/adwords_editor_en-US.msi"
 
DOWNLOAD="Download in progress..."
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
 
#wget	 http://www.google.com/images/logos/adwords_editor_logo.gif --output-document="$REPERTOIRE/tmp/leftnotscaled.gif"
#convert "$REPERTOIRE/tmp/leftnotscaled.gif" -rotate 270 -scale 52x356\! "$REPERTOIRE/tmp/left.jpeg"
 
#wget "http://4.bp.blogspot.com/_q0bscNXWyfo/TJCIb0Hi34I/AAAAAAAABGw/fp5DypIjaYI/s1600/logo+blog.JPG" --output-document="$REPERTOIRE/tmp/topnotscaled.jpeg"
#convert "$REPERTOIRE/tmp/topnotscaled.jpeg" -scale 60x60\! "$REPERTOIRE/tmp/top.jpeg"
 
POL_SetupWindow_Init #"$REPERTOIRE/tmp/top.jpeg" "$REPERTOIRE/tmp/left.jpeg"
 
POL_SetupWindow_presentation "$NAME" "Google Inc" "http://www.google.com/intl/en/adwordseditor/index.html" "LeTic" "$PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
 
#POL_SetupWindow_install_wine "1.2"
 
#Set_WineVersion_Assign "1.2" "$NAME"
 
#PROGRAMFILES="Program Files"
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
 
#convert "$REPERTOIRE/tmp/top.jpeg" -scale 32x32\! "$REPERTOIRE/icones/32/$NAME"
convert ~/.local/share/icons/*__19536f6e05de1cfef02b79.png -scale 32x32\! "$REPERTOIRE/icones/32/$NAME"
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Google/Google AdWords Editor" "adwords_editor.exe" "" "$NAME"
 
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFYACgkQ5TH6yaoTykdVAQCdHiaxsURA8gF6R40HmDkYSH/c
A9oAn3bIaHVvTl4Xs2QEvaqgmRUnNE2B
=Nm7x
-----END PGP SIGNATURE-----
