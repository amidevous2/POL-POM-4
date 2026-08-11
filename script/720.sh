#!/bin/bash
# PlayOnLinux Function
# Date : (2010-11-14 21:00)
# Last revision : (2013-04-22 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

FORCE_MODE=$1

# Downloading Mono 2.6
mkdir -p "$POL_USER_ROOT"/ressources/mono26/
cd "$POL_USER_ROOT"/ressources/mono26/
POL_Download_Resource "http://download.mono-project.com/archive/2.6.7/windows-installer/2/mono-2.6.7-gtksharp-2.12.10-win32-2.exe" "377834b579dfbdd873e3139acb35acfc" "mono26"

# Check if mono26 is already installed
CHECK_MONO26=`find $WINEPREFIX -name "mono.dll"`
if [ "$CHECK_MONO26" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
	POL_Wine start /unix "mono-2.6.7-gtksharp-2.12.10-win32-2.exe" /silent
	POL_Wine_WaitExit "Mono 2.6"

cat << EOF > mono26_fix.reg
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\NET Framework Setup\\NDP\\v2.0.50727]
"Install"=dword:00000001
"SP"=dword:00000001

[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\.NETFramework\\policy\\v2.0]
"4322"="3706-4322"
EOF
	POL_Wine regedit mono26_fix.reg
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1urYACgkQ5TH6yaoTykeouQCgn9tnW/UEyQtFFrfFbUMo8FDm
EZoAoIB0kv/DasAmBS3mhIz7XANhYEyy
=SCp9
-----END PGP SIGNATURE-----
