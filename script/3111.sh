#!/usr/bin/env playonlinux-bash
# Date : (2017-01-21 03-00)
# Last revision : (2017-01-21 03-00)
# Wine version used : 1.6.2
# Distribution used to test : Ubuntu 16.04 LTS
# Author : Aredon
# Depend: unzip
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="WinSCP"
PREFIX="WinSCP"
SHORTCUT_NAME="WinSCP"
WINSCP_VERSION="5.9.3"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_presentation "$TITLE" "WinSCP-Team" "http://www.winscp.net/" "Aredon" "$PREFIX"
cd "$POL_System_TmpDir"

POL_SetupWindow_menu "Please select a Language" "$TITLE" "English|German|French|Brazilian Portuguese|Czech|Dutch|Finnish|Italian|Japanese|Polish|Russian|Spanish|Simplified Chinese" "|"
LANG="$APP_ANSWER"

if [ "$LANG" == "German" ]
then
   LANG="de"
   LANG_NUMBER="1031"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/de.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "French" ]
then
   LANG="fr"
   LANG_NUMBER="1036"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/fr.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Brazilian Portuguese" ]
then
   LANG="pt"
   LANG_NUMBER="1046"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/pt.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Czech" ]
then
   LANG="cs"
   LANG_NUMBER="1029"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/cs.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Dutch" ]
then
   LANG="nl"
   LANG_NUMBER="1043"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/nl.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Finnish" ]
then
   LANG="fi"
   LANG_NUMBER="1035"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/fi.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Italian" ]
then
   LANG="it"
   LANG_NUMBER="1040"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/it.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Japanese" ]
then
   LANG="jp"
   LANG_NUMBER="1041"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/jp.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Polish" ]
then
   LANG="pl"
   LANG_NUMBER="1045"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/pl.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Russian" ]
then
   LANG="ru"
   LANG_NUMBER="1049"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/ru.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Spanish" ]
then
   LANG="es"
   LANG_NUMBER="1043"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/es.zip"
   POL_Wine_WaitBefore "$TITLE"
elif [ "$LANG" == "Simplified Chinese" ]
then
   LANG="chs"
   LANG_NUMBER="2052"
   POL_Download "https://winscp.net/translations/dll/$WINSCP_VERSION/chs.zip"
   POL_Wine_WaitBefore "$TITLE"
else
   LANG="en"
   LANG_NUMBER="1033"
fi

POL_SetupWindow_question "Would you have PuTTY and Pageant Support?" "$TITLE"
PUTTY="$APP_ANSWER"

if [ "$PUTTY" == "TRUE" ]
then
   POL_Download "https://the.earth.li/~sgtatham/putty/latest/x86/putty.exe"
   POL_Wine_WaitBefore "$TITLE"

   POL_Download "https://the.earth.li/~sgtatham/putty/latest/x86/puttygen.exe"
   POL_Wine_WaitBefore "$TITLE"

   POL_Download "https://the.earth.li/~sgtatham/putty/latest/x86/pageant.exe"
   POL_Wine_WaitBefore "$TITLE"
fi

POL_Download "https://netcologne.dl.sourceforge.net/project/winscp/WinSCP/$WINSCP_VERSION/WinSCP-$WINSCP_VERSION-Portable.zip"
POL_Wine_WaitBefore "$TITLE"

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
(unzip -qqo ./$LANG.zip && rm ./$LANG.zip) || exit 1

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
(unzip -qqo ./WinSCP-$WINSCP_VERSION-Portable.zip && rm ./WinSCP-$WINSCP_VERSION-Portable.zip) || exit 1

if [ "$PUTTY" == "TRUE" ]
then
   echo "[Configuration\Interface]" > ./WinSCP.ini && echo "LocaleSafe=$LANG_NUMBER" >> ./WinSCP.ini && echo "PuttyPath=putty.exe" >> ./WinSCP.ini
else
   echo "[Configuration\Interface]" > ./WinSCP.ini && echo "LocaleSafe=$LANG_NUMBER" >> ./WinSCP.ini
fi

POL_SetupWindow_licence "Please read and accept the License:" "$TITLE" "$POL_System_TmpDir/license.txt"

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "winxp"

mkdir /$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/WinSCP
mv $POL_System_TmpDir/* /$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program\ Files/WinSCP

POL_Shortcut "$SHORTCUT_NAME.exe" "$TITLE" "" "" "Development;Network;Building;RemoteAccess;FileTransfer"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXURTMwAKCRDlMfrJqhPK
R2z4AKCRwlWcBH2dn3sKwJG2WFd/W/I8BQCghEUS3r+x/fRvF18TNBRzL2PcKW4=
=Mgq3
-----END PGP SIGNATURE-----
