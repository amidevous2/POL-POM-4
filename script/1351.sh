POL_Download_Resource "http://files.playonlinux.com/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" "0c0f6e300800e49472e9b2e0890a09c1"

cd "$WINEPREFIX/drive_c/windows/system32"
POL_Debug_Message "Installing pngfilt.dll"

rm "pngfilt.dll"

cabextract "$POL_USER_ROOT/ressources/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" -L -F pngfilt.dll

POL_Wine regsvr32 "pngfilt.dll"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAldDV+IACgkQ5TH6yaoTykdNkgCgn/1ynFFKKOs4pnYgOj194mfw
Q3sAn0nqN0DRy5kDOvLRJ8bJsWPm1cAn
=lzyZ
-----END PGP SIGNATURE-----
