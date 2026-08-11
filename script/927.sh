#!/bin/bash
# PlayOnLinux Function
# Date : (2011-08-20 12:18)
# Last revision : (2012-05-17 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

STEAM_ID=$1

# Check if Steam is installed
CHECK_STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$CHECK_STEAM" != "" ]; then
cd "$WINEPREFIX/drive_c/windows/temp/"
if [ "$POL_ARCH" == "amd64" ]; then
cat << EOF1 > "steam_fix_x64.reg"
[HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\Valve\\Steam\\Apps\\$STEAM_ID]
"VCRedist"=dword:00000001
"vcredist_x86"=dword:00000001
"MSVC"=dword:00000001
"VC2005"=dword:00000001
"VC2008"=dword:00000001
"VC2010"=dword:00000001
"DXSetup"=dword:00000001
"DirectX"=dword:00000001
"DXJun2010Redist"=dword:00000001
"DotNet"=dword:00000001
"dotNet35"=dword:00000001
"dotNet351"=dword:00000001
"dotNet40"=dword:00000001
"DotNetFX35"=dword:00000001
"DotNetFX351"=dword:00000001
"DotNetFX40"=dword:00000001
"Xna31"=dword:00000001
"Xna40"=dword:00000001
"DXSetup"=dword:00000001
"VCRedist"=dword:00000001
"DirectX 1"=dword:00000001
"VCRedist 1"=dword:00000001
"PhysX"=dword:00000001
"AMDCPU"=dword:00000001
"MSVC Redistributables"=dword:00000001
"Visual C++ 2008 SP1 Redistributable Package (x86)"=dword:00000001
"DirectX 9"=dword:00000001
"DirectX 10"=dword:00000001
"DirectX 11"=dword:00000001
"Windows Media Format 11"=dword:00000001
"G4W"=dword:00000001
"GfWLPKSetter"=dword:00000001
"MSVCR"=dword:00000001

[HKEY_LOCAL_MACHINE\\Software\\Valve\\Steam\\Apps\\$STEAM_ID]
"VCRedist"=dword:00000001
"vcredist_x86"=dword:00000001
"MSVC"=dword:00000001
"VC2005"=dword:00000001
"VC2008"=dword:00000001
"VC2010"=dword:00000001
"DXSetup"=dword:00000001
"DirectX"=dword:00000001
"DXJun2010Redist"=dword:00000001
"DotNet"=dword:00000001
"dotNet35"=dword:00000001
"dotNet351"=dword:00000001
"dotNet40"=dword:00000001
"DotNetFX35"=dword:00000001
"DotNetFX351"=dword:00000001
"DotNetFX40"=dword:00000001
"Xna31"=dword:00000001
"Xna40"=dword:00000001
"DXSetup"=dword:00000001
"VCRedist"=dword:00000001
"DirectX 1"=dword:00000001
"VCRedist 1"=dword:00000001
"PhysX"=dword:00000001
"AMDCPU"=dword:00000001
"MSVC Redistributables"=dword:00000001
"Visual C++ 2008 SP1 Redistributable Package (x86)"=dword:00000001
"DirectX 9"=dword:00000001
"DirectX 10"=dword:00000001
"DirectX 11"=dword:00000001
"Windows Media Format 11"=dword:00000001
"G4W"=dword:00000001
"GfWLPKSetter"=dword:00000001
"MSVCR"=dword:00000001
EOF1

POL_Wine regedit "steam_fix_x64.reg"
else
cat << EOF2 > "steam_fix_x86.reg"
[HKEY_LOCAL_MACHINE\\Software\\Valve\\Steam\\Apps\\$STEAM_ID]
"VCRedist"=dword:00000001
"vcredist_x86"=dword:00000001
"MSVC"=dword:00000001
"VC2005"=dword:00000001
"VC2008"=dword:00000001
"VC2010"=dword:00000001
"DXSetup"=dword:00000001
"DirectX"=dword:00000001
"DXJun2010Redist"=dword:00000001
"DotNet"=dword:00000001
"dotNet35"=dword:00000001
"dotNet351"=dword:00000001
"dotNet40"=dword:00000001
"DotNetFX35"=dword:00000001
"DotNetFX351"=dword:00000001
"DotNetFX40"=dword:00000001
"Xna31"=dword:00000001
"Xna40"=dword:00000001
"DXSetup"=dword:00000001
"VCRedist"=dword:00000001
"DirectX 1"=dword:00000001
"VCRedist 1"=dword:00000001
"PhysX"=dword:00000001
"AMDCPU"=dword:00000001
"MSVC Redistributables"=dword:00000001
"Visual C++ 2008 SP1 Redistributable Package (x86)"=dword:00000001
"DirectX 9"=dword:00000001
"DirectX 10"=dword:00000001
"DirectX 11"=dword:00000001
"Windows Media Format 11"=dword:00000001
"G4W"=dword:00000001
"GfWLPKSetter"=dword:00000001
"MSVCR"=dword:00000001
EOF2

POL_Wine regedit "steam_fix_x86.reg"
fi
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+07dwACgkQ5TH6yaoTykdMjACePKWdm+dreOQrmowzL2tGqAAK
63EAniWkc5HaeCKlHHnOAtarfw6d5wqu
=TEv2
-----END PGP SIGNATURE-----
