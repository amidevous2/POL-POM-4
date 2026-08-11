if [ "$POL_OS" = "Mac" ]; then
    mkdir -p "$POL_USER_ROOT/tools/samba3/bin/"
    mkdir -p "$POL_USER_ROOT/tools/samba3/lib/"
    
    cd "$POL_USER_ROOT/tmp"
    POL_Download_Resource "$SITE/divers/samba3.tar.bz2" "0dbc91240825a13d3ff6b87302f05fc8"
    
    POL_SetupWindow_wait "$(eval_gettext 'Please wait...')"

    cd "$POL_USER_ROOT/tools/"
    tar -xvf "$POL_USER_ROOT/ressources/samba3.tar.bz2"

    
    cat << EOF > "$POL_USER_ROOT/tools/samba3/init"
export PATH="$POL_USER_ROOT/tools/samba3/bin/:\$PATH"
export DYLD_LIBRARY_PATH="$POL_USER_ROOT/tools/samba3/lib/:\$DYLD_LIBRARY_PATH"
EOF
    
    source "$POL_USER_ROOT/tools/samba3/init"
else
    # Check for Samba
    wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi  
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPTxUEACgkQ5TH6yaoTykebbACgkMQUEiZWG7m5ozmsffzELpAH
a+sAoKTKiILmg1O7qTnmyuR5pNq34+CI
=SNGV
-----END PGP SIGNATURE-----
