if [ ! -e "$POL_USER_ROOT/configurations/msfonts_installed" ]; then
    POL_SetupWindow_message "$(eval_gettext "Microsoft fonts aren't installed; I'll install them for you.")" "$(eval_gettext 'Microsoft fonts')"

    echo -e "---$(eval_gettext " Licence translated into your language ")---
    $(eval_gettext "These fonts were provided by Microsoft\n\"in the interest of cross-platform compatibility\".")
    $(eval_gettext "This is no longer the case, but they are still available from third parties.")

    $(eval_gettext "You are free to download these fonts and use them for your own use,\nbut you may not redistribute them in modified form,\nincluding changes to the file name or packaging format.")\n" > "$POL_USER_ROOT/tmp/licence"

    echo "---$(eval_gettext " Original licence ")---
    These fonts were provided by Microsoft \"in the interest of
    cross-platform compatibility\".
    This is no longer the case, but they are still available from
    third parties.

    You are free to download these fonts and use them for your own use,
    but you may not redistribute them in modified form, including changes
    to the file name or packaging format." >> "$POL_USER_ROOT/tmp/licence"
    cat "$POL_USER_ROOT/tmp/licence"

    POL_SetupWindow_licence "$(eval_gettext 'Please read and accept the following:')" "$(eval_gettext 'Microsoft fonts')" "$POL_USER_ROOT/tmp/licence"

    rm -r "$POL_USER_ROOT/fonts/" 2> /dev/null
    rm "$POL_USER_ROOT/fonts" 2> /dev/null
    rm "$POL_USER_ROOT/configurations/fonts_installed" 2> /dev/null
    FONTDIR="$POL_USER_ROOT/fonts/"
    mkdir -p "$FONTDIR"
    FONTS_INSTALLER="andale32.exe arialb32.exe arial32.exe comic32.exe courie32.exe georgi32.exe impact32.exe times32.exe trebuc32.exe verdan32.exe webdin32.exe"
    cd "$FONTDIR"
    PULSE=0

    POL_SetupWindow_pulsebar "$(eval_gettext 'Downloading fonts')" "$(eval_gettext 'Microsoft fonts')"
    POL_SetupWindow_pulse 0

    for font in $FONTS_INSTALLER
    do
            sleep 0.1
            POL_SetupWindow_set_text "$(eval_gettext 'Downloading: ')$font..."
            echo "$(eval_gettext 'Downloading: ')$font..."
            #$POL_WGET "http://heanet.dl.sourceforge.net/sourceforge/corefonts/$font" || return 1
            # BTW all downloaded file has 'download' as name!
            $POL_WGET "https://netix.dl.sourceforge.net/project/corefonts/the%20fonts/final/$font" || return 1
            # Fix bad file name
            mv "./download" "./$font"
            PULSE=$(( PULSE + 4 ))
            POL_SetupWindow_pulse $PULSE
            sleep 0.1
    done
     
    echo "$(eval_gettext 'Downloading: ')TAHOMA32.EXE"
    POL_SetupWindow_set_text "$(eval_gettext 'Downloading: ')TAHOMA32.EXE"
    # ccd250dd30247d68e0f8a14adf797262
    # $POL_WGET ftp://ftp.microsoft.com/softlib/MSLFILES/TAHOMA32.EXE || return 1
    # $POL_WGET http://residence-eon.tuxfamily.org/Wine/tahoma32.exe || return 1
    # $POL_WGET http://download.microsoft.com/download/office97pro/fonts/1/w95/en-us/tahoma32.exe || return 1
    # $POL_WGET ftp://ftp.uevora.pt/pub/windows/Microsoft/Euro/Euro-Compatible%20Tahoma%20Font/tahoma32.exe || return 1
    $POL_WGET https://archive.org/download/ftp.microsoft.com/ftp.microsoft.com.zip/ftp.microsoft.com/Softlib/MSLFILES/TAHOMA32.EXE || return 1
    POL_SetupWindow_pulse 50
    sleep 1
     
    POL_SetupWindow_pulsebar "$(eval_gettext 'Installing fonts')" "$(eval_gettext 'Microsoft fonts')"
    for font in $FONTS_INSTALLER
    do
            sleep 0.1
            POL_SetupWindow_set_text "$(eval_gettext 'Installing: ')$font..."
            echo "$(eval_gettext 'Installing: ')$font..."
            cabextract "$font" > /dev/null
            PULSE=$(( PULSE + 4 ))
            POL_SetupWindow_pulse $PULSE
            sleep 0.1
    done
     
    POL_SetupWindow_set_text "$(eval_gettext 'Installing: ')TAHOMA32.EXE"
    echo "$(eval_gettext 'Installing: ')TAHOMA32.EXE"
    cabextract TAHOMA32.EXE > /dev/null
    # cabextract tahoma32.exe > /dev/null
    POL_SetupWindow_pulse 100
    sleep 1
     
    POL_SetupWindow_set_text "$(eval_gettext 'Cleaning')"
     
    rm "$FONTDIR"/*.{exe,EXE,done,dll,DLL,inf,txt,TXT} &> /dev/null
     
    sleep 0.5
    touch "$POL_USER_ROOT/configurations/msfonts_installed"
    #POL_SetupWindow_message "$(eval_gettext 'Microsoft fonts have been installed successfully.')" "$(eval_gettext 'Microsoft fonts')"
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZJNsUwAKCRDlMfrJqhPK
R7AVAJsGbuNykDx9DGvs7oZ0RkggVlNbMQCfbkxdLWu+USIb5lfP1/av/01QRJc=
=Fof9
-----END PGP SIGNATURE-----
