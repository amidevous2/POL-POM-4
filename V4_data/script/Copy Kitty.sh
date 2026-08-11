#!/bin/bash
# Date : (2018-07-18 12-06)
# Last revision : (2018-07-18 12-06)
# Wine version used : 3.0.2
# Distribution used to test : Xubuntu 16.04
# Author : ntfwc

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Copy Kitty"
PREFIX="copy_kitty"
AUTHOR="ntfwc"
GAME_CREATOR="Nuclear Strawberry"
GAME_SITE="http://entanma.com/copykitty/"

EXECUTABLE="kitty.exe"
PREFIX_INSTALL_PATH="drive_c/Program Files"
WINE_VERSION="3.0.3"

TOP_IMAGE_URL=http://0.0.0.0/top.png
LEFT_IMAGE_URL=http://0.0.0.0/left.jpg
 
POL_GetSetupImages "$TOP_IMAGE_URL" "$LEFT_IMAGE_URL" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

main()
{
	# Require that unzip is available
	if ! which unzip > /dev/null
	then
		POL_Debug_Error "$(eval_gettext 'Missing required program: ')unzip"
		return 1
	fi

	POL_SetupWindow_presentation "$TITLE" "$GAME_CREATOR" "$GAME_SITE" "$AUTHOR" "$PREFIX"

	[ "$(POL_Wine_PrefixExists ""$PREFIX"")" == True ]
	PREFIX_ALREADY_EXISTS=$?

	if [ "$PREFIX_ALREADY_EXISTS" -eq 0 ]
	then
		POL_SetupWindow_question "$(eval_gettext 'The install prefix already exists, continue with installation?')" "$TITLE"
		if [ "$APP_ANSWER" == "FALSE" ]
		then
			return 1
		fi
	fi

	POL_SetupWindow_browse "$(eval_gettext 'Select game zip file')" "$TITLE" "" "*.zip"
	ZIP_FILE=$APP_ANSWER
	if [ ! -r "$ZIP_FILE" ]
	then
		POL_Debug_Error "$(eval_gettext 'Cannot read given zip file: ')$ZIP_FILE"
		return 1
	fi
	# Make sure the zip file actually contains the expected executable
	if ! unzip -l "$ZIP_FILE" "*$EXECUTABLE" > /dev/null
	then
		POL_Debug_Error "$(eval_gettext 'The given zip file does not contain the expected executable: ')$EXECUTABLE"
		return 1
	fi

	POL_Wine_SelectPrefix "$PREFIX"
	if [ "$PREFIX_ALREADY_EXISTS" -ne 0 ]
	then
		# Setup the virtual drive
		POL_Wine_PrefixCreate "$WINE_VERSION"
		POL_Call POL_Install_dotnet40
		POL_Call POL_Install_xna40
	fi

	# Extract the game in the prefix
	INSTALL_PATH="$WINEPREFIX/$PREFIX_INSTALL_PATH"
	if ! cd "$INSTALL_PATH"
	then
		POL_Debug_Error "$(eval_gettext 'Failed to cd to the expected install path: ')$INSTALL_PATH"
		return 1
	fi
	POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
	POL_Debug_Message "Extracting zip file '$ZIP_FILE' to $PWD"
	if ! unzip "$ZIP_FILE"
	then
		POL_Debug_Error "$(eval_gettext 'Failed to unzip the file: ')$ZIP_FILE"
		return 1
	fi

	POL_Shortcut $EXECUTABLE "$TITLE"
}

main
 
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYBXJDgAKCRDlMfrJqhPK
Ryk1AJ4qi+iHQbJpk66prXNGnjCeEjkwmwCfZva8zHBgrT1ZmCqByWaCvdEAQsM=
=H0L1
-----END PGP SIGNATURE-----
