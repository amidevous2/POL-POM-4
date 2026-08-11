# Allow for configurator extensions
shopt -s nullglob
for conf in "$0".*; do
    source "$conf"
done

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+uKLwACgkQ5TH6yaoTykffLgCgodCBmGN6kwQJ9FMngZXE4FOV
j70AoIqoClZPUy40epgD2SekgFVDJk78
=mn2m
-----END PGP SIGNATURE-----
