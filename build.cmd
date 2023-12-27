@echo off

rem Spécifiez le chemin du fichier AssemblyInfo.cs
set ASSEMBLY_INFO=.\Properties\AssemblyInfo.cs
rem Extrait le nom de la resource
for /f "tokens=2 delims=()" %%a in ('findstr "AssemblyTitle" %ASSEMBLY_INFO%') do set RESOURCE_NAME=%%a
rem Extraction de la version
for /f "tokens=2 delims=()" %%a in ('findstr "AssemblyVersion" %ASSEMBLY_INFO%') do set VERSION=%%a
rem Extraction de l'auteur
for /f "tokens=2 delims=()" %%a in ('findstr "AssemblyCompany" %ASSEMBLY_INFO%') do set AUTHOR=%%a
rem Extraction de github
for /f "tokens=2 delims=()" %%a in ('findstr "AssemblyProduct" %ASSEMBLY_INFO%') do set GITHUB=%%a
rem Extraction de la description
for /f "tokens=2 delims=()" %%a in ('findstr "AssemblyDescription" %ASSEMBLY_INFO%') do set DESCRIPTION_=%%a

rem Création du répertoire
rmdir /s /q %RESOURCE_NAME%
mkdir %RESOURCE_NAME%

set "VERSION=%VERSION:"=%"
rem Création du fichier fxmanifest.lua
(
  echo fx_version 'cerulean'
  echo lua54 'yes'
  echo use_experimental_fxv2_oal 'yes'
  echo version %VERSION%
  echo.
  echo author %AUTHOR%
  echo description %DESCRIPTION_%
  echo github %GITHUB%
  echo.
  echo file 'client/*.dll'
  echo.
  echo client_script 'client/*.net.dll'
  echo server_script 'server/*.net.dll'
) > %RESOURCE_NAME%\fxmanifest.lua

pushd Client
dotnet publish -c Release
popd

pushd Server
dotnet publish -c Release
popd

rem copy /y fxmanifest.lua dist
xcopy /y /e Client\bin\Release\net452\publish %RESOURCE_NAME%\client\
xcopy /y /e Server\bin\Release\netstandard2.0\publish %RESOURCE_NAME%\server\