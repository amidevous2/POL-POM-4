#!/bin/bash
# Date : (2014-12-28 15-03)
# Last revision : (2014-12-28 19-39)
# Wine version used : 1.7.133
# Distribution used to test : Mac OSX 10.10.2 Yosemite Appleseed Version
# Author : STFLightning with help from petch
     
# Changelog
# (2014-12-28 15-03) - STFLightning
#  Created Script
# (2014-12-28 15-10) - STFLightning
#  Fixed Capitalisation Error, Added Changelog
# (2014-12-28 16-44) - STFLightning with help from petch
#  Fixed Tons Of Errors
# (2014-12-28 19-17) - STFLightning with help from petch
#  Fixed More Errors, Some Fixed Errors That Re-Appeared Have Been Fixed
# (2014-12-28 19-22) - STFLightning
#  Added exit to end of script, gave petch credit, fixed presentation bug
# (2014-12-28 19-39) - STFLightning
#  Fixed if and elif comparisons
# (2020-10-23 10-00) - Dadu042
#  Wine v1.7.33 -> 3.0.3 (game server is down)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Planet Pokémon"
PREFIX="PlanetPokemon"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_SetID 2368
     
## Welcome & Setup Options
POL_SetupWindow_presentation "Planet Pokémon" "Planet Pokémon Team" "http://www.planetpokemon.net" "STFLightning & petch" $PREFIX
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
     
## Prefix Creation
POL_System_SetArch "x86"
POL_Wine_SelectPrefix $PREFIX
POL_Wine_PrefixCreate "3.0.3"
Set_OS "win7"
     
## Installing Prerequisites
POL_Call POL_Install_d3dx11
POL_Call POL_Install_dinput8
POL_Call POL_Install_dotnet40
     
## Install
if [$INSTALL_METHOD="DOWNLOAD"]
then
    POL_System_TmpCreate $PREFIX
    cd $POL_System_TmpDir
    POL_Download "http://www.planetpokemon.net/download/prealpha/Planet%20Pokemon%20(Windows).zip" "cb54b24e3c7c808e36fc22b220779c6"
fi
elif [$INSTALL_METHOD="LOCAL"]
then
    POL_SetupWindow_browse "Please select the downloaded zip file." $TITLE
    localInstallerPath=$APP_ANSWER
    POL_System_TmpCreate $PREFIX
    cd $POL_System_TmpDir
    cp localInstallerPath ./
fi
   
POL_System_unzip "Planet Pokemon (Windows).zip"
mv ./"Planet Pokemon (Windows)"/* $WINEPREFIX/drive_c/$PROGRAMFILES/
     
POL_Shortcut "Planet Pokemon.exe" $TITLE
      
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX5LcdwAKCRDlMfrJqhPK
R7XGAJ9Kb+Y/cKAfgMgo8xqVsJxcfBQLbgCaAsH6c2G7YTAbtUWq5Umm4qlUq5s=
=mZl1
-----END PGP SIGNATURE-----
