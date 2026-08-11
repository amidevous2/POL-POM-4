POL_Call POL_Install_vcrun6

POL_Download_Resource "http://download.microsoft.com/download/b/c/3/bc3a0c36-fada-497d-a3de-8b0139766f3b/Windows2000-KB917344-56-x86-enu.exe" "7772ece0914aae341b9e031813af604d"

POL_Wine_WaitBefore "Windows Scripting Host 56" 
POL_Wine "$POL_USER_ROOT/ressources/WindowsXP-Windows2000-Script56-KB917344-56-x86-enu.exe" /q
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAiqRAACgkQ5TH6yaoTyke+HwCfeWBa3NVI2yQ0Qn1mgLXit/d4
LV4AoKhAN4eyCpwNIAwPrsc9e2FTKV6l
=MGUN
-----END PGP SIGNATURE-----
