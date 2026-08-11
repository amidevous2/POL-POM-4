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

iEYEABECAAYFAlA4pL4ACgkQ5TH6yaoTykdZqwCfSUvfiqbLgracrgd1GfLISZpt
zhsAnR5HUKz0W2Wa7r1QjlGN5DVKkCBH
=thQG
-----END PGP SIGNATURE-----
