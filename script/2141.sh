#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Diagnostic Tools"

# Starting the script
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_free_presentation "$TITLE" "This tool will run diagnostics on your computer and send them on your PlayOnLinux.com profile."
 
cd "$POL_USER_ROOT/tmp"

POL_Download "$SITE/divers/check_dd_amd64.bz2"
POL_Download "$SITE/divers/check_dd_x86.bz2"

POL_SetupWindow_wait "$(eval_gettext "Scanning your hardware...")" "$TITLE"

POL_LoadVar_Distro
POL_LoadVar_ScreenResolution

export r_OS="$POL_OS"
export r_DISTRO="$DISTRO"
export r_SCREEN="${ScreenWidth}x${ScreenHeight}"
export r_VIDEO="$(POL_DetectVideoCards)"
export r_ARCH="$POL_ARCH"
export r_DR64="NA"
export r_DR32="NA"
export r_LANG="$POL_LANG"

if [ "$POL_OS" = "Linux" ]; then

    if [ "$POL_ARCH" = "amd64" ]; then
        bunzip2 check_dd_amd64.bz2
        chmod +x check_dd_amd64
        ./check_dd_amd64
        
        [ "$?" = "0" ] && export r_DR64="TRUE" || export r_DR64="FALSE"
    fi
    
    bunzip2 check_dd_x86.bz2
    chmod +x check_dd_x86
    ./check_dd_x86
    
    [ "$?" = "0" ] && export r_DR32="TRUE" || export r_DR32="FALSE"
fi

POL_Website_login 
POL_Website_Init

data="$(export | grep '^declare -x r_')"
data="${data//declare -x /}"
data="$(printf "$data" | POL_base64)"
POL_Website_GET "http://www.playonlinux.com/api/updateInfos.php?info=$(POL_Website_urlencode "$data")"

POL_Website_Close

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO5n2QACgkQ5TH6yaoTykdJSgCgg+N64RelPrP+E06tTAWES4m4
dikAn27ENOxwW65+r8Lj4aNJY/RUHujI
=59HB
-----END PGP SIGNATURE-----
