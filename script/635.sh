#!/bin/bash
# Last revision : (2012-05-15 21:00)
# Creator : Berillions 
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Changelog:
#   2012-05-14 petch: fixed case of registered DLLs from XAudio* to xaudio*

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "7c1fc2021cf57fed3c25c9b03cd0c31a"

# Extracting & Installing Xact dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing Xact dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

if [ "$POL_ARCH" == "amd64" ]; then
	POL_Debug_Message "Extracting x86 and x64 dlls"
	mkdir "xact_x64"
	cabextract -d xact_x64/ -L -F '*_xact_*x64*' directx_Jun2010_redist.exe
	cabextract -d xact_x64/ -L -F '*_x3daudio_*x64*' directx_Jun2010_redist.exe
	cabextract -d xact_x64/ -L -F '*_xaudio_*x64*' directx_Jun2010_redist.exe
	for x in `ls xact_x64/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
	mkdir "xact_x86"
	cabextract -d xact_x86/ -L -F '*_xact_*x86*' directx_Jun2010_redist.exe
	cabextract -d xact_x86/ -L -F '*_x3daudio_*x86*' directx_Jun2010_redist.exe
	cabextract -d xact_x86/ -L -F '*_xaudio_*x86*' directx_Jun2010_redist.exe
	for x in `ls xact_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F '*.dll' "$x"
	done
else
	POL_Debug_Message "Extracting only x86 dlls"
	mkdir "xact_x86"
	cabextract -d xact_x86/ -L -F '*_xact_*x86*' directx_Jun2010_redist.exe
	cabextract -d xact_x86/ -L -F '*_x3daudio_*x86*' directx_Jun2010_redist.exe
	cabextract -d xact_x86/ -L -F '*_xaudio_*x86*' directx_Jun2010_redist.exe
	for x in `ls xact_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
fi

# Registering XACT
POL_Debug_Message "Registering XACT & Xaudio dlls"
POL_SetupWindow_wait "$(eval_gettext 'Registering libraries, please wait\n(It can take a while)')" "$TITLE"
for x in "$WINEPREFIX/drive_c/windows/system32/xactengine"* "$WINEPREFIX/drive_c/windows/system32/xaudio"*
do
	POL_Wine --ignore-errors regsvr32 `basename $x`
	case $? in
	  0|4) ;; # 4 = registration not required
	  *) POL_Debug_Fatal "Error $? registering DLL $x"
	esac
done

# Cleaning
POL_Debug_Message "Deleting temporary directories"
rm -rf "$POL_USER_ROOT/ressources/xact_x86"
if [ "$POL_ARCH" == "amd64" ]; then
	rm -rf "$POL_USER_ROOT/ressources/xact_x64"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlYiUs0ACgkQ5TH6yaoTykdn8wCeKWv/cnHtMR/HCYnUOo8UqMN1
UaMAn1m/mzkDcQOVjXqElv+5upAdJl+B
=fmTO
-----END PGP SIGNATURE-----
