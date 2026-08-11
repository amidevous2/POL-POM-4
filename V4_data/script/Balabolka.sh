#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
######################
# created So 14. Feb 16:14:27 CET 2021
######################
# global parameters
TITLE="Balabolka"
PREFIX="balabolka"
AUTHOR="Volker Fröhlich"
EDITOR="Ilya Morozov"
EDITOR_URL="http://balabolka.site/balabolka.htm"
FILE="balabolka.zip"
MD5=""
DOWNLOAD_PATH="http://www.cross-plus-a.com"
######################
# FUNCTIONS
# ==============================================================
get_unpack_install()
# --------------------------------------------------------------
# select/download <installer file>
# if file extension is .zip unpack and use installer "setup.exe"
# run <installer>
# --------------------------------------------------------------
# input parameters
# 1: EXEC_SCRIPT - "OK" execute script, else return 
# 2: PATH_DOWNLD - installer download path (.zip, .exe or .msi)
# 3: PRG_DISPLAY - display name for user interaction
# 4: PATH_VERIFY - path to a component confirming installation success if found
# 5: INST_METHOD - LOCAL, DOWNLOAD
# ==============================================================
{
# -------------------------------
# validate input parameters
POL_Debug_Message "# WINEPREFIX: $WINEPREFIX"
POL_Debug_Message "# PREFIX: $PREFIX"
POL_Debug_Message "# POL_System_TmpDir: $POL_System_TmpDir"
cd "$POL_System_TmpDir" || POL_Debug_Fatal "Unable to change directory"
EXEC_SCRIPT="$1"
PATH_DOWNLD="$2"
PRG_DISPLAY="$3"
PATH_VERIFY="$4"
INST_METHOD="$5"
POL_Debug_Message "# EXEC_SCRIPT=$EXEC_SCRIPT"
POL_Debug_Message "# PATH_DOWNLD=$PATH_DOWNLD"
POL_Debug_Message "# PRG_DISPLAY=$PRG_DISPLAY"
POL_Debug_Message "# PATH_VERIFY=$PATH_VERIFY"
POL_Debug_Message "# INST_METHOD=$INST_METHOD"
[[ -z "$EXEC_SCRIPT" || ! "$EXEC_SCRIPT" = "OK" ]] && POL_Debug_Message "# skipping install ($PRG_DISPLAY)!" && return 0
[ -z "$PATH_DOWNLD" ] && POL_Debug_Fatal "# ERROR: get_unpack_install() PATH_DOWNLD empty" && return -1
[ -z "$PRG_DISPLAY" ] && POL_Debug_Fatal "# ERROR: get_unpack_install() PRG_DISPLAY empty" && return -1
[ -z "$PATH_VERIFY" ] && POL_Debug_Fatal "# ERROR: get_unpack_install() PATH_VERIFY empty" && return -1
[ -z "$INST_METHOD" ] && POL_Debug_Fatal "# ERROR: get_unpack_install() INST_METHOD empty" && return -1
# -------------------------------
# if already installed ask user 
[ -f "$PATH_VERIFY" ] && ALREADY_INSTALLED=1 || ALREADY_INSTALLED=0
LOCAL_TITLE="$TITLE ($PRG_DISPLAY)"
if [ "$ALREADY_INSTALLED" = 1 ];then
	POL_Debug_Message "# already installed: >$PATH_VERIFY<"
	MSG="This component is already installed - overwrite?"
	POL_SetupWindow_question "$(eval_gettext '$MSG')" "$LOCAL_TITLE"
	[ ! "$APP_ANSWER" = "TRUE" ] && return 0
fi
# -------------------------------
# select/download <installer>
DOWNLOAD_FULLPATH="$PATH_DOWNLD"
if [ "$INST_METHOD" = "LOCAL" ]; then
	#---------------------
	# user selects installer
	POL_SetupWindow_browse \
		"$(eval_gettext 'Please select the setup file for $LOCAL_TITLE.')" \
		"$TITLE"
	INSTALLER="$APP_ANSWER"
elif [ "$INST_METHOD" = "DOWNLOAD" ]; then
	#---------------------
	# download installer
	INSTALLER=""
	DOWNLOAD_FULLPATH="$PATH_DOWNLD"
	POL_Debug_Message "# download installer"
	DOWNLOAD_LINK=$DOWNLOAD_FULLPATH
	DOWNLOAD_FILE=$(basename "$DOWNLOAD_FULLPATH")
	POL_Debug_Message "# DOWNLOAD_LINK=$DOWNLOAD_LINK"
	POL_Debug_Message "# MD5=$MD5"
	POL_Download "$DOWNLOAD_LINK" "$MD5"
	INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi
if [[ -z "$INSTALLER" || ! -f "$INSTALLER" ]];then 
	MSG="ERROR: cannot locate installer >$INSTALLER< for $LOCAL_TITLE."
	POL_Debug_Message "# $MSG"
	POL_SetupWindow_message "$(eval_gettext '$MSG')" "$TITLE"
fi
# -------------------------------
# unpack <installer>.zip
FIL_NAM=$(basename "$INSTALLER")
FIL_EXT="${FIL_NAM##*.}"
if [ "$FIL_EXT" = "zip" ];then
	INSTALLER_ZIP="$INSTALLER"
	POL_Debug_Message "# Extracting the archive... >$INSTALLER_ZIP<"
	MSG="Extracting the archive..."
	POL_SetupWindow_wait_next_signal "$(eval_gettext '$MSG')" "$TITLE"
	POL_System_unzip "$INSTALLER_ZIP" -d "$POL_System_TmpDir"
	INSTALLER="$POL_System_TmpDir/setup.exe"
	if [ ! -f "$INSTALLER" ];then 
		MSG="ERROR: cannot locate unzipped installer >$INSTALLER<"
		POL_Debug_Message "# $MSG"
		POL_SetupWindow_message "$(eval_gettext '$MSG')" "$TITLE"
	fi
fi
if [ ! -f "$INSTALLER" ];then 
	MSG="ERROR: cannot locate selected/downloaded installer >$INSTALLER<"
	POL_Debug_Message "# $MSG"
	POL_SetupWindow_message "$(eval_gettext '$MSG')" "$LOCAL_TITLE"
	POL_Debug_Fatal "# $MSG"
	return -1
fi
# -------------------
# Run Wine installation
FIL_NAM=$(basename "$INSTALLER")
FIL_EXT="${FIL_NAM##*.}"
if [ -f "$INSTALLER" ]; then
	MSG="Installation in progress ($FIL_NAM)."
	POL_SetupWindow_wait "$(eval_gettext '$MSG')" "$TITLE"
	POL_Wine_WaitBefore "$LOCAL_TITLE"
	if [ "$FIL_EXT" = "msi" ];then 
		POL_Wine msiexec /i "$INSTALLER"
	else
		POL_Wine "$INSTALLER"
	fi
	POL_Wine_WaitExit "$LOCAL_TITLE"
fi
# ---------------------
# confirm installation exists
[ -f "$PATH_VERIFY" ] && ALREADY_INSTALLED=1 || ALREADY_INSTALLED=0
if [ "$PATH_VERIFY" = "TBD" ];then
	ALREADY_INSTALLED=1
	## this is for script developer, if we do not know yet how to 
	## verify the installation success for a module, we pass 
	## PATH_VERIFY='TBD' and do assume correct installation
	MSG="WARNING: PATH_VERIFY was set to 'TBD' and needs to be identified."
	POL_Debug_Message "# $MSG"
fi

if [ "$ALREADY_INSTALLED" = 0 ];then
	MSG="ERROR: cannot verify installed component >$PATH_VERIFY<"
	POL_Debug_Message "# $MSG"
	POL_SetupWindow_wait "$(eval_gettext '$MSG')" "$TITLE"
	POL_SetupWindow_Close
	return -1
fi
return 0
}
# ==============================================================
create_POL_shortcut()
# --------------------------------------------------------------
# 1. get installed Balabolka version
# 2. remove previous desktop starter
# 3. remove previous POL shortcut
# 4. add shortcut with version info
# ==============================================================
{
# -------------------
POL_Debug_Message "# get installed Balabolka version"
VERSION_INSTALLED=""
POL_Debug_Message "# WINEPREFIX: $WINEPREFIX"
VERSION_FILE="$WINEPREFIX/system.reg"
POL_Debug_Message "# VERSION_FILE=$VERSION_FILE"
[ ! -f "$VERSION_FILE" ] && POL_Debug_Message "file not found $VERSION_FILE"
[ -f "$VERSION_FILE" ] && VERSION_INSTALLED=`grep -A 1 '"DisplayName"="Balabolka"' $VERSION_FILE | grep '"DisplayVersion"' | cut -d '"' -f 4`
POL_Debug_Message "# VERSION_INSTALLED: $VERSION_INSTALLED"
LAUNCHER="$TITLE"
[ ! -z "$VERSION_INSTALLED" ] && LAUNCHER="$TITLE-v$VERSION_INSTALLED"
POL_Debug_Message "# LAUNCHER: $LAUNCHER"
# -------------------
PATH_SHORTCUT="$POL_USER_ROOT/shortcuts/$LAUNCHER"
if [ ! -f "$PATH_SHORTCUT" ];then
	# -------------------
	POL_Debug_Message "# remove previous desktop starter"
	LINUX_DESKTOP=`xdg-user-dir DESKTOP`
	PATH_SHORTCUT="$LINUX_DESKTOP/Balabolka"
	rm -r "$PATH_SHORTCUT"* 2>/dev/null;
	# -------------------
	POL_Debug_Message "# remove previous POL shortcut"
	PATH_SHORTCUT="$POL_USER_ROOT/shortcuts/$TITLE"
	rm -r "$PATH_SHORTCUT"* 2>/dev/null;
	# -------------------
	POL_Debug_Message "# create POL shortcut"
	POL_Shortcut "balabolka.exe" "$LAUNCHER" "" "" "AudioVideo;Audio;AudioVideoEditing;Music;"
fi
[ -f "$PATH_SHORTCUT" ] && MSG="$LAUNCHER installation ok" && POL_Debug_Message "# $MSG"
return 0
}
######################
# MAIN
IMAGE_TOP="http://balabolka.site/data/balabolka_japan.jpg"
IMAGE_LEFT="https://cdn.lo4d.com/t/icon/128/balabolka.png"
POL_GetSetupImages --force  "$IMAGE_TOP" "$IMAGE_LEFT" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_Debug_Message "# show POL Window"
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
# ---------------------
POL_Debug_Message "# create PREFIX environment"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate
Set_OS "win7"
POL_System_TmpCreate "$PREFIX"
PWD_OLD=`pwd`
cd "$POL_System_TmpDir" || POL_Debug_Fatal "Unable to change directory"
POL_Debug_Message "# WINEPREFIX: $WINEPREFIX"
POL_Debug_Message "# PREFIX: $PREFIX"
POL_Debug_Message "# POL_System_TmpDir: $POL_System_TmpDir"
POL_Debug_Message "# POL_HOME : $POL_HOME"
POL_Debug_Message "# POL_USER_HOME: $POL_USER_HOME"
# ===================
POL_Debug_Message "# fill arrays"
# Balabolka, MS Speech Runtime & LANGS
# Download of Microsoft installer is available
MSSPEECH="http://www.cross-plus-a.com/msspeech"
MS_VOICE="$MSSPEECH/MSSpeech_TTS_"
PATH_SPEECH_BASE="$WINEPREFIX/drive_c/Program Files/Common Files/Microsoft Shared/Speech/"
PATH_SPEAKER="$PATH_SPEECH_BASE/Tokens/TTS_MS_"
#
typeset -i i=0 
aExecChoice[$i]="Balabolka-Program"
aDownldInst[$i]="http://www.cross-plus-a.com/balabolka.zip"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="$WINEPREFIX/drive_c/Program Files/Balabolka/balabolka.exe"
#
((i=i+1))
aExecChoice[$i]="MS Speech Platform Runtime"
aDownldInst[$i]="$MSSPEECH/SpeechPlatformRuntime.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="$PATH_SPEECH_BASE/Platform/v11.0/mssps.dll"
#
((i=i+1))
aExecChoice[$i]="Catalán"
aDownldInst[$i]="${MS_VOICE}ca-ES_Herena.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}ca-ES_Herena_11.0/MSTTSLoccaES.dat"
#
((i=i+1))
aExecChoice[$i]="Chinese-China"
aDownldInst[$i]="${MS_VOICE}zh-CN_HuiHui.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}zh-CN_HuiHui_11.0/MSTTSLoczhCN.dat"
#
((i=i+1))
aExecChoice[$i]="Chinese-HongKong"
aDownldInst[$i]="${MS_VOICE}zh-HK_HunYee.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}zh-HK_HunYee_11.0/MSTTSLoczhHK.dat"
#
((i=i+1))
aExecChoice[$i]="Chinese-Taiwan"
aDownldInst[$i]="${MS_VOICE}zh-TW_HanHan.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}zh-TW_HanHan_11.0/MSTTSLoczhTW.dat"
#
((i=i+1))
aExecChoice[$i]="Danish"
aDownldInst[$i]="${MS_VOICE}da-DK_Helle.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}da-DK_Helle_11.0/MSTTSLocdaDK.dat"
#
((i=i+1))
aExecChoice[$i]="Deutsche Sprache"
aDownldInst[$i]="${MS_VOICE}de-DE_Hedda.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}de-DE_Hedda_11.0/MSTTSLocdeDE.dat"
#
((i=i+1))
aExecChoice[$i]="English-Australia"
aDownldInst[$i]="${MS_VOICE}en-AU_Hayley.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}en-AU_Hayley_11.0/MSTTSLocenAU.dat"
#
((i=i+1))
aExecChoice[$i]="English-India"
aDownldInst[$i]="${MS_VOICE}en-IN_Heera.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}en-IN_Heera_11.0/MSTTSLocenIN.dat"
#
((i=i+1))
aExecChoice[$i]="English-UK"
aDownldInst[$i]="${MS_VOICE}en-GB_Hazel.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}en-GB_Hazel_11.0/MSTTSLocenGB.dat"
#
((i=i+1))
aExecChoice[$i]="English-US"
aDownldInst[$i]="${MS_VOICE}en-US_Helen.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}en-US_Helen_11.0/MSTTSLocenUS.dat"
#
((i=i+1))
aExecChoice[$i]="Español-Canadá"
aDownldInst[$i]="${MS_VOICE}ca-ES_Herena.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}ca-ES_Herena_11.0/MSTTSLoccaES.dat"
#
((i=i+1))
aExecChoice[$i]="Español-España"
aDownldInst[$i]="${MS_VOICE}es-ES_Helena.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}es-ES_Helena_11.0/MSTTSLocesES.dat"
#
((i=i+1))
aExecChoice[$i]="Español-Mexico"
aDownldInst[$i]="${MS_VOICE}es-MX_Hilda.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}es-MX_Hilda_11.0/MSTTSLocesMX.dat"
#
((i=i+1))
aExecChoice[$i]="Finnish"
aDownldInst[$i]="${MS_VOICE}fi-FI_Heidi.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}fi-FI_Heidi_11.0/MSTTSLocfiFI.dat"
#
((i=i+1))
aExecChoice[$i]="Français-Canada"
aDownldInst[$i]="${MS_VOICE}fr-CA_Harmonie.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}fr-CA_Harmonie_11.0/MSTTSLocfrCA.dat"
#
((i=i+1))
aExecChoice[$i]="Français-France"
aDownldInst[$i]="${MS_VOICE}fr-FR_Hortense.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}fr-FR_Hortense_11.0/MSTTSLocfrFR.dat"
#
((i=i+1))
aExecChoice[$i]="Italiano"
aDownldInst[$i]="${MS_VOICE}it-IT_Lucia.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}it-IT_Lucia_11.0/MSTTSLocitIT.dat"
#
((i=i+1))
aExecChoice[$i]="Japanese"
aDownldInst[$i]="${MS_VOICE}ja-JP_Haruka.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}ja-JP_Haruka_11.0/MSTTSLocjaJP.dat"
#
((i=i+1))
aExecChoice[$i]="Korean"
aDownldInst[$i]="${MS_VOICE}ko-KR_Heami.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}ko-KR_Heami_11.0/MSTTSLockoKR.dat"
#
((i=i+1))
aExecChoice[$i]="Nederlands"
aDownldInst[$i]="${MS_VOICE}nl-NL_Hanna.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}nl-NL_Hanna_11.0/MSTTSLocnlNL.dat"
#
((i=i+1))
aExecChoice[$i]="Norwegian"
aDownldInst[$i]="${MS_VOICE}nb-NO_Hulda.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}nb-NO_Hulda_11.0/MSTTSLocnbNO.dat"
#
((i=i+1))
aExecChoice[$i]="Polski"
aDownldInst[$i]="${MS_VOICE}pl-PL_Paulina.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}pl-PL_Paulina_11.0/MSTTSLocplPL.dat"
#
((i=i+1))
aExecChoice[$i]="Portugês-Portugal"
aDownldInst[$i]="${MS_VOICE}pt-PT_Helia.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}pt-PT_Helia_11.0/MSTTSLocptPT.dat"
#
((i=i+1))
aExecChoice[$i]="Portugês-Brasil"
aDownldInst[$i]="${MS_VOICE}pt-BR_Heloisa.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}pt-BR_Heloisa_11.0/MSTTSLocptBR.dat"
#
((i=i+1))
aExecChoice[$i]="Russian"
aDownldInst[$i]="${MS_VOICE}ru-RU_Elena.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}ru-RU_Elena_11.0/MSTTSLocruRU.dat"
#
((i=i+1))
aExecChoice[$i]="Swedish"
aDownldInst[$i]="${MS_VOICE}sv-SE_Hedvig.msi"
aPrgDisplay[$i]=${aExecChoice[$i]}
aPathVerify[$i]="${PATH_SPEAKER}sv-SE_Hedvig_11.0/MSTTSLocsvSE.dat"
#
# ===================
# USER CHOICE: select languages to be installed
typeset -i j=2 max=${#aExecChoice[*]} # start at 3rd entry, after Balboka, MS Runtime
SEPERATOR="~"
CHOICE=""
while (( j < max ))
do
   [ -z "${CHOICE}" ] && CHOICE="${aExecChoice[j]}" || CHOICE="${CHOICE}${SEPERATOR}${aExecChoice[$j]}"
   j=j+1
done

POL_Debug_Message "# CHOICE : ${CHOICE} #"

MSG="Please select components to install"
POL_SetupWindow_checkbox_list "$(eval_gettext '$MSG')" "$TITLE" "$CHOICE" "$SEPERATOR"
POL_Debug_Message "# APP_ANSWER : >$APP_ANSWER<"
if [ -z "$APP_ANSWER" ];then
	MSG="No language component has been selected.\nDo you want to overwrite an existing Installation ("${aPrgDisplay[0]}", "${aPrgDisplay[1]}")?"
	POL_SetupWindow_question "$(eval_gettext '$MSG')" "$TITLE"
	if [ ! "$APP_ANSWER" = "TRUE" ];then
	 	cd $PWD_OLD 
	 	POL_SetupWindow_Close 
	 	exit 0
	fi
fi
j=2
while (( j < max ))
do
   [ "$(echo $APP_ANSWER | grep -o "${aExecChoice[$j]}")" != "" ] && aExecChoice[$j]="OK" || aExecChoice[$j]=""
   j=j+1
done
aExecChoice[0]="OK" # we always need main program
aExecChoice[1]="OK" # we always need MS Speech Runtime
# ===================
# USER CHOICE: LOCAL,DOWNLOAD
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
POL_Debug_Message "# INSTALL_METHOD : >$INSTALL_METHOD<"
[ "$INSTALL_METHOD" = "False" ] && cd $PWD_OLD && POL_SetupWindow_Close && exit 0
# ---------------------
# install component
i=0
while (( i < max ))
do
   get_unpack_install \
   	"${aExecChoice[$i]}" \
   	"${aDownldInst[$i]}" \
   	"${aPrgDisplay[$i]}" \
   	"${aPathVerify[$i]}" \
   	"$INSTALL_METHOD"
   RET_VAL="$?"
   POL_Debug_Message \
   	"# get_unpack_install ($i, ${aPrgDisplay[$i]}) returned $RET_VAL" 
   [ ! "$RET_VAL" -eq 0 ] && exit -1
   [ "$i" = 0 ] && create_POL_shortcut
   i=i+1
done
######################
# Close POL
cd $PWD_OLD
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYFycdQAKCRDlMfrJqhPK
R7BjAKCCQA5okZR9gzWEhpo9+F6DTKVBlQCfd0GGA6A148/4ZzCvq7ydwZIYtpw=
=pNYC
-----END PGP SIGNATURE-----
