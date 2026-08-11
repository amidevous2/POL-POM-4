#!/bin/bash
# Date : (2011-01-03 21-00)
# Last revision : (2012-02-24 21:00)
# Author : Unknown
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading directx runtime
POL_Download_Resource "http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" "822e4c516600e81dc7fb16d9a77ec6d4"

# Extracting & Installing Xinput dlls
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing Xinput dlls...')" "$TITLE"
cd "$POL_USER_ROOT/ressources"

if [ "$POL_ARCH" == "amd64" ]; then
	mkdir "xinput_x64"
	cabextract -d xinput_x64/ -L -F '*_xinput_*x64*' directx_Jun2010_redist.exe

	for x in `ls xinput_x64/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
	mkdir "xinput_x86"
	cabextract -d xinput_x86/ -L -F '*_xinput_*x86*' directx_Jun2010_redist.exe

	for x in `ls xinput_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F '*.dll' "$x"
	done
else
	mkdir "xinput_x86"
	cabextract -d xinput_x86/ -L -F '*_xinput_*x86*' directx_Jun2010_redist.exe

	for x in `ls xinput_x86/*.cab`
	do
	  cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F '*.dll' "$x"
	done
fi

# Registering Xinput
POL_SetupWindow_wait "$(eval_gettext 'Registering libraries, please wait\n(It can take a while)')" "$TITLE"
for x in `ls "$WINEPREFIX"/drive_c/windows/system32/xinput*`
do
 	POL_Wine --ignore-errors regsvr32 `basename $x`
    case $? in
      0|4) ;; # 4 = registration not required
      *) POL_Debug_Fatal "Error $? registering DLL $x"
    esac
done

# Overriding dll
POL_Call POL_Function_OverrideDLL "native" "xinput1_1" "xinput1_2" "xinput1_3" "xinput9_1_0"

# Cleaning
POL_Debug_Message "Deleting temporary directories"
rm -rf "$POL_USER_ROOT/ressources/xinput_x86"
if [ "$POL_ARCH" == "amd64" ]; then
	rm -rf "$POL_USER_ROOT/ressources/xinput_x64"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYKI7kwAKCRDlMfrJqhPK
R1SRAJ0S8jGaEEYBO0Wqou0+lFiviyP1vwCeK1MyV8Ql6/9XG871+78pUH9UEGY=
=mnSH
-----END PGP SIGNATURE-----
