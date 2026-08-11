#!/bin/bash
# PlayOnLinux Function
# Date : (2009-11-19 21-50)
# Last revision : (2014-01-11 00:38)
# Author : Berillions, Tinou
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# [Quentin PÂRIS] (2012-04-29 13:02)
#   Fixing bug #820
# [petch] (2013-01-22 16:00)
#   Fixing bug #1787
# [petch] (2014-01-11 00:38)
#   Fixing 0 byte msxml3.dll bug

FORCE_MODE=$1

POL_Download_Resource "http://repository.playonlinux.com/divers/msxml3.msi" "7049c6531837341363fe69d068d001b0" "msxml3"

# Check if msxml3 is already installed
CHECK_MSXML3=`find $WINEPREFIX -name "msxml3r.dll"`
if [ "$CHECK_MSXML3" = "" -o "$FORCE_MODE" = "--force" ]; then
	# Installing msxml3
	if [ "$POL_ARCH" = "amd64" ]; then
		rm "$WINEPREFIX/drive_c/windows/syswow64/msxml3.dll"
		rm "$WINEPREFIX/drive_c/windows/system32/msxml3.dll"
	else
		rm "$WINEPREFIX/drive_c/windows/system32/msxml3.dll"
	fi

	# Overriding dll
	POL_Wine_OverrideDLL "native" "msxml3"

	cd "$POL_USER_ROOT/ressources/msxml3/"
	POL_Wine msiexec /i msxml3.msi /q
	POL_Wine_WaitExit "msxml3"
	wineserver -k
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLQjr8ACgkQ5TH6yaoTykeqlQCgj2A3//0paJDLS8ZtMlXX4IPy
Y6kAnA0SLPqNtvQdSBrc803s11B0bRUX
=+kSY
-----END PGP SIGNATURE-----
