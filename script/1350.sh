# DoS workaround, block 4.1.4 and 4.1.5 here
[ "$VERSION" = "4.1.4" -o "$VERSION" = "4.1.5" ] && POL_RequiredVersion 4.1.6

local file="$1"
local file_shorted="${file%?}_"

if [ "$POL_LANG" = "fr" ]; then
	src="http://download.windowsupdate.com/msdownload/update/software/svpk/2008/04/windowsxp-kb936929-sp3-x86-fra_414B61BBC86E09579D8447BAA23EB1B867F9CA93.exe" 
    sparchiveold="WindowsXP-KB936929-SP3-x86-FRA.exe"
    sparchive="windowsxp-kb936929-sp3-x86-fra_414B61BBC86E09579D8447BAA23EB1B867F9CA93.exe"
	md5="a9a9a86e7330bffaf64ae2acfb73d959"
elif [ "$POL_LANG" = "de" ]; then
    src="http://download.windowsupdate.com/msdownload/update/software/svpk/2008/04/windowsxp-kb936929-sp3-x86-deu_f2dcd2211384a78df215c696a7fd1a7949dc794b.exe"
    sparchiveold="WindowsXP-KB936929-SP3-x86-DEU.exe"
    sparchive="windowsxp-kb936929-sp3-x86-deu_f2dcd2211384a78df215c696a7fd1a7949dc794b.exe"
    md5="265246926aa44bd767b0c11f80c084f1"
else
	src="http://download.windowsupdate.com/msdownload/update/software/svpk/2008/04/windowsxp-kb936929-sp3-x86-enu_c81472f7eeea2eca421e116cd4c03e2300ebfde4.exe"
    sparchiveold="WindowsXP-KB936929-SP3-x86-ENU.exe"
    sparchive="windowsxp-kb936929-sp3-x86-enu_c81472f7eeea2eca421e116cd4c03e2300ebfde4.exe"
	md5="bb25707c919dd835a9d9706b5725af58"
fi

cd "$POL_USER_ROOT/ressources/" || POL_Debug_Fatal "Unable to change directory"
[ -e "$sparchiveold" -a ! -e "$sparchive" ] && ln -s "$sparchiveold" "$sparchive"

POL_Download_Resource "$src" "$md5"

if [ ! "$1" = "--only-download" ]; then
	cd "$POL_USER_ROOT/tmp/" || POL_Debug_Fatal "Unable to change directory"
	POL_Wine_WaitBefore "$TITLE"
        POL_Debug_Message "Extract i386/$file_shorted from $sparchive"
	cabextract "$POL_USER_ROOT/ressources/$sparchive" -F i386/$file_shorted
        POL_Debug_Message "Extract $file from i386/$file_shorted"
	cabextract i386/$file_shorted
	POL_Debug_Message "Move $file to $OLD_PC_DIR"
	mv "$file" "$OLD_PC_DIR"
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAla0pQ4ACgkQ5TH6yaoTykeQkACcDKF4yfl3AkasO5povx73Qjb+
i6IAn2nQaj1aSmm2MwFkugy/N/veBn2F
=zls3
-----END PGP SIGNATURE-----
