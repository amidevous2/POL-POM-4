#!/bin/bash
# Date : (2012-06-20 16-58)
# Last revision : see changelog
# Distribution used to test :
# Author: Fekir
# Wine version used: 1.4
 
# CHANGELOG
# [SuperPlumus] (2013-05-15 20-18)
#   Clean script
# [Dadu042] (2019-11-03)
#   Wine 1.4 -> 2.22
#   POL_RequiredVersion "4.0.0"


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Microsoft Excel Viewer"
PREFIX="ExcelViewer"
WORKING_WINE_VERSION="2.22"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'This procedure will install $TITLE, a free program that will let you view .doc and .docx documents, but you will not be able to edit them. This program is intended for users that are not able to display complex doc or docx documents.\nIf you want to edit a document, use LibreOffice, OpenOffice or some other editor. ')"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

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
    APP_ANSWER="ExcelViewer.exe"
    
    cd "$HOME"
    cd "$POL_System_TmpDir"
    
    # Dead URL as of 2019-11
    # POL_Download "http://download.microsoft.com/download/e/a/9/ea913c8b-51a7-41b7-8697-9f0d0a7274aa/ExcelViewer.exe" "cb4f2202fc368af9476effed5cc7b8a4"

    # Attempts to download from Softpedia:
    # NOK POL_Call POL_Softpedia_Download "https://www.softpedia.com/dyn-postdownload.php/69fb2465ace5f7b443819a21d8608321/5dbeb935/fefe/0/1" ""
    # NOK POL_Call POL_Softpedia_Download "https://softpedia-secure-download.com/dl/bfa0297e19783730e2c05bd499505961/5dbeadef/100065278/software/office/MS-ExcelViewer.exe" "cb4f2202fc368af9476effed5cc7b8a4"    
    POL_Call POL_Softpedia_Download "5dbeadef" "cb4f2202fc368af9476effed5cc7b8a4"
    
fi
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$APP_ANSWER"
 
POL_System_TmpDelete
 
POL_Shortcut "XLVIEW.EXE" "$TITLE"
 
POL_Wine_reboot
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb6ymgAKCRDlMfrJqhPK
Rw0yAJ94nKmXo3q+XQrzA5cyNUa4gl2dsACggximosnT/SCyPQ/bULjCgmPZGYU=
=6mII
-----END PGP SIGNATURE-----
