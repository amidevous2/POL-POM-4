#!/bin/bash
# Last revision : (2021-05-21 13:19 MEZ)
# Inspired by Winetricks d3dcompiler_46 https://github.com/Winetricks/winetricks
# Script licence : https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt

POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing d3dcompiler_46 dlls...')" "$TITLE"

cd "$POL_USER_ROOT/ressources/d3dcompiler_46" "d3dcompiler_46"
POL_Download_Resource "http://download.microsoft.com/download/F/1/3/F1300C9C-A120-4341-90DF-8A52509B23AC/standalonesdk/Installers/2630bae9681db6a9f6722366f47d055c.cab" "9cc65b7e3aeebed781354b3a5399ece0" "d3dcompiler_46"; # 32-bit

if [ "$POL_ARCH" = "amd64" ]; then
    POL_Download_Resource "http://download.microsoft.com/download/F/1/3/F1300C9C-A120-4341-90DF-8A52509B23AC/standalonesdk/Installers/61d57a7a82309cd161a854a6f4619e52.cab" "9b92033822629a13ea60d5b4459faa5c" "d3dcompiler_46"; # 64-bit

    # 32-bit
    cabextract -F 'fil47ed91e900f4b9d9659b66a211b57c39' $POL_USER_ROOT/ressources/d3dcompiler_46/2630bae9681db6a9f6722366f47d055c.cab -d $POL_USER_ROOT/tmp
    cp -f $POL_USER_ROOT/tmp/fil47ed91e900f4b9d9659b66a211b57c39 $WINEPREFIX/drive_c/windows/syswow64/d3dcompiler_46.dll

    # 64-bit
    cabextract -F 'fil8c20206095817436f8df4a711faee5b7' $POL_USER_ROOT/ressources/d3dcompiler_46/61d57a7a82309cd161a854a6f4619e52.cab -d $POL_USER_ROOT/tmp
    cp -f $POL_USER_ROOT/tmp/fil8c20206095817436f8df4a711faee5b7 $WINEPREFIX/drive_c/windows/system32/d3dcompiler_46.dll

else
    # 32-bit
    cabextract -F 'fil47ed91e900f4b9d9659b66a211b57c39' $POL_USER_ROOT/ressources/d3dcompiler_46/2630bae9681db6a9f6722366f47d055c.cab -d $POL_USER_ROOT/tmp
    cp -f $POL_USER_ROOT/tmp/fil47ed91e900f4b9d9659b66a211b57c39 $WINEPREFIX/drive_c/windows/system32/d3dcompiler_46.dll
fi

# Overriding dlls
POL_Debug_Message "Overriding d3dcompiler_46 dll"
POL_Wine_OverrideDLL "native, builtin" "d3dcompiler_46"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYKjokgAKCRDlMfrJqhPK
R2UsAJ9GojJ4/HpY01LClRDPpcR+WTX3YgCgsYYSwkmkq4tg/YdjqhGDbRDn+hc=
=WN/T
-----END PGP SIGNATURE-----
