#!/bin/bash
#
# CHANGELOG
# [WitalijBukatkin] (2020-05-09)
#   Initial writting.
# [WitalijBukatkin] (2020-05-09)
#   Add phrases install.
# [WitalijBukatkin] (2020-05-10)
#   Add shortcut category.
#   Fix charset encoding.
#   Set vwine version 4.0.3

# Decoding russian characters eg:
# https://www.online-toolz.com/tools/text-unicode-entities-convertor.php

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Stamina"
PREFIX="Stamina"

function install_func {
	cd "$WINEPREFIX/drive_c"

	DOWNLOAD_URL_PREFIX="https://stamina.ru/files"

	POL_Download "$DOWNLOAD_URL_PREFIX/$1"
 
	POL_Wine_WaitBefore "$2"
	POL_Wine --ignore-errors "$1"
	POL_Wine_WaitExit "$2"
	
	rm "$2"
}

##################
#      INIT      #
##################

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$TITLE" "https://stamina.ru/keyboard_trainer" "WitalijBukatkin(t.me/wbkid)" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "4.0.4"

POL_Call POL_Install_mfc42

install_func "StaminaSetup.exe" "$PREFIX"

POL_Shortcut "Stamina.exe" "$TITLE" "" "" "Education;"

##################
#     PHRASES    #
##################

if [[ $LANG =~ "ru_RU" ]]; then
	TITLE_PHRASES_ADDONS=`echo -e $PREFIX' \u0424\u0440\u0430\u0437\u044B'`
    NAME_PHRASES_ADDONS=`echo -e '\u0412\u044B\u0431\u0435\u0440\u0438\u0442\u0435 \u0444\u0440\u0430\u0437\u044B \u0434\u043B\u044F \u0434\u0440\u0443\u0433\u0438\u0445 \u044F\u0437\u044B\u043A\u043E\u0432 \u0438\u043B\u0438 \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u0413\u043E\u0442\u043E\u0432\u043E'`
   	CONTINUE_PHRASES_ADDONS=`echo -e '\u0413\u043E\u0442\u043E\u0432\u043E'`
else
	TITLE_PHRASES_ADDONS="$PREFIX Phrases"
   	NAME_PHRASES_ADDONS="Select phrases for other languages or continue"
   	CONTINUE_PHRASES_ADDONS="Done"
fi

LIST_PHRASES_ADDONS="$CONTINUE_PHRASES_ADDONS|Bulgarian BG|Czech CZ|Danish DA|Dutch NL|English(censored) EN|Finnish FI|French FR|German DE|Italian IT|Lithuanian LT|Norwegian NO|Polish PL|Romanian RO|Slovak SK|Slovenian SI|Spanish SP|Swedish SE"

while [[ $APP_ANSWER != $CONTINUE_PHRASES_ADDONS ]]; do

	if [[ $APP_ANSWER != "" ]]; then
		FILE=Phrases_`echo "$APP_ANSWER" | sed -r 's/.+ //'`.exe
		
		install_func "$FILE" "$APP_ANSWER"
	fi
	
	POL_SetupWindow_menu "$NAME_PHRASES_ADDONS" "$TITLE_PHRASES_ADDONS" "$LIST_PHRASES_ADDONS" "|"
done

##################
#     HELP UA    #
##################

if [[ $LANG =~ "ua_UA" ]]; then
   	POL_SetupWindow_question "`echo -e '\u0425\u043E\u0442\u0438\u0442\u0435 \u0443\u0441\u0442\u0430\u043D\u043E\u0432\u0438\u0442\u044C\3A \u0424\u0430\u0439\u043B \u043F\u043E\u043C\u043E\u0449\u0438 \u0432\u0435\u0440\u0441\u0438\u0438 2.3 \u043D\u0430 \u0443\u043A\u0440\u0430\u0438\u043D\u0441\u043A\u043E\u043C \u044F\u0437\u044B\u043A\u0435 \28\u0437\u0430\u043C\u0435\u0449\u0430\u0435\u0442 \u0440\u0443\u0441\u0441\u043A\u0438\u0439 \u0445\u0435\u043B\u043F\29\3F'` `echo -e '\u0424\u0430\u0439\u043B \u043F\u043E\u043C\u043E\u0449\u0438'`"
   	
   	if [[ $APP_ANSWER == "TRUE" ]]; then
		install_func "Patch_UA.exe" "$APP_ANSWER"
   	fi
fi

##################
#       END      #
##################

if [[ $LANG =~ "ru_RU" ]]; then
	POL_SetupWindow_message "`echo -e '\u041F\u0440\u043E\u0433\u0440\u0430\u043C\u043C\u0430 \u0443\u0441\u043F\u0435\u0448\u043D\u043E \u0443\u0441\u0442\u0430\u043D\u043E\u0432\u043B\u0435\u043D\u0430. \u0412\u044B \u043C\u043E\u0436\u0435\u0442\u0435 \u0443\u0441\u0442\u0430\u043D\u043E\u0432\u0438\u0442\u044C \u0434\u043E\u043F\u043E\u043B\u043D\u0435\u043D\u0438\u044F \u0434\u043B\u044F \u043D\u0435\u0435 \u0441 \u043E\u0444\u0438\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0433\u043E \u0441\u0430\u0439\u0442\u0430: https://stamina.ru/keyboard_trainer/addons'`" "`echo -e '\u0417\u0430\u0432\u0435\u0440\u0448\u0435\u043D\u0438\u0435'`"
else
	POL_SetupWindow_message "The program has been successfully installed. You can install add-ons for her from the official site: https://stamina.ru/keyboard_trainer/addons" "Exiting"
fi

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXrnOUgAKCRDlMfrJqhPK
R7teAJ9FnAigHeO8cDFjZCZuAF4i46eC9wCeM9Kx8N1u5Z3MSL87fAolCJpVjB4=
=buuQ
-----END PGP SIGNATURE-----
