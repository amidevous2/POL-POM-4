#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2013-06-23 21-12)
# Wine version used : 1.1.10
# Distribution used to test : N/A
# Author : Konstantin 'CHAIN' Vasilchenko, updated by SuperPlumus & Tutul

# CHANGELOG
# [SuperPlumus] (2013-06-23 21-12)
#   Update POLv3 -> POLv4
#   Remove download method due to lack of URL (http://www.cuneiform.ru/downloads/cuneiform.zip)

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="OCR CuneiForm"
PREFIX="Cuneiform"
WORKING_WINE_VERSION="1.1.10"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cognitive Technologies" "http://www.cuneiform.ru" "Konstantin 'CHAIN' Vasilchenko" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_vcrun6

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"


POL_Shortcut "sface.exe" "$TITLE"

POL_SetupWindow_message "1. Please don't use the wizard,\ntry to work with documents step by step from the menu.\n\n2. There is a data error when working with scanners\nHP, Epson, BENQ, Canon, Xerox, Mustek etc.\nRemedy: You have to edit the file 'face.ini', which is located in the directory windows.\nThen find TWAIN_TransferMode key in the file and make it equal to 'memory-native'.\nIt's have to be 'TWAIN_TransferMode = memory-native'.\n\nAnswers to other questions on CuneiForm program can be found at the forum\nwww.cuneiform.ru/forum/." "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHHT7wACgkQ5TH6yaoTykdiOQCeKhFFGQhiYUt8BGE0beYbVE5x
U3EAn2PNYz6zm3QKFoC1KnB/RS23A/Vr
=ubAO
-----END PGP SIGNATURE-----
