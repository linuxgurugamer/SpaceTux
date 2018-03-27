@echo off
set DEFHOMEDRIVE=d:
set DEFHOMEDIR=%DEFHOMEDRIVE%%HOMEPATH%
set HOMEDIR=
set HOMEDRIVE=%CD:~0,2%

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"
echo Default homedir: %DEFHOMEDIR%

set /p HOMEDIR= "Enter Home directory, or <CR> for default: "

if "%HOMEDIR%" == "" (
set HOMEDIR=%DEFHOMEDIR%
)
echo %HOMEDIR%

SET _test=%HOMEDIR:~1,1%
if "%_test%" == ":" (
set HOMEDRIVE=%HOMEDIR:~0,2%
)

type SpacetuxSA.version

set /p VERSION= "Enter version: "



set d=%HOMEDIR\install
if exist %d% goto one
mkdir %d%
:one
set d=%HOMEDIR%\install\Gamedata
if exist %d% goto two
mkdir %d%
:two
set d=%HOMEDIR%\install\Gamedata\Spacetux\SharedAssets
if exist %d% goto three
mkdir %d%
:three

copy CHANGELOG %HOMEDIR%\install\Gamedata\Spacetux\SharedAssets
copy License.txt %HOMEDIR%\install\Gamedata\Spacetux\SharedAssets
xcopy Agencies %HOMEDIR%\install\Gamedata\Spacetux\SharedAssets\Agencies
xcopy Flags %HOMEDIR%\install\Gamedata\Spacetux\SharedAssets\Flags
copy SpacetuxSA.version %HOMEDIR%\install\Gamedata\Spacetux\SharedAssets

pause

%HOMEDRIVE%
cd %HOMEDIR%\install

set FILE="%RELEASEDIR%\SpaceTuxSA-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% Gamedata\spacetux

