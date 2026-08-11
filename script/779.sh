#!/bin/bash
# PlayOnLinux Function
# Date : (2010-12-17 21:00)
# Last revision : (2013-01-22 21:13)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# [petch] (2013-01-22 21:13)
#   Fixing bug #1787
# [Dadu042] (2020-07-26 09:00)
#   [NEW] overrides (to match Winetricks code)

FORCE_MODE=$1

if [ "$POL_ARCH" = "amd64" ]; then
	# Downloading vcrun2010 sp1 x64
	POL_Download_Resource "http://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe" "be79543624f806ced4c7dff25751a3e4" "vcrun2010"
fi

# Downloading vcrun2010 sp1 x86
POL_Download_Resource "http://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe" "bd2af26fccd52e01511ff3e088f4c8bb" "vcrun2010"

# Check if vcrun2010 is already installed
CHECK_VC2K10=`find $WINEPREFIX -name "msdia100.dll"`
if [ "$CHECK_VC2K10" = "" -o "$FORCE_MODE" = "--force" ]; then
	if [ "$CHECK_VC2K10" != "" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Warning : vcrun2010 seems to be already installed.\nForcing reinstallation.')" "$TITLE"
	fi

	cd "$POL_USER_ROOT/ressources/vcrun2010"

	# Fix before install for wine 1.3.37 and older
	POL_AdvisedVersion  4.0.16 || POL_Debug_Error "$(eval_gettext 'VCRun2010 might fail to install because your PlayOnLinux version is too old. Please update.')"
	if VersionLower $(POL_Config_PrefixRead VERSION) 1.3.37; then
		POL_Call POL_Install_msxml3
		ln -s "$WINEPREFIX/drive_c" "$WINEPREFIX/harddiskvolume0"
		rm -f "$WINEPREFIX/dosdevices/c:"
		ln -s "$WINEPREFIX/harddiskvolume0" "$WINEPREFIX/dosdevices/c:"
	fi

	# Installing vcrun2010
	if [ "$POL_ARCH" = "amd64" ]; then
		rm "$WINEPREFIX/drive_c/windows/syswow64/msvcp100.dll"
		rm "$WINEPREFIX/drive_c/windows/system32/msvcp100.dll"
		POL_Wine start /unix "vcredist_x64.exe" /q
		POL_Wine_WaitExit "vcrun2010 sp1 x64"
		POL_Wine start /unix "vcredist_x86.exe" /q
		POL_Wine_WaitExit "vcrun2010 sp1 x86"
	else
		rm "$WINEPREFIX/drive_c/windows/system32/msvcp100.dll"
		POL_Wine start /unix "vcredist_x86.exe" /q
		POL_Wine_WaitExit "vcrun2010 sp1 x86"
	fi
	
	# Overriding dll
	POL_Wine_OverrideDLL "native,builtin" "msvcp100"
	POL_Wine_OverrideDLL "native,builtin" "msvcr100"
	POL_Wine_OverrideDLL "native,builtin" "vcomp100"
	POL_Wine_OverrideDLL "native,builtin" "atl100"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYJrL8AAKCRDlMfrJqhPK
RyE/AJ9JUp2VnR18FHDZFJO8IzJbgH0r/gCgiYPSFdve1dYFxLPMEjSo6i5S6dw=
=iNMq
-----END PGP SIGNATURE-----
