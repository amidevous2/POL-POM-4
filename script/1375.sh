cd "$OLD_PC_DIR"
if [ "$1" = "--resource" ]; then
	resource="true"
	shift
fi

url="$(wget -q -O- "$1" | grep 'click here' | cut -d'"' -f4)"

if [ "$resource" = "true" ]; then
	POL_Download_Resource "$url" "$2"
else
	POL_Download "$url" "$2"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlA4BCkACgkQ5TH6yaoTykdidQCeI/oxambJijqrjhPISZSwBXoF
R+sAoIMLrHDtNjeQrKUaVyTbSCPVQiFD
=vRU6
-----END PGP SIGNATURE-----
