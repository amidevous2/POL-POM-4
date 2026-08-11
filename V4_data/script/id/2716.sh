#!/bin/bash
# Date : (2015-12-21 00-20)
# Last revision : (2015-12-21 00-20)
# Wine version used : 1.7.49
# Distribution used to test : Arch Linux (kernel 4.2.5-1)
# Author : Cedric Wehrum
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="CassyLab 2"
PREFIX="CASSYLab2"

#Used to determine which file should be downloaded, depending on the preferred language
DOWNLOAD_LANG_CODE=("de" "en" "fr" "es" "pt" "it" "nl" "ru")
DOWNLOAD_HASH=("b3e97b0760ac05dad4ef15e7966cac86" "bb0e7ec6dcf5e94c16102e58101579a0" "983fe20eedc95d689aec1076af5d6fe3" "22846d4e917583683d84083c4ddf8674" "c40e194be08d0f76b99d36102005f84a" "073414ad07562765b75cb87f1cf08c09" "a6cb672946018e972cf87542d3be7c03" "2165fa5eae1c5afe19115292b7a90b95")

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "LD Didactic" "http://www.ld-didactic.de" "Cedric Wehrum" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
# I think I remember that the software didn't work for me with some older versions of wine. Just to be sure I'm using 1.7.49 which is known to work
POL_Wine_PrefixCreate "1.7.49"
# The most important thing. CASSYLab doesn't work without dotnet 2.0
POL_Call POL_Install_dotnet20

# Either download from the website or use a local file
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    # Installing (It seems that this is one of the rare 5% cases where wine crashes without 'start /unix')
    POL_Wine start /unix "$APP_ANSWER"
    # Wine returns immediately. So we have to wait for the user to confirm that the installation is over.
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    # Downloading file
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    # There are different setup files. One for each language. So the user has to choose the language beforehand.
    POL_SetupWindow_menu_num "$(eval_gettext 'Which language version would you like to install?')" "$TITLE" "German~English~French~Spanish~Portuguese~Italian~Dutch~Russian" "~"
    
    POL_Download "http://www.ld-didactic.com/software/cassylab2_${DOWNLOAD_LANG_CODE[APP_ANSWER]}.msi" ${DOWNLOAD_HASH[APP_ANSWER]}
    # Installing (It seems that this is one of the rare 5% cases where wine crashes without 'start /unix')
    POL_Wine start /unix "$POL_System_TmpDir/cassylab2_${DOWNLOAD_LANG_CODE[APP_ANSWER]}.msi"
    # Wine returns immediately. So we have to wait for the user to confirm that the installation is over.
    POL_Wine_WaitExit "$TITLE"
    # Delete downloaded file
    POL_System_TmpDelete
fi

# Create a shortcut, show the user a message that everything went successfully and exit
POL_Shortcut "CASSYLab2.exe" "$TITLE" "$TITLE.png"
POL_SetupWindow_question "$(eval_gettext 'Do you want to open the online manual?')" "$TITLE"
[ "$APP_ANSWER" = "TRUE" ] && POL_Browser "http://www.ld-didactic.de/en/service/software-download/cassylab2.html"
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlag0+kACgkQ5TH6yaoTykfQ3gCgg0SkZXujAQOr4UK8+MNpacoF
zN0AoJkWnE9fZMWIg0Ra4FjUlyxYX/qV
=SiSJ
-----END PGP SIGNATURE-----
