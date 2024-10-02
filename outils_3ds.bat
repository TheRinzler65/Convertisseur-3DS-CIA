@echo off
chcp 65001 >nul
goto banner

:banner
:menu
echo.
echo.
echo           ██████╗ ██╗   ██╗████████╗██╗██╗     ███████╗    ██████╗ ██████╗ ███████╗    
echo          ██╔═══██╗██║   ██║╚══██╔══╝██║██║     ██╔════╝    ╚════██╗██╔══██╗██╔════╝    
echo          ██║   ██║██║   ██║   ██║   ██║██║     ███████╗     █████╔╝██║  ██║███████╗    
echo          ██║   ██║██║   ██║   ██║   ██║██║     ╚════██║     ╚═══██╗██║  ██║╚════██║    
echo          ╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║    ██████╔╝██████╔╝███████║    
echo           ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═════╝ ╚══════╝                 
echo.
echo.

echo Menu Outils 3DS :
echo -----------------
echo 1. Convertisseur .3ds / .cia
echo 2. Convertisseur .cia / .3ds (à venir)
echo 3. Rejoindre notre serveur Discord
echo 4. Quitter
echo.

set /p choix="Choisissez une option : "

if "%choix%"=="1" goto convertisseur_3ds_cia.py
if "%choix%"=="2" goto cia-to-3ds
if "%choix%"=="3" goto discord
if "%choix%"=="4" goto quitter
goto menu

:convertisseur_3ds_cia.py
python convertisseur_3ds_cia.py
cls
goto menu

:cia-to-3ds
@ECHO OFF
cd %~dp0

:: Détermine l'architecture du système (64 bits ou 32 bits)
IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
    SET makerom_path=tools\win64\makerom.exe
) ELSE (
    SET makerom_path=tools\win32\makerom.exe
)

:: Vérifie si makerom.exe existe dans le chemin déterminé
IF NOT EXIST "%makerom_path%" (
    ECHO makerom.exe introuvable dans tools\win64 ou tools\win32.
    EXIT /B 1
)

:: Crée le dossier .3ds s'il n'existe pas
IF NOT EXIST ".3ds" (
    mkdir .3ds
)

:: Boucle pour traiter tous les fichiers .cia dans la racine du projet
FOR %%F IN (*.cia) DO (
    ECHO Conversion de %%F...
    "%makerom_path%" -ciatocci "%%F"
    ren "%%~dpnF.cci" "%%~nF.3ds"
    move "%%~nF.3ds" ".3ds\"
    ECHO %%F converti et déplacé dans .3ds
)

ECHO Conversion terminée. Tous les fichiers .cia ont été convertis et déplacés dans le dossier '.3ds'
cls
goto menu

:discord

pause
cls
goto menu

:quitter
echo Au revoir !
pause
exit