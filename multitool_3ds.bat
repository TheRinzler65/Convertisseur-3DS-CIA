@echo off
chcp 65001 >nul
goto banner

:banner
:menu
echo.
echo.
echo            ███╗   ███╗██╗   ██╗██╗  ████████╗██╗████████╗ ██████╗  ██████╗ ██╗         ██████╗ ██████╗ ███████╗
echo            ████╗ ████║██║   ██║██║  ╚══██╔══╝██║╚══██╔══╝██╔═══██╗██╔═══██╗██║         ╚════██╗██╔══██╗██╔════╝
echo            ██╔████╔██║██║   ██║██║     ██║   ██║   ██║   ██║   ██║██║   ██║██║          █████╔╝██║  ██║███████╗
echo            ██║╚██╔╝██║██║   ██║██║     ██║   ██║   ██║   ██║   ██║██║   ██║██║          ╚═══██╗██║  ██║╚════██║
echo            ██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║   ██║   ╚██████╔╝╚██████╔╝███████╗    ██████╔╝██████╔╝███████║            
echo.
echo.
echo.
echo                                                   Menu Principal:
echo                                                  -----------------
echo.
echo.
echo                                            1. Convertisseur .3ds / .cia
COLOR 0A
echo.
echo                                            2. Convertisseur .cia / .3ds
echo.
echo                                            3. Decrypteur / Déchiffrement .3ds
echo.
echo                                            4. Rejoindre notre serveur Discord
echo.
echo                                            5. Quitter
echo.

set /p choix="Choisissez une option : "

if "%choix%"=="1" goto convertisseur_3ds_cia
if "%choix%"=="2" goto convertisseur_cia_3ds
if "%choix%"=="3" goto decrypt_3ds
if "%choix%"=="4" goto discord
if "%choix%"=="5" goto quitter
goto menu

:convertisseur_3ds_cia
python convertisseur_3ds_cia.py
cls
goto menu

:convertisseur_cia_3ds
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

ECHO Conversion terminée. Tous le(s) fichier(s) '.cia' ont été convertis et déplacés dans le dossier '.3ds'
cls
goto menu

:decrypt_3ds
@echo off
mode con cols=52 lines=26
title Batch CIA 3DS Decryptor
SetLocal EnableDelayedExpansion
echo %date% %time% >log.txt 2>&1
echo Decrypting...
for %%a in (*.ncch) do del "%%a" >nul
for %%a in (*.3ds) do (
	set CUTN=%%~na
	if /i x!CUTN!==x!CUTN:decrypted=! (
		echo | decrypt "%%a" >>log.txt 2>&1
		set ARG=
		for %%f in ("!CUTN!.*.ncch") do (
			if %%f==!CUTN!.Main.ncch set i=0
			if %%f==!CUTN!.Manual.ncch set i=1
			if %%f==!CUTN!.DownloadPlay.ncch set i=2
			if %%f==!CUTN!.Partition4.ncch set i=3
			if %%f==!CUTN!.Partition5.ncch set i=4
			if %%f==!CUTN!.Partition6.ncch set i=5
			if %%f==!CUTN!.N3DSUpdateData.ncch set i=6
			if %%f==!CUTN!.UpdateData.ncch set i=7
			set ARG=!ARG! -i "%%f:!i!:!i!"
		)
		makerom -f cci -ignoresign -target p -o "!CUTN!-decrypted.3ds"!ARG! >>log.txt 2>&1
	)
)
for %%a in (*.cia) do (
	set CUTN=%%~na
	if /i x!CUTN!==x!CUTN:decrypted=! (
		ctrtool -tmd "%%a" >content.txt
		set FILE="content.txt"
		set /a i=0
		set ARG=
		findstr /pr "^T.*D.*00040000" !FILE! >nul
		if not errorlevel 1 (
			echo | decrypt "%%a" >>log.txt 2>&1
			for %%f in ("!CUTN!.*.ncch") do (
				set ARG=!ARG! -i "%%f:!i!:!i!"
				set /a i+=1
			)
			makerom -f cia -ignoresign -target p -o "!CUTN!-decfirst.cia"!ARG! >>log.txt 2>&1
            exit
		)
		findstr /pr "^T.*D.*0004000E ^T.*D.*0004008C" !FILE! >nul
		if not errorlevel 1 (
			set TEXT="Content id"
			set /a X=0
			echo | decrypt "%%a" >>log.txt 2>&1
			for %%h in ("!CUTN!.*.ncch") do (
				set NCCHN=%%~nh
				set /a n=!NCCHN:%%~na.=!
				if !n! gtr !X! set /a X=!n!
			)
			for /f "delims=" %%d in ('findstr /c:!TEXT! !FILE!') do (
				set CONLINE=%%d
				call :EXF
			)
			findstr /pr "^T.*D.*0004000E" !FILE! >nul
			if not errorlevel 1 makerom -f cia -ignoresign -target p -o "!CUTN! (Patch)-decrypted.cia"!ARG! >>log.txt 2>&1
			findstr /pr "^T.*D.*0004008C" !FILE! >nul
			if not errorlevel 1 makerom -f cia -dlc -ignoresign -target p -o "!CUTN! (DLC)-decrypted.cia"!ARG! >>log.txt 2>&1
		)
	)
)
del content.txt >nul
for %%a in (*-decfirst.cia) do (
	set CUTN=%%~na
	makerom -ciatocci "%%a" -o "!CUTN:-decfirst=-decrypted!.cci" >>log.txt 2>&1
)
for %%a in (*-decfirst.cia) do del "%%a" >nul
for %%a in (*.ncch) do del "%%a" >nul
cls
echo Finished, please press any key to exit.
pause >nul
exit

:EXF
if !X! geq !i! (
	if exist !CUTN!.!i!.ncch (
		set CONLINE=!CONLINE:~24,8!
		call :GETX !CONLINE!, ID
		set ARG=!ARG! -i "!CUTN!.!i!.ncch:!i!:!ID!"
		set /a i+=1
	) else (
		set /a i+=1
		goto EXF
	)
)
exit/B

:GETX v dec
set /a dec=0x%~1
if [%~2] neq [] set %~2=%dec%
exit/b

rem matif

ECHO Conversion terminée. Le(s) fichier(s) '.3ds' ont été decrypté(s) et déplacé(s) dans le dossier 'decrypter'
cls
goto menu

:discord
echo.
echo Redirection vers notre serveur Discord...
start https://discord.gg/heUzNmpXgM
echo.
pause
cls
goto menu

:quitter
echo.
echo Au revoir !
pause
exit