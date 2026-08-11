#!/usr/bin/env playonlinux-bash

# CHANGELOG
# [Ground0] (2016-02-17 09:45)
#   Initial Version
#
# Date : (2016-02-17 09:45)
# Last revision : (2016-02-17 09:45)
# Distribution used to test : OpenSUSE Tumbleweed / openSUSE Leap 42.1 / OS X 10.11.2
# Author : René Linder rene.linder@lihaso.ch
# Script licence : GPL v.2
# Depend :

#############################################
#
# Logout / open session for using
#
#
# The Cookies:
#

local COOKIES_FINAL="$POL_USER_ROOT/tmp/gog_cookie_logedin"

local USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36"

##########################
#
# Logout
# 

$POL_WGET https://www.gog.com/logout -O- --keep-session-cookies --save-cookies=$COOKIES_FINAL --load-cookies=$COOKIES_FINAL --referer=https://www.gog.com/ --user-agent="$USER_AGENT"
rm "$COOKIES_FINAL"
unset GOG_LOGIN

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbExMkACgkQ5TH6yaoTykeUXwCgqu7oCaxTZMkn40AiJZYPdSXP
KToAn0i9ga4DxphMgTz1KlCF6RaqQHlS
=4yY2
-----END PGP SIGNATURE-----
