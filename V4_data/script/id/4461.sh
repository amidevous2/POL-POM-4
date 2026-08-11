#!/usr/bin/env playonlinux-bash
# Date : (2022-02-17 07-00)
# Last revision : (2022-03-02 05-15)
# Wine version used : 7.0
# Distribution used to test : Ubuntu 20.04 LTS
# Author : Spiff
# PlayOnLinux : 4.3.4
# Script license : GPL3
# Program license : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Infantry Online"
PREFIX="InfantryOnline"
COMPANY="Free Infantry Group"
DOMAIN="http://www.freeinfantry.com"
TEMPTITLE="$TITLE"
WINEVERSION="7.0"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/infantryonline/top.jpg" "http://files.playonlinux.com/resources/setups/infantryonline/left.jpg" "$TITLE"
POL_GetSetupImages "http://freeinfantry.com/download/installer-images/linux-pol-top-64x64.png" "http://freeinfantry.com/download/installer-images/linux-pol-left-150x356.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$DOMAIN" "Spiff" "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then

	POL_SetupWindow_browse "Please select the installation file to run." "$TITLE Installer"
	INSTALLER="$APP_ANSWER"
		
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then

	POL_SetupWindow_wait "Downloading installer into a temp directory..." "$TITLE"
	cd "$POL_System_TmpDir"
	POL_Download "http://freeinfantry.com/download/win/latest/Install-Infantry-Online.exe"
	INSTALLER="$POL_System_TmpDir/Install-Infantry-Online.exe"
	
fi

if (( $(($WINEVERSION + 0)) >= 7.0 )); then
	TITLE="$TEMPTITLE (Step 1/1)"

else
	TITLE="$TEMPTITLE (Step 1/2)"
	POL_SetupWindow_wait "Installing .NET Framework 4.0..." "$TITLE"
	POL_Call POL_Install_dotnet40
	
	TITLE="$TEMPTITLE (Step 2/2)"
fi

POL_SetupWindow_wait "Installing Infantry Online..." "$TITLE"

TITLE="$TEMPTITLE"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then

	# Run the installer NOT silently since you chose local and most likely will want to change settings
	POL_Wine "$INSTALLER" /ddraw=opengl

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then

	# Run the installer silently (/S) and override the ddraw renderer to be opengl
	POL_Wine "$INSTALLER" /ddraw=opengl /S

fi

# Tell WINE we are overriding the ddraw dll
POL_Wine_OverrideDLL "native, builtin" "ddraw"

POL_Shortcut "InfantryLauncher.exe" "$TITLE" "" "" "Game;MultiplayerGame;"

POL_System_TmpDelete

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYiNMrgAKCRDlMfrJqhPK
R9/pAJ0b20Jhlkql/bMfw5LfsV3GQUIYZgCghN2ZDLxG+lWSDlKs6PaF4X1oFE8=
=PFpB
-----END PGP SIGNATURE-----
