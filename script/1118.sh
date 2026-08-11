#!/bin/bash

# 1 : Game to download
# 2.. : Md5sum(s) of piece(s)

if [ "$POL_SELECTED_FILE" ]; then
	POL_Debug_Message "Using selected file"
	POL_GoG_location="$POL_SELECTED_FILE"
else
	INSTALL_METHOD_BACK="$INSTALL_METHOD"
	
    BUG_4182="y"
	if [ -z "$BUG_4182" -a -n "$POL_WGET" ]; then # PlayOnLinux can understand GoG_Download
		POL_Debug_Message "PlayOnLinux can understand GoG_Download"
		POL_SetupWindow_InstallMethod LOCAL,DOWNLOAD
	else
		POL_Debug_Message "PlayOnLinux do not understand GoG_Download"
		INSTALL_METHOD="LOCAL"
		POL_SetupWindow_question "$(eval_gettext 'Do you want to download $TITLE from GOG.com?')" "$TITLE"
		[ "$APP_ANSWER" = "TRUE" ] && POL_Browser "http://www.gog.com/gamecard/$GOGID"
	fi

	POL_Debug_Message "Install method $INSTALL_METHOD"

	if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
		POL_Call POL_GoG_download "$@"
	fi

	if [ "$INSTALL_METHOD" = "LOCAL" ]; then
		cd "$HOME"
		POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
		POL_GoG_location="$APP_ANSWER"
	fi
	INSTALL_METHOD="$INSTALL_METHOD_BACK"
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwWqNoACgkQ5TH6yaoTykceigCePHFottoCDGqwJgLPV4ANEakB
8cMAn2SQcnnct9+K3QQt5vmT2ux+AHlC
=JoC1
-----END PGP SIGNATURE-----
