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
# Login / open session for using
#
#
# The Cookies:
#

local COOKIES="$POL_USER_ROOT/tmp/gog_cookies"
local COOKIES_2="$POL_USER_ROOT/tmp/gog_cookies2"
local COOKIES_3="$POL_USER_ROOT/tmp/gog_cookies3"
local COOKIES_4="$POL_USER_ROOT/tmp/gog_cookies4"
COOKIES_FINAL="$POL_USER_ROOT/tmp/gog_cookie_logedin"

local USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36"

local APP_ANSWER

while true; do
	POL_SetupWindow_login "$(eval_gettext 'Please enter your gog.com login to download $BASENAME')" "$TITLE" "http://www.gog.com/"

	POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
	
    ##########################
    #
    # Cleanup existing cookies:
    # 
	
	rm "$COOKIES" 2> /dev/null
	rm "$COOKIES_2" 2> /dev/null
	rm "$COOKIES_3" 2> /dev/null
	rm "$COOKIES_4" 2> /dev/null
	rm "$COOKIES_FINAL" 2> /dev/null
	
	##########################
	#
	# Get the Login Link:
	#
	
	local login_link="$($POL_WGET https://www.gog.com -O- --keep-session-cookies --save-cookies=$COOKIES --user-agent="$USER_AGENT" | sed -ne "s@.*'\(https://auth.gog.com/[^']*\)'.*@\1@p")"
    
    POL_Debug_Message "Login Link: $login_link"
    
    ##########################
    #
    # Get the initial Cookie
    #
    
    $POL_WGET https://www.gog.com/userData.json -O- --keep-session-cookies --save-cookies=$COOKIES_2 --load-cookies=$COOKIES --referer=https://www.gog.com/ --user-agent="$USER_AGENT" 
    
    ##########################
    #
    # Get the Login session token
    
	local token="$($POL_WGET "$login_link" -O- --keep-session-cookies --save-cookies=$COOKIES_3 --load-cookies=$COOKIES_2 --referer=https://www.gog.com/ --user-agent="$USER_AGENT" | sed -ne 's@.*<input type="hidden" id="login__token" name="login\[_token\]" value="\([^"]*\)" />.*@\1@p')"

    POL_Debug_Message "token: $token"
	
	##########################
	#
	# Main Login part:
	#
	# RegEx to get the token : <input type="hidden" id="login__token" name="login\[_token\]" value="(.*?)" \/>
	# 

	$POL_WGET https://login.gog.com/login_check -O- --keep-session-cookies --save-cookies=$COOKIES_4 --load-cookies=$COOKIES_3 --post-data="login%5Busername%5D=$(POL_Website_urlencode "$POL_LOGIN")&login%5Bpassword%5D=$(POL_Website_urlencode "$POL_PASSWORD")&login%5Blogin%5D=&login%5B_token%5D=$token" --no-check-certificate  --referer=$login_link --user-agent="$USER_AGENT"
	
	POL_Debug_Message "info: $outputget"

	##########################
	#
	# Clear Login informations from vars.
	
	unset POL_LOGIN POL_PASSWORD

	##########################
	#
	# Generate the final Cookie
	# To get it call again : https://www.gog.com/userData.json

	$POL_WGET https://www.gog.com/userData.json -O- --keep-session-cookies --save-cookies=$COOKIES_FINAL --load-cookies=$COOKIES_4 --referer=https://www.gog.com/ --user-agent="$USER_AGENT"

	##########################
	#
	# Test if the Cookie has the gog_us session code inside.
	#
	local AUTH_SESSION="$(awk '$6 == "gog_us" { print $7 }' $COOKIES_FINAL)"
	[ "$AUTH_SESSION" ] && GOG_LOGIN="Ok" && POL_Debug_Message "AUTH SESSION: $AUTH_SESSION" && break
	
	unset AUTH_SESSION

	POL_SetupWindow_question "$(eval_gettext 'Gog.com login failed, try again?')" "$TITLE"
	if [ "$APP_ANSWER" = "FALSE" ]; then
		POL_SetupWindow_Close
		exit 1
	fi
done

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbExWsACgkQ5TH6yaoTykd1cwCeI6xbJXkROTWe5Z/y2W5OIgup
B+4AoJ9hXXmoWUqjGlF2s41oh5lwPyyl
=r15S
-----END PGP SIGNATURE-----
