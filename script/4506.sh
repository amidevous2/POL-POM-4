#!/bin/bash
 
local GAME="$1"
# option: --altername 'basename' baseindex: get pieces starting from another index than 0
# options: --patch: patches | --bonus: bonus contents
# 2.. MD5: hash of the pieces
# Will download as many pieces as extra parameters
# Hashes are recommended for large downloads anyway
shift
 
local BASENAME="setup_$GAME"
local INDEX=0
if [ "$1" = "--alternate" ]; then
        BASENAME="$2"
        INDEX="$3"
        shift 3
fi
 
# URL = ${BASEURL}/${GAME}/${INDEXPREFIX}${INDEX}
local BASEURL="https://secure.gog.com/downlink"
local INDEXPREFIX="fr1installer"
if [ "$1" = "--patch" ]; then
        INDEXPREFIX="fr1patch"
        shift
elif [ "$1" = "--bonus" ]; then
        BASEURL="https://secure.gog.com/downlink/file"
        INDEXPREFIX=""
        shift
fi
 
local PIECES="$#"
 
local GOG_REPO="$(POL_Config_Read GOG_REPO)"
 
if [ -z "$GOG_REPO" ]; then
        POL_SetupWindow_textbox "$(eval_gettext 'In what directory do you want to download GOG files?')" "$TITLE" "$POL_USER_ROOT/tmp/"
        GOG_REPO="$APP_ANSWER"
        POL_Config_Write GOG_REPO "$GOG_REPO"
fi
 
 
local ALREADY_IN_SESSION="$GOG_LOGIN"
[ "$ALREADY_IN_SESSION" ] || POL_Call POL_GoG_login
 
# Download
[ -d "$GOG_REPO" ] || mkdir -p "$GOG_REPO"
cd "$GOG_REPO" || cd "$POL_USER_ROOT/tmp/"
POL_Debug_Message "Will download into $PWD"
 
download_piece ()
{
        # 1: URL
        # 2: filename
        # 3: MD5 hash
        # 4: Title
 
        # Failed piece from previous download, maybe reference MD5 was corrected?
        local FAILEDPIECE="$2.failed"
        if [ -n "$3" -a ! -e "$2" -a -e "$FAILEDPIECE" ]; then
                POL_SetupWindow_wait "$(eval_gettext 'Checking piece integrity...')" "$4"
                if [ "$(POL_MD5_file $FAILEDPIECE)" = "$3" ]; then
                        mv "$FAILEDPIECE" "$2"
                fi
        fi
 
        [ -e "$2" ] && return
 
        local TMPPIECE="$2.part"
        while true; do
                POL_System_wget "$1" "$4" --referer=https://www.gog.com/ --no-check-certificate --keep-session-cookies --load-cookies="$COOKIES_FINAL" --save-cookies="$COOKIES_FINAL" --continue -O "$TMPPIECE"
 
                POL_SetupWindow_wait "$(eval_gettext 'Checking piece integrity...')" "$4"
                if [ ! -e "$TMPPIECE" ]; then
                        GOGDMSG="$(eval_gettext 'Download failed')"
                elif [ -n "$3" ] && [ "$(POL_MD5_file $TMPPIECE)" != "$3" ]; then
                        GOGDMSG="$(eval_gettext 'Download seems to be corrupted')\n$(eval_gettext 'The file could also have been updated. If the problem persists, consider reporting the issue so that the script can be adjusted.')"
                        mv "$TMPPIECE" "$FAILEDPIECE"
                else
                        # Success
                        mv "$TMPPIECE" "$2"
                        [ -e "$FAILEDPIECE" ] && rm "$FAILEDPIECE"
                        break
                fi
 
                POL_SetupWindow_question "$GOGDMSG\n$(eval_gettext 'Retry?')" "$TITLE"
                [ "$APP_ANSWER" = "TRUE" ] || POL_Debug_Fatal "$GOGDMSG"
        done
}
 
download_piece "$BASEURL/$GAME/${INDEXPREFIX}$INDEX" "$BASENAME.exe" "$1" "$BASENAME (1/$PIECES)"
 
if [ $PIECES -gt 1 ]; then
        local n=2
        while [ $n -le $PIECES ]; do
                download_piece "$BASEURL/$GAME/${INDEXPREFIX}$((INDEX+n-1))" "$BASENAME-$((n-1)).bin" "${!n}" "$BASENAME ($n/$PIECES)"
                let n=$((n+1))
        done
fi
 
# If we were already in session, it's caller responsability to close it
[ "$ALREADY_IN_SESSION" ] || POL_Call POL_GoG_logout
 
POL_GoG_downloaded="True"
POL_GoG_location="$PWD/$BASENAME.exe"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCY+rKTQAKCRDlMfrJqhPK
R4mTAKCQICAyfhzArTtv9g4btv5s6v1EJgCfQTDfC4Mp89jw+EoNHqhtZRA/kHg=
=u4Z0
-----END PGP SIGNATURE-----
