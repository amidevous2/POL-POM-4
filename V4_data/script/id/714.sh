#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#   Volker Froehlich (check download page for latest version).
######################
# set global parameters
TITLE="Mp3tag"
PREFIX="mp3tag"
AUTHOR="VolkerFroehlich"
EDITOR="Florian Heidenreich"
EDITOR_URL="http://www.mp3tag.de/"
### FILE="ThisFilenameIsWrong" <== you can use an invalid file name
### and this script will still download the current install version!!!
### For script efficiency we still provide the currently available file name
FILE="mp3tagv308setup.exe"
### MD5 no longer supported by the Editor, we still keep the parameter
### for future changes
MD5=""
DOWNLOAD_PATH=http://download.mp3tag.de/
######################
# show POL Window
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
######################
# create PREFIX environment
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win7"
POL_System_TmpCreate "$PREFIX"
PWD_OLD=`pwd`
cd "$POL_System_TmpDir" || POL_Debug_Fatal "Unable to change directory"
######################
# let user choose
# a) local installer vs. 
# b) download from $DOWNLOAD_PATH
INSTALLER=""
DOWNLOAD_FULLPATH=$DOWNLOAD_PATH$FILE
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
######################
# user selects installer
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
######################
# download installer
	DOWNLOAD_LINK=$DOWNLOAD_FULLPATH
	DOWNLOAD_FILE=$(basename "$DOWNLOAD_FULLPATH")
	POL_Download "$DOWNLOAD_LINK" "$MD5"
	INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi
######################
# if no downloaded file exists, we ask user
# to manually enter the download URL 
if [[ -z "$INSTALLER" || ! -f "$INSTALLER" ]]; then
	MSG="Installation file not found ($INSTALLER)"
	POL_SetupWindow_message "$(eval_gettext '$MSG')" "$TITLE"
	DOWNLOAD_LINK="$DOWNLOAD_FULLPATH"
	DOWNLOAD_FILE=$(basename "$DOWNLOAD_LINK")
	POL_SetupWindow_textbox "Enter/correct download URL:" "$TITLE" "$DOWNLOAD_LINK"
	DOWNLOAD_LINK="$APP_ANSWER"
	DOWNLOAD_FILE=$(basename "$DOWNLOAD_LINK")
	POL_Download "$DOWNLOAD_LINK" "$MD5"
	INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi
###########################
# We check if the downloaded file is too small for an executable
# In case we tried to download an incorrect file
# the HTML page was downloaded instead
# (That behaviour of the Editors website might change in future)
if [ -f "$INSTALLER" ]; then
	file_size_kb=`du -k "$INSTALLER" | cut -f1`
	if [ "$file_size_kb" -lt 1000 ]; then
###########################
# We locate the current installation file name 
# on the HTML page and download it
# We assume the file name is "mp3t"<SomeVersionRelatedTextHere>tup.exe"
# (That file name structure might change in future)
		FILE=`cat $INSTALLER | grep ".exe" | grep -v "Download" | head -1 | cut -d "t" -f 2`
		rm $INSTALLER 2>/dev/null
		FILE="mp3t${FILE}tup.exe"
		DOWNLOAD_LINK=$DOWNLOAD_PATH$FILE
		POL_Download "$DOWNLOAD_LINK" "$MD5"
		INSTALLER="$POL_System_TmpDir/$FILE"
	fi
fi
###########################
# Run Wine installation
if [ -f "$INSTALLER" ]; then
	MSG="Installation in progress."
	POL_SetupWindow_wait "$(eval_gettext '$MSG')" "$TITLE"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$INSTALLER"
###########################
# Get Installed Version
	VERSION_INSTALLED=""
	POL_Debug_Message "# WINEPREFIX: $WINEPREFIX"
	VERSION_FILE="$WINEPREFIX/drive_c/Program Files/Mp3tag/Mp3tagVersion.txt"
	POL_Debug_Message "# VERSION_FILE: $VERSION_FILE"
	[ -f "$VERSION_FILE" ] && VERSION_INSTALLED=`head -2 "$VERSION_FILE" | grep VERSION | cut -d " " -f 5`
POL_Debug_Message "# VERSION_INSTALLED: $VERSION_INSTALLED"
	LAUNCHER="$TITLE"
	[ ! -z "$VERSION_INSTALLED" ] && LAUNCHER="$TITLE-v$VERSION_INSTALLED"
POL_Debug_Message "# LAUNCHER: $LAUNCHER"
	POL_Shortcut "mp3tag.exe" "$LAUNCHER" "" "" "AudioVideo;Audio;AudioVideoEditing;Music;"
fi 
cd $PWD_OLD
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCY0MwFwAKCRDlMfrJqhPK
R7voAJoCaa0Gv/15It6V1sem0KUDRp98FACgkMCxkyzK+1FVjdtE8pUF3boQ3iE=
=UYP2
-----END PGP SIGNATURE-----
