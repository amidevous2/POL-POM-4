#!/bin/bash
# Date : (2010-09-18 20:00)
# Last revision : (2013-01-23 00:15)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

FORCE_MODE=$1

# Mandatory Change to avoid install failure in some cases
Set_OS "winxp"
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > Set_SP3.reg
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion]
"CSDVersion"="Service Pack 3"
[HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows]
"CSDVersion"=dword:00000300
EOF
POL_Wine regedit Set_SP3.reg

# Installing mandatory dependencies
POL_Call POL_Install_msasn1

# Downloading GFWL
# Since we cannot validate the file with a hash (changes too often), do not put it into resources
# Otherwise in case of corrupted download, the only solution for the user is to clean his cache
# Download is not that large anyway (~22MB)
cd "$POL_USER_ROOT/tmp"
POL_SetupWindow_download "$(eval_gettext 'Downloading Game For Windows Live...')" "$TITLE" "http://download.microsoft.com/download/D/6/0/D60F0E11-CF52-42B9-A13A-E7DAB124F08F/xliveredist.msi"

# Checking if GFWL is installed
if [ ! -e "$WINEPREFIX/drive_c/windows/system32/xlive/sqmapi.dll" -o ! -e "$WINEPREFIX/drive_c/windows/syswow64/xlive/sqmapi.dll" -o "$FORCE_MODE" = "--force" ]; then
	if [ "$FORCE_MODE" = "--force" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Warning : GFWL seems to be already installed.\nForcing reinstallation.')" "$TITLE"
	fi
	# Installing GFWL
	cd "$POL_USER_ROOT/tmp"
	POL_Wine msiexec /qn /a xliveredist.msi
	POL_Wine_WaitExit

	# Overriding dll
	POL_Wine_OverrideDLL "native,builtin" "xlive"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlD/HcAACgkQ5TH6yaoTykeX5QCfe4+u0AGrtZXCuZMGve2/WLL6
eX8AoIeEBdef2q/6zg3wxRCrBUnGhIhl
=XmYB
-----END PGP SIGNATURE-----
