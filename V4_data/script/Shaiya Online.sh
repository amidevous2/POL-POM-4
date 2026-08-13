#!/bin/bash
# Last revision : (see changelog)
# Tested : Debian 6.0, Mac OSX
# Author : Tinou
# Script licence : GPLv3
#
# This script is designed for PlayOnLinux and PlayOnMac.
#
# CHANGELOG
# [Tinou] (2011-08-20 13-00)
#   Update for POL/POM 4.
# [Dadu042] (2019-05-10 20-36)
#   Fix broken download URL.
# [Dadu042] (2019-12-08)
#   Wine 4.0.1 -> System's Wine.
#   dotnet30sp1 -> dotnet40
# [Dadu042] (2020-02-03)
#   POL_RequiredVersion 4.3.4 -> 4.1.0  because the game seems OK with Wine 3.0

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Shaiya Online"
  
POL_Debug_Init
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Aeria Games" "http://www.aeriagames.com/" "Tinou" "Shaiya"

# Because POL v4.2.12 only support Wine 4.0 maximum as of 2019-05-20.
POL_RequiredVersion 4.1.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Prepare Wine
POL_Wine_SelectPrefix "Shaiya"
POL_Wine_PrefixCreate ""

POL_SetupWindow_message "We will open the web browser to let you download the game client." "$TITLE"
[ "$POL_LANG" = "fr" ] && link="https://fr.shaiya.aeriagames.com" || link="shaiya.aeriagames.com"
POL_Browser "$link"

Set_OS "win7"

POL_Call POL_Install_vcrun2008 
POL_Call POL_Install_dotnet40

if [ "$POL_SELECTED_FILE" = "" ]
 then
 POL_SetupWindow_browse "Where is the installation file of $TITLE?" "$TITLE"
 CHEMIN="$APP_ANSWER"
else
 CHEMIN="$POL_SELECTED_FILE"
fi

POL_SetupWindow_wait "Installing $TITLE" "$TITLE" "Game;"
  
# POL_SetupWindow_message "Debug: $CHEMIN" "$TITLE"
POL_Wine "$CHEMIN"
POL_Wine_WaitExit "$TITLE" --allow-kill

POL_Shortcut "game.exe" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_message "$TITLE has been successfully installed" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjdZxQAKCRDlMfrJqhPK
R05uAJwJFanrLjloBHT0aPv79sFFhfbsXQCgp+ZvnuEyF3+1VTnW753xnroDxSI=
=zXsp
-----END PGP SIGNATURE-----
