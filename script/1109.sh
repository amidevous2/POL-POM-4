cat << EOF > "$POL_USER_ROOT/tmp/disable_crash.reg"
[HKEY_CURRENT_USER\\Software\\Wine\\WineDbg]
"ShowCrashDialog"=dword:00000000
EOF
POL_SetupWindow_Wait "$(eval_gettext 'Please wait...')" "$TITLE"
POL_Wine regedit "$POL_USER_ROOT/tmp/disable_crash.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk94SV0ACgkQ5TH6yaoTykdlVgCbBE6j6NC20f2j4oC1+lfk0vnJ
pGgAn2uT6O/7GEjLY61nDirjT9o9U1Iy
=mxPm
-----END PGP SIGNATURE-----
