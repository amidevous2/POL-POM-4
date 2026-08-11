#!/bin/bash
# Date : (2012-06-20 16-57)
# Last revision : (2013-05-15 20-35)
# Distribution used to test :
# Author: Fekir

# CHANGELOG
# [SuperPlumus] (2013-05-15 20-35)
#   Clean script
# [gang65] (2016-02-02 02-02)
#   Viewer is opening more files with Wine 1.6

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Word Viewer 2003"
PREFIX="WordViewer2003"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'This Procedure will install Microsoft Office $TITLE, a free program that will let you view .doc and .docx documents, but you will not be able to edit them. This program is intended for users that are not able to display complex doc or docx documents. If you want to edit a document, use LibreOffice, OpenOffice or some other editor. ')"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine_InstallFonts

POL_System_TmpCreate "$PREFIX"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    APP_ANSWER="wordview_en-us.exe"
    cd "$POL_System_TmpDir"
    POL_Download "http://download.microsoft.com/download/6/a/6/6a689355-b155-4fa7-ad8a-dfe150fe7ac6/wordview_en-us.exe" "ef59dc6b88eab99362b3ba4982f1a4cb"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$APP_ANSWER"

POL_System_TmpDelete

POL_Wine_reboot

POL_Shortcut "WORDVIEW.EXE" "$TITLE"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOveXQAKCRDlMfrJqhPK
Rwr3AKCNee29aDCdVEhCpwwDQ21k3aW/sQCfedp+BX7/YNsfOy1a+OYKNUpO6mw=
=32xJ
-----END PGP SIGNATURE-----
