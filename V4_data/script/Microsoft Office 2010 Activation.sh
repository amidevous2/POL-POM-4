#!/bin/bash
# Author : Robert Paulo

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Office2010"
WINEVERSION="1.5.3"
TITLE="Microsoft Office 2010"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/Office/top.jpg" "http://files.playonlinux.com/resources/setups/Office/left.png" "$TITLE"
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com" "Quentin PÂRIS" "$PREFIX"
 
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
 
if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi
POL_Debug_Init
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" == "True" ]; then
	POL_SetupWindow_menu "$(eval_gettext 'Which type of activation?')" "$TITLE" "Volume Activation (KMS)~~~Skip activation" "~~~"
	if [ "$APP_ANSWER" == "Volume Activation (KMS)" ]; then
		dataCorrect="FALSE"
		while [ "$dataCorrect" != "TRUE" ]; do
			licenseServerName=""
			POL_SetupWindow_textbox "$(eval_gettext 'Insert address of license server!')" "$TITLE"
			licenseServerName=$APP_ANSWER
			POL_SetupWindow_textbox "$(eval_gettext 'Insert port of license server!')" "$TITLE"
			licenseServerPort=$APP_ANSWER
			
			POL_SetupWindow_question "$(eval_gettext 'Are the data for the license server correct?\nCan these values be added to the registry?\n\nLicense server name: $licenseServerName\nLicense server port: $licenseServerPort')" "$TITLE"
			dataCorrect=$APP_ANSWER
		done
		cd "$POL_USER_ROOT//wineprefix/$PREFIX/"
		# copy registry value from user.reg
		echo "[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\OfficeSoftwareProtectionPlatform]" > VLKMSServ.reg
		echo "\"KeyManagementServiceName\"=\"$licenseServerName\"" >> VLKMSServ.reg
		echo "\"KeyManagementServicePort\"=\"$licenseServerPort\"" >> VLKMSServ.reg
		
		POL_Wine regedit VLKMSServ.reg
		sleep 2
		rm VLKMSServ.reg
		POL_SetupWindow_message "$(eval_gettext '$TITLE should be activated now.\nMaybe two starts of $TITLE are necessary:\nOne for initialising and one for registration.\n\nJust start, close and restart $TITLE!')" "$TITLE"
	elif [ "$APP_ANSWER" == "Volume Activation (MAK)" ]; then
		echo
	fi
else
	POL_SetupWindow_message "$(eval_gettext 'No $TITLE installation found.\n\nPlease use the $TITLE installation script!')" "$TITLE"
fi	

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAj7XAACgkQ5TH6yaoTykf4QwCfXnFIZBN/aNkDw/B5FdCkhXmz
LqsAn2/l6iqLA66aISsr2nAqX1jB9UU1
=QF6Z
-----END PGP SIGNATURE-----
