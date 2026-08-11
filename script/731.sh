#!/bin/bash
# PlayOnLinux Function
# Date : (2010-06-11 21:00)
# Last revision : (2013-04-22 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading CC580
POL_Download_Resource "http://download.microsoft.com/download/platformsdk/redist/5.80.2614.3600/w9xnt4/en-us/cc32inst.exe" "d46736967c161d9a065064387354ec31"

# Installing CC580
cd "$POL_USER_ROOT/ressources/"
POL_Wine cc32inst.exe /T:C:\playonlinux /c /q
unzip -o -d "$WINEPREFIX"/drive_c/windows/temp/ "$WINEPREFIX"/drive_c/playonlinux/playonlinux/comctl32.exe
POL_Wine "$WINEPREFIX"/drive_c/windows/temp/x86/50ComUpd.Exe /T:C:\playonlinux /c /q
if [ "$POL_ARCH" == "amd64" ]; then
	cp "$WINEPREFIX"/drive_c/playonlinux/playonlinux/comcnt.dll "$WINEPREFIX"/drive_c/windows/syswow64/comctl32.dll
else
	cp "$WINEPREFIX"/drive_c/playonlinux/playonlinux/comcnt.dll "$WINEPREFIX"/drive_c/windows/system32/comctl32.dll
fi
POL_Wine_WaitExit "cc580"

# Overriding dll
POL_Wine_OverrideDLL "native, builtin" "comctl32"

# Fix for builtin apps
POL_Call POL_Function_override_app_dlls winecfg.exe builtin comctl32
POL_Call POL_Function_override_app_dlls explorer.exe builtin comctl32
POL_Call POL_Function_override_app_dlls iexplore.exe builtin comctl32
POL_Call POL_Function_override_app_dlls regedit.exe builtin comctl32
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1d44ACgkQ5TH6yaoTyke3RgCfV9mDT8fqj8fiPp/e0U9LjAOZ
P5kAnRafvyivMtIdacvlYm7b9AuaCseU
=Y/Db
-----END PGP SIGNATURE-----
