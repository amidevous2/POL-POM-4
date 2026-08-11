POL_SetupWindow_wait_next_signal "$(eval_gettext 'Please wait...')" "$TITLE"
cat << EOF > "$REPERTOIRE/tmp/fontsaa.reg"
REGEDIT4
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingType"=dword:00000002
"FontSmoothingGamma"=dword:00000578
"FontSmoothingOrientation"=dword:00000001
EOF
POL_Wine regedit "$REPERTOIRE/tmp/fontsaa.reg"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5cxdEACgkQ5TH6yaoTykcBfwCgss0q/ISBlgb4nmhMEMuPXy0N
9yAAn0OM3dctyvETF/U3v2E9VSBe45cB
=VRBl
-----END PGP SIGNATURE-----
