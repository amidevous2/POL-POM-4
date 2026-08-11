#!/bin/bash
# Last revision : (2024-07-07)
# Wine version used : 9.0
# Author : JoseskVolpe
# License : GNU/GPL v3


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Samsung SDK for the Java(TM) ME Platform"
PREFIX="SamsungSDK"
WORKING_WINE_VERSION="9.0"
LOGO="https://i.imgur.com/yEdFbdY.png"
BANNER="https://i.imgur.com/Di6W76j.png"

SAMSUNG_URL="https://archive.org/download/samsung-sdk-1.2.2_202205/Samsung_sdk_1.2.2.exe"
SAMSUNG_MD5="1b1256697b15eec9adb6124a93ab31d2"

OPENJDK_URL="https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x86-32_windows_hotspot_8u412b08.msi"
OPENJDK_MD5="c368e7f218412cb01a2be7c0e6138961"

exit_install(){
    POL_System_TmpDelete
    POL_SetupWindow_Close
    exit $1
}
install_dep_message(){
    POL_SetupWindow_wait "The assistant is installing the required components for $TITLE\n\nInstalling $1...\n$2." "$TITLE"
}

# POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE" # invalid bitmap error, disabled for awhile
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Samsung" "https://www.samsung.com" "Josesk Volpe" "$PREFIX"

POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

    POL_SetupWindow_browse 'Please select the .EXE installation file to run' "$TITLE"

    SETUP_EXE=$APP_ANSWER

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then

    POL_SetupWindow_wait "Connecting to $SAMSUNG_URL..." "$TITLE"
    POL_Download "$SAMSUNG_URL" "$SAMSUNG_MD5"

    SETUP_EXE="Samsung_sdk_1.2.2.exe"

fi

quicktime() {
    install_dep_message "QuickTime 7.6" "Please accept the installation."
    winetricks quicktime76 &> $POL_System_TmpDir/winetricks.log || {
        POL_Debug_Error "Error installing quicktime76 from winetricks\n\n$(cat $POL_System_TmpDir/winetricks.log)"
        POL_SetupWindow_menu "There was an ERROR trying to install QuickTime. This component is required to proceed the install. Try again?" "ERROR - $TITLE" "Try again~Abort" "~"
        if [ "$APP_ANSWER" = "Abort" ]
        then
            exit_install 1
        else
            quicktime
        fi
    }
}

gmdls() {
    install_dep_message "General MIDI DLS Collection"
    winetricks --force gmdls &> $POL_System_TmpDir/winetricks.log || {
        POL_Debug_Error "Error installing gmdls from winetricks\n\n$(cat $POL_System_TmpDir/winetricks.log)"
        POL_SetupWindow_menu "There was an ERROR trying to install General MIDI DLS Collection. The software will work but you'll experience crashes without this component. Try again?" "ERROR - $TITLE" "Try again~Continue~Abort" "~"
        if [ "$APP_ANSWER" = "Abort" ]
        then
            exit_install 1
        elif [ "$APP_ANSWER" = "Try again" ]
        then
            gmdls
        fi
    }
}

openjdk() {
    install_dep_message "OpenJDK 8"
    POL_Download "$OPENJDK_URL" "$OPENJDK_MD5"
    install_dep_message "OpenJDK 8"
    echo "wineprefix: $WINEPREFIX"
    POL_Wine msiexec /i "OpenJDK8U-jdk_x86-32_windows_hotspot_8u412b08.msi" /quiet &> $POL_System_TmpDir/openjdk.log || {
        POL_Debug_Error "Error installing OpenJDK\n\n$(cat $POL_System_TmpDir/openjdk.log)"
        POL_SetupWindow_menu "There was an ERROR trying to install OpenJDK 8. This component is required to proceed the install. Try again?" "ERROR - $TITLE" "Try again~Abort" "~"
        if [ "$APP_ANSWER" = "Abort" ]
        then
            exit_install 1
        elif [ "$APP_ANSWER" = "Try again" ]
        then
            openjdk
        fi
    }
}

quicktime
gmdls
openjdk

POL_SetupWindow_wait "The setup is installing $TITLE..." "$TITLE"
POL_Wine "$SETUP_EXE"

POL_Shortcut "ktoolbar.exe" "$TITLE" "" "" "Development;"

POL_SetupWindow_message "$(eval_gettext 'Installation is finished.')" "$TITLE"
exit_install 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZpePvAAKCRDlMfrJqhPK
R6B4AJ4qGQnfR/JkLD1eB0OJ/YwaOiDVBwCgqHIC/nm0eP9okB3uX0yCYfg7gFg=
=bOeD
-----END PGP SIGNATURE-----
