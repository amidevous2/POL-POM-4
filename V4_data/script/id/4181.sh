#!/usr/bin/env playonlinux-bash
# Date : (2020-08-18 12:00)
# Last revision : (2020-08-18 12:00)
# Wine version used : 5.0.2
# Distribution used to test : Ubuntu 19.10
# Author : VolkerFröhlich
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Free
#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="mp3DirectCut"

PREFIX="mp3DirectCut"
AUTHOR="Volker Fröhlich"
EDITOR="Martin Pesch"
EDITOR_URL="https://mpesch3.de/"

EXECUTABLE_FILE="mp3DirectCut.exe"
MD5="a4043199945edd9023e2274445b6d528"
 
# Starting the script
POL_SetupWindow_Init
                           
# Starting debugging API
POL_Debug_Init
          
#POL_SetupWindow_SetID
# Open dialogue box
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
Set_OS "win7"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir" || POL_Debug_Fatal "Unable to change directory"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    DOWNLOAD_LINK="https://kubadownload.com/site/assets/files/2452/mp3DC230.exe"
    DOWNLOAD_FILE=$(basename $DOWNLOAD_LINK)
    POL_Download "$DOWNLOAD_LINK" "$MD5"
    INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi
[ -z "$INSTALLER" ] && exit -1

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_Wine_WaitBefore "$TITLE"
###########
# The installer consistently crashes wine and,
# POL_Wine will show an error message.
# However, the app then runs smoothly, so let's not bother.
export POL_IgnoreWineErrors="True"
POL_Wine "$INSTALLER"

POL_Shortcut "$EXECUTABLE_FILE" "$TITLE" "" "" "AudioVideo;Audio;AudioVideoEditing;Music;"
 
POL_System_TmpDelete
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzvlrgAKCRDlMfrJqhPK
RzW6AJsHioWtl5YxNAJbxj9U6a+LJsbfYwCgox0JCxkta9K1WdCkOFclcwlboWQ=
=1mT1
-----END PGP SIGNATURE-----
