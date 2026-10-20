@echo off
setlocal EnableDelayedExpansion

cd /d "%~dp0"

set "CMAKE=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
set "VCVARS=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
set "GENERATOR=Visual Studio 18 2026"
set "ARCH=x64"
set "CONFIG=Release"

echo [INFO] Initializing MSVC environment...
call "%VCVARS%"
if errorlevel 1 (
    echo [ERROR] vcvars64.bat failed
    exit /b 1
)

echo [INFO] Configuring CMake...
if exist build rmdir /s /q build
"%CMAKE%" -S src -B build -G "%GENERATOR%" -A %ARCH%
if errorlevel 1 (
    echo [ERROR] CMake configure failed
    exit /b 1
)

echo [INFO] Building EmpireTool (%CONFIG%)...
"%CMAKE%" --build build --config %CONFIG% --target EmpireTool
if errorlevel 1 (
    echo [ERROR] EmpireTool build failed
    exit /b 1
)

echo [INFO] Building dwmapi proxy (%CONFIG%)...
"%CMAKE%" --build build --config %CONFIG% --target dwmapi
if errorlevel 1 (
    echo [ERROR] dwmapi build failed
    exit /b 1
)

echo [INFO] Building xinput1_4 proxy (%CONFIG%)...
"%CMAKE%" --build build --config %CONFIG% --target xinput1_4
if errorlevel 1 (
    echo [ERROR] xinput1_4 build failed
    exit /b 1
)

echo.
echo [OK] Build complete!
echo [INFO] Copying to Steam folder...
copy /Y "build\%CONFIG%\EmpireTool.dll" "C:\Program Files (x86)\Steam\EmpireTool.dll"
copy /Y "build\%CONFIG%\xinput1_4.dll" "C:\Program Files (x86)\Steam\xinput1_4.dll"
echo [OK] Copied EmpireTool.dll and xinput1_4.dll to Steam folder.
exit /b 0
