#!/usr/bin/env playonlinux-bash
 
# CHANGELOG
# [Ground0] (2016-02-18 08:15)
#   Initial Version
#
# Date : (2016-02-18 08:15)
# Last revision : (2016-02-18 08:15)
# Distribution used to test : OpenSUSE Tumbleweed / openSUSE Leap 42.1 / OS X 10.11.2
# Author : René Linder rene.linder@lihaso.ch
# Script licence : GPL v.2
# Depend :
 
#############################################
#
# Login Check function
#
# The Cookie:
#
 
COOKIES_FINAL="$POL_USER_ROOT/tmp/gog_cookie_logedin"
 
#
# Check if the session Cookie is exsist.
#
 
[ ! -f "$COOKIES_FINAL" ] && unset GOG_LOGIN && POL_Debug_Message "No GOG Cookie exists" && break
fi
 
#
# Check if the session Cookie is valid.
#
# Call  to https://www.gog.com/userData.json to recheck the cookie
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36"
 
$POL_WGET https://www.gog.com/userData.json -O- --keep-session-cookies --save-cookies=$COOKIES_FINAL --load-cookies=$COOKIES_FINAL --referer=https://www.gog.com/ --user-agent="$USER_AGENT"
 
#
# If the Session is still valid gog-al still exists else where it is now removed.
#
 
AUTH_SESSION="$(awk '$6 == "gog-al" { print $7 }' $COOKIES_FINAL)"
[ "$AUTH_SESSION" != "" ] && GOG_LOGIN="Ok" && POL_Debug_Message "GoG Session cookie exists and is valid" && break
 
POL_Debug_Message "GoG Session cookie exists but is not valid"
unset GOG_LOGIN
break
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbF84gACgkQ5TH6yaoTykfBIgCdF8wwD7MJxjGRiTR/lcGxrEJA
mdQAn37Out3kXQvkxRL/4mc4WUOux74/
=8W0a
-----END PGP SIGNATURE-----
