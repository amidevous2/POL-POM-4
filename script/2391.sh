# Date : (2015-01-9 12-30)
# Distribution used to test : Kubuntu 14.04 - 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.5

POL_Debug_Message "Installing tahoma32..."

POL_Download_Resource "http://residence-eon.tuxfamily.org/Wine/tahoma32.exe" "ccd250dd30247d68e0f8a14adf797262" "tahoma32"
mkdir $POL_USER_ROOT/tmp/tahoma32
cd $POL_USER_ROOT/tmp/tahoma32
cp $POL_USER_ROOT/ressources/tahoma32/tahoma32.exe $POL_USER_ROOT/tmp/tahoma32/

POL_System_cabextract "$POL_USER_ROOT/tmp/tahoma32/tahoma32.exe"
cp $POL_USER_ROOT/tmp/tahoma32/Tahoma.TTF $WINEPREFIX/drive_c/windows/Fonts/tahoma.ttf
cp $POL_USER_ROOT/tmp/tahoma32/Tahomabd.TTF $WINEPREFIX/drive_c/windows/Fonts/tahomabd.ttf

POL_Debug_Message "Registering font..."

echo "REGEDIT4

[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Fonts]
\"Tahoma\"=\"tahoma.ttf\"
\"Tahoma Bold\"=\"tahomabd.ttf\"

[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Fonts]
\"Tahoma\"=\"tahoma.ttf\"
\"Tahoma Bold\"=\"tahomabd.ttf\"" > $POL_USER_ROOT/tmp/tahoma32/register.reg

POL_Wine regedit register.reg

sleep 5

chmod +w $WINEPREFIX/drive_c/windows/Fonts/tahoma*.ttf

POL_Debug_Message "Cleaning up tmp folder..."
rm -rf $POL_USER_ROOT/tmp/tahoma32
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAld4rWMACgkQ5TH6yaoTykfIagCfVJif0ZBAgPov9e5/exjGL54g
eocAn2ydX+wJil32AgJ46sNJtHmRAqyk
=Zoh6
-----END PGP SIGNATURE-----
