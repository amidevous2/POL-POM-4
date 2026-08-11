#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
######################
# created Do 4. Mär 19:07:41 CET 2021
######################
# global parameters
TITLE="TablEdit"
PREFIX="tabledit"
AUTHOR="VolkerFroehlich"
EDITOR="Matthieu Leschemelle"
EDITOR_URL="https://tabledit.com/"
MD5=""
DOWNLOAD_RGSTRED_PATH="https://tabledit.com/secured/tev301.exe"
DOWNLOAD_PREVIEW_PATH="https://tabledit.com/download/tabled32.exe"
EXECUTABLE_FILE="tableditdemo.exe"
# automation parameters
USE_AUTOMATION="0" # 1: do not ask user 
USE_REGISTERED_VERSION=0 # 1: use registered version
[ "$USE_REGISTERED_VERSION" = "1" ] && EXECUTABLE_FILE="tabledit.exe"
######################
# FUNCTIONS
# ==============================================================
getRegisteredOrPreview()
# --------------------------------------------------------------
# Ask user for TablEdit registration info. 
# We require this for access to the secured download page
# and later to add registration data to the windows registry.
# Store input to variables
#  TE_USR: username
#  TE_PWD: password
# ==============================================================
{
TE_USR="" # with USE_AUTOMATION=1 you can predefine your
TE_PWD="" # tabledit registered user/password here
[ "$USE_AUTOMATION" = "1" ] && return 0
# -------------------
# ask user if registered
MSG="If you do have a user name and password we install the full version, else the preview demo.\n\nAre you a registered user?"
POL_SetupWindow_question "$(eval_gettext '$MSG')" "$TITLE"
POL_Debug_Message "# APP_ANSWER=$APP_ANSWER"
[ "$APP_ANSWER" = "TRUE" ] && USE_REGISTERED_VERSION=1 || USE_REGISTERED_VERSION=0
[ ! "$USE_REGISTERED_VERSION" = "1" ] && return 0 # install preview demo version
# -------------------
# use registered version
EXECUTABLE_FILE="tabledit.exe"
MSG="Username"
POL_SetupWindow_textbox "$(eval_gettext '$MSG')" "$TITLE" "$TE_USR"
[ -z "$APP_ANSWER" ] && return 0
TE_USR="$APP_ANSWER"
MSG="Password"
POL_SetupWindow_textbox "$(eval_gettext '$MSG')" "$TITLE" "$TE_PWD"
[ -z "$APP_ANSWER" ] && TE_USR="" && return 0
TE_PWD="$APP_ANSWER"
[ -z "$TE_USR" ] && POL_Debug_Fatal "# ERROR: User not defined"
[ -z "$TE_PWD" ] && POL_Debug_Fatal "# ERROR: Password not defined"
return 0 # use registered version
}
# ==============================================================
getVersionRemote()
# --------------------------------------------------------------
# check demo download page for latest version info
# and store this in variable
#    VERSION_REMOTE
# ==============================================================
{
POL_Debug_Message "# getVersionRemote"
VERSION_REMOTE=""
# - - - - - - - - - - - - - - - - - - - - -
# download html page for demo version
DOWNLOAD_PATH=$DOWNLOAD_PREVIEW_PATH
DOWNLOAD_DIR=$(dirname "$DOWNLOAD_PATH")
DOWNLOAD_FILE=$(basename "$DOWNLOAD_PATH")
DOWNLOAD_TMP=$POL_System_TmpDir
POL_Debug_Message "# download secured html page ($DOWNLOAD_DIR/$DOWNLOAD_FILE)"
wget -O $DOWNLOAD_TMP/TE_DWLD $DOWNLOAD_DIR/ 2>/dev/null;
RET_VAL="$?"
[ "$RET_VAL" -ne "0" ] && echo POL_Debug_Warning \"# download returns non zero value=$RET_VAL\"
[ ! -f "$DOWNLOAD_TMP/TE_DWLD" ] && POL_Debug_Fatal "# ERROR: download demo html page failed"
# - - - - - - - - - - - - - - - - - - - - -
POL_Debug_Message "# analyze HTML page"
VERSION_REMOTE=`fgrep "from Windows" $DOWNLOAD_TMP/TE_DWLD | cut -d "-" -f 2 | cut -d " " -f 2 | cut -d "v" -f 2`
POL_Debug_Message "# VERSION_REMOTE=$VERSION_REMOTE"
}
# ==============================================================
getInstallerLocalDownload()
# --------------------------------------------------------------
# 1. decide if local or download
# 1.1 browse for local installer
# 1.2 download
# 1.2.a registered version
#       .store secured download page locally
#       .analyze page for latest installer
#        This may no longer work if download page logic changes
# 1.2.b demo version
# 2. check installer size is not too small
# ==============================================================
{
POL_Debug_Message "# USER CHOICE: select local or download"
[ "$USE_AUTOMATION" = "1" ] && \
	INSTALL_METHOD="DOWNLOAD" || \
	POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
	MSG="Please select the setup file to run."
	POL_SetupWindow_browse "$(eval_gettext '$MSG')" ""
	INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
	POL_Debug_Message "# download installer"
	if [ "$USE_REGISTERED_VERSION" = "1" ]; then 
		# - - - - - - - - - - - - - - - - - - - - -
		# TablEdit registered user - user/password
		[ -z "$TE_USR" ] && POL_Debug_Fatal "# ERROR: user name not set"
		[ -z "$TE_PWD" ] && POL_Debug_Fatal "# ERROR: password not set"
		# - - - - - - - - - - - - - - - - - - - - -
		# download html page for registered version
		DOWNLOAD_PATH=$DOWNLOAD_RGSTRED_PATH
		DOWNLOAD_DIR=$(dirname "$DOWNLOAD_PATH")
		DOWNLOAD_FILE="windows_e.shtml"
		DOWNLOAD_TMP=$POL_System_TmpDir
		POL_Debug_Message "# download secured html page ($DOWNLOAD_DIR/$DOWNLOAD_FILE)"
		wget --user "$TE_USR" --password "$TE_PWD" -O $DOWNLOAD_TMP/TE_DWLD $DOWNLOAD_DIR/$DOWNLOAD_FILE 2>/dev/null;
		RET_VAL="$?"
		[ "$RET_VAL" -ne "0" ] && echo POL_Debug_Warning \"# download returns non zero value=$RET_VAL\"
		[ ! -f "$DOWNLOAD_TMP/TE_DWLD" ] && POL_Debug_Fatal "# ERROR: download secured html page failed"
		# - - - - - - - - - - - - - - - - - - - - -
		POL_Debug_Message "# analyze HTML page"
		VERSION_REMOTE=`fgrep "B>TablEdit v" $DOWNLOAD_TMP/TE_DWLD | cut -d " " -f 2 | cut -d "v" -f 2`
		POL_Debug_Message "# installer version=$VERSION_REMOTE"
		DOWNLOAD_FILE=`fgrep "B>TablEdit v" $DOWNLOAD_TMP/TE_DWLD | cut -d '"' -f 2`
		DOWNLOAD_PATH=$DOWNLOAD_DIR/$DOWNLOAD_FILE
		# - - - - - - - - - - - - - - - - - - - - -
		# download secured installer
		POL_Debug_Message "# download the secured installer ($DOWNLOAD_PATH)"
		POL_Debug_Message "# wget -O "$DOWNLOAD_TMP/$DOWNLOAD_FILE" --user=$TE_USR --password=$TE_PWD $DOWNLOAD_PATH"
		wget -O "$DOWNLOAD_TMP/$DOWNLOAD_FILE" --user=$TE_USR --password=$TE_PWD $DOWNLOAD_PATH
		RET_VAL="$?"
		[ "$RET_VAL" -ne "0" ] && echo POL_Debug_Warning "# download returns non zero value=$RET_VAL"
		[ ! -f "$DOWNLOAD_TMP/$DOWNLOAD_FILE" ] && POL_Debug_Fatal "# ERROR: download secured installer failed"
		INSTALLER="$DOWNLOAD_TMP/$DOWNLOAD_FILE"
		POL_Debug_Message "# INFO: registered program downloaded to $INSTALLER"
	else
		# - - - - - - - - - - - - - - - - - - - - -
		# download demo installer
		DOWNLOAD_LINK=$DOWNLOAD_PREVIEW_PATH
		DOWNLOAD_FILE=$(basename "$DOWNLOAD_LINK")
		POL_Debug_Message "# download the demo installer ($DOWNLOAD_LINK)"
		POL_Download "$DOWNLOAD_LINK"
		INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
		POL_Debug_Message "# INFO: demo program downloaded to $INSTALLER"
	fi
fi
if [[ -z "$INSTALLER" || ! -f "$INSTALLER" ]];then 
	MSG="ERROR: cannot locate installer >$INSTALLER< for $TITLE."
	POL_Debug_Message "# $MSG"
	POL_SetupWindow_message "$(eval_gettext '$MSG')" "$TITLE"
fi
# ---------------------
# check installer size
file_size_kb=`du -k "$INSTALLER" | cut -f1`
if [ "$file_size_kb" -lt 1000 ]; then
	POL_Debug_Fatal "# ERROR: Installer \(${INSTALLER}\) size \(${file_size_kb kb}\) is too small for a set-up file."
fi
return 0
}
# ==============================================================
registryLanguage()
# --------------------------------------------------------------
# set TablEdit language according to locale
# ==============================================================
{
LANG_VAL=0 # 0 - English (default)
LANG_CUR=`echo $LANG | cut -c 1-2`
[ \"$LANG_CUR\" = \"de\" ] && LANG_VAL=512  # 512 - German
[ \"$LANG_CUR\" = \"fr\" ] && LANG_VAL=256  # 256 - French
[ \"$LANG_CUR\" = \"es\" ] && LANG_VAL=768  # 768 - Spanish
[ \"$LANG_CUR\" = \"jp\" ] && LANG_VAL=1024 # 1024- Janpanese
echo "\"Language\"=\"$LANG_VAL\"" >> $FILE_USRREG
}
# ==============================================================
registryProgram()
# --------------------------------------------------------------
# update registry with user registeration info
# ==============================================================
{
if [ "$USE_REGISTERED_VERSION" = "1" ]; then
	POL_Debug_Message "# INFO: register Password, UserName"
	echo -e "\"UserName\"=\""$TE_USR"\"\n\"Password\"=\""$TE_PWD"\"" >> $FILE_USRREG
	FOUND=`fgrep '\"Password\"' $FILE_USRREG`
	[ ! -z "$FOUND" ] && POL_Debug_Message "# INFO: registered"
fi
}
# ==============================================================
registryWindows()
# --------------------------------------------------------------
# We clean up scattered windows of regular install and
# update registry with user preferences (colors, windows)
# ==============================================================
{
POL_Debug_Message "# INFO: register windows"
echo "\"Colorsv3\"=\"0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x80,0xff,0xdbecec,0xdff0f5,0x0,\"" >> $FILE_USRREG
echo "\"Palette1\"=\"326,76,104,118,0,27,465,28,53,233,20,1,132,0\"" >> $FILE_USRREG
echo "\"Palette2\"=\"597,76,104,118,511,27,465,28,53,233,20,1,132,0\"" >> $FILE_USRREG
echo "\"Palette3\"=\"432,76,104,49,984,27,189,28,53,95,8,1,132,0\"" >> $FILE_USRREG
echo "\"Palette4\"=\"491,76,104,72,0,219,281,28,53,141,12,1,148,0\"" >> $FILE_USRREG
echo "\"Palette5\"=\"492,173,104,95,885,102,373,28,53,187,16,1,148,0\"" >> $FILE_USRREG
echo "\"Palette6\"=\"706,76,104,141,0,27,101,141,101,141,1,1,148,0\"" >> $FILE_USRREG
echo "\"Palette7\"=\"162,383,551,58,0,637,551,60,553,58,1,1,24,0\"" >> $FILE_USRREG
echo -e "\"ScrOutput\"=\"001001110000=1W1:>899<>7F001P040S@//210000000000\"" >> $FILE_USRREG
}
# ==============================================================
getRegistryExists()
# --------------------------------------------------------------
# check if registry is valid for the installed program
# 0: not existing
# 1: existing
# ==============================================================
{
REGISTRY_EXISTS=0
# ---------------------
# check user.reg exists
FILE_USRREG="$WINEPREFIX/user.reg"
[ ! -f "$FILE_USRREG" ] && POL_Debug_Fatal "# ERROR: file not found $FILE_USRREG"
# ---------------------
# check system.reg exists
FILE_SYSREG="$WINEPREFIX/system.reg"
[ ! -f "$FILE_SYSREG" ] && POL_Debug_Fatal "# ERROR: file not found $FILE_SYSREG"
# ---------------------
# check user.reg key exists
FOUND="`fgrep '\\TablEdit' $FILE_USRREG`" 
[ -z "$FOUND" ] && POL_Debug_Message "# WARNING: key \\TablEdit does not yet exist\n(Wine may still need time to flush the file)\n$FILE_USRREG." && return 0
# ---------------------
# return success
REGISTRY_EXISTS=1
return "$REGISTRY_EXISTS"
}
# ==============================================================
waitsec()
# --------------------------------------------------------------
# sleep function with some debug message
# ==============================================================
{
P1="$1"
[[ -z "$P1" || "$P1" = 0 ]] && return 0
POL_Debug_Message "# let's wait $P1 seconds"
sleep "$P1"
}
# ==============================================================
updateRegistry()
# --------------------------------------------------------------
# update registry with some program settings
# color, windows position, user registration info, language
# The installers registry values do need time to show. 
# So, if we do not find them, let's wait a while.
# ==============================================================
{
# - - - - - - - - - - - - - -
# validate registry exists
REGISTRY_EXISTS=0
getRegistryExists
typeset -i iCount=0 iMax=4
while [[ "$REGISTRY_EXISTS" = 0 && $iCount -lt $iMax ]]; do
	iCount=iCount+1
	POL_Debug_Message "# WARNING: waiting for registry $iCount"
	waitsec 4
	getRegistryExists
done
[ "$REGISTRY_EXISTS" = 0 ] && POL_Debug_Message "# WARNING: getRegistryExists - returned 0"
FILE_USRREG="$WINEPREFIX/user.reg"
# - - - - - - - - - - - - - -
# add to registry: Password, UserName, Windows, Language
POL_Debug_Message "# INFO: add registy keys Software\\\\\\\\TablEdit"
echo "[Software\\\\\\\\TablEdit\\\\\\\\TablEdit]" >> $FILE_USRREG
registryProgram
registryWindows
registryLanguage
echo -e "\n" >> $FILE_USRREG
}
# ==============================================================
getVersion()
# --------------------------------------------------------------
# read installed version from system.reg
# if not found, retry some times, then get remote version
# ==============================================================
{
REGISTRY_EXISTS=0
# ----------------------------------
# validate registry
getRegistryExists
typeset -i iCount=0 iMax=4
while [[ "$REGISTRY_EXISTS" = 0 && $iCount -lt $iMax ]]; do
	iCount=iCount+1
	POL_Debug_Message "# WARNING: waiting for registry $iCount"
	waitsec 4
	getRegistryExists 
done
[ "$REGISTRY_EXISTS" = 0 ] && POL_Debug_Message "# WARNING: getRegistryExists returned 0"
# ----------------------------------
# get Version Info from system.reg
cd "$WINEPREFIX" || POL_Debug_Fatal "# ERROR: Unable to change directory"
RESULT1=`fgrep -A 1 '"DisplayName"="TablEdit' system.reg  | grep -A 0 '"DisplayVersion"' `
[ ! -z "$RESULT1" ] && VERSION_INSTALLED=`echo $RESULT1 | cut -d '"' -f 4 `
if [ -z "$VERSION_INSTALLED" ]; then
# ----------------------------------
# get remote Version
	POL_Debug_Warning "# WARNING: 'DisplayVersion TablEdit' not found in system.reg"
	getVersionRemote
	POL_Debug_Warning "# WARNING: using remote demo version ($VERSION_REMOTE) as a fallback"
	VERSION_INSTALLED="$VERSION_REMOTE" 
fi
# POL_Debug_Message "# VERSION_INSTALLED=$VERSION_INSTALLED"
# VER_LEN="${#VERSION_INSTALLED}"
# POL_Debug_Message "# LEN=$VER_LEN"
}
# ==============================================================
createShortcut()
# --------------------------------------------------------------
# 1. get installed version
# 2. remove previous desktop starter
# 3. remove previous POL shortcut
# 4. add POL shortcut with version info
# 5. add timidity to POL shortcut
# ==============================================================
{
# -------------------
POL_Debug_Message "# get program version"
getVersion
POL_Debug_Message "# VERSION_INSTALLED: $VERSION_INSTALLED"
LAUNCHER="$TITLE"
[ ! -z "$VERSION_INSTALLED" ] && LAUNCHER="$LAUNCHER-v$VERSION_INSTALLED"
POL_Debug_Message "# LAUNCHER: $LAUNCHER"
# -------------------
PATH_SHORTCUT="$POL_USER_ROOT/shortcuts/$LAUNCHER"
if [ ! -f "$PATH_SHORTCUT" ];then
	# -------------------
	POL_Debug_Message "# remove any previous desktop starter"
	LINUX_DESKTOP=`xdg-user-dir DESKTOP`
	PATH_SHORTCUT="$LINUX_DESKTOP/$TITLE"
	rm -r "$PATH_SHORTCUT"* 2>/dev/null;
	rm -r $HOME/.local/share/applications/*$TITLE* 2>/dev/null;
	# -------------------
	POL_Debug_Message "# remove previous POL shortcut"
	PATH_SHORTCUT="$POL_USER_ROOT/shortcuts/$TITLE"
	rm -r "$PATH_SHORTCUT"* 2>/dev/null;
	# -------------------
	POL_Debug_Message "# create POL shortcut"
	POL_Shortcut "$EXECUTABLE_FILE" "$LAUNCHER" "" "" "AudioVideo;Audio;AudioVideoEditing;Music;"
	# -------------------
	PATH_SHORTCUT="$POL_USER_ROOT/shortcuts/$LAUNCHER"
fi
[ -f "$PATH_SHORTCUT" ] && MSG="$LAUNCHER installation ok" && POL_Debug_Message "# $MSG"
# ===================
# Add timidity to POL shortcut
POL_Debug_Message "# Adding TiMidity to POL shortcut $PATH_SHORTCUT"
TIMIDITY_APP=`which timidity`
[ -z "$TIMIDITY_APP" ] && POL_Debug_Warning "# no timidity found" && return -1
if [ -z "`fgrep timidity $PATH_SHORTCUT`" ];then
        STARTTIMIDITY="[ -z \"\`pstree | grep timidity\`\" ] \&\& timidity -iA -B2,8 -Os1l -s 44100 \&"
        echo "s+POL_Wine*+$STARTTIMIDITY\nPOL_Wine+g" > $POL_System_TmpDir/SED_CMD
        sed -i -f $POL_System_TmpDir/SED_CMD $PATH_SHORTCUT
fi
return 0
}
######################
# MAIN
IMAGE_TOP="https://tabledit.com/css/img/header1.jpg"
IMAGE_LEFT="https://tabledit.com/ios/TEFpad.ios.logo.175x175-75.jpg"
POL_GetSetupImages --force  "$IMAGE_TOP" "$IMAGE_LEFT" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_Debug_Message "# show POL Window"
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
Set_OS "win7"
# ---------------------
POL_Debug_Message "# create PREFIX environment"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate
Set_OS "win7"
POL_System_TmpCreate "$PREFIX"
PWD_OLD=`pwd`
cd "$POL_System_TmpDir" || POL_Debug_Fatal "# ERROR: Unable to change directory"
POL_Debug_Message "# WINEPREFIX: $WINEPREFIX"
POL_Debug_Message "# PREFIX: $PREFIX"
POL_Debug_Message "# POL_System_TmpDir: $POL_System_TmpDir"
# ===================
POL_Debug_Message "# USER CHOICE: registered or preview"
getRegisteredOrPreview
# ---------------------
POL_Debug_Message "# get Installer local or download"
getInstallerLocalDownload
# ===================
POL_Debug_Message "# check TiMidity is available"
TIMIDITY_APP=`which timidity`
if [ -z "$TIMIDITY_APP" ];then
        MSG="For $TITLE to run, we recommend you install TiMidity on your system first.\nPlease open a terminal and execute this command line:\n
        sudo apt-get -y install timidity\n\nThen continue or restart this POL installation.\n"
        POL_SetupWindow_message "$(eval_gettext '$MSG')"
fi
# ===================
POL_Debug_Message "# start wine installation ("$INSTALLER")"
MSG="Installation in progress."
POL_SetupWindow_wait "$(eval_gettext '$MSG')" ""
POL_Wine "$INSTALLER"
POL_Debug_Message "# confirm the executable - tabledit.exe or tableditdemo.exe exists"
FOUND=`find $WINEPREFIX -name "$EXECUTABLE_FILE" -print`
[ -z "$FOUND" ] && POL_Debug_Fatal "# ERROR: $EXECUTABLE_FILE not found in $WINEPREFIX"
# ===================
POL_Debug_Message "# finalize installation"
updateRegistry
createShortcut
POL_System_TmpDelete
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYI15WwAKCRDlMfrJqhPK
RwB3AJ9AJmzwpfzhqcFbN6WeiORaeGHv7QCfUqsPgcRWmPOE0zrXYsvcmrMF8Ls=
=smYU
-----END PGP SIGNATURE-----
