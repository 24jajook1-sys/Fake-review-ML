@echo off
title ReviewGuard - Local Server
echo ========================================================
echo       ReviewGuard: Fake Review Detection System
echo ========================================================
echo.
echo Starting local web server...
echo.

cd /d "%~dp0"

if not exist "venv\Scripts\python.exe" (
    echo [ERROR] Virtual environment not found!
    echo Please run: python -m venv venv
    echo and: pip install -r requirements.txt
    pause
    exit /b 1
)

echo Opening default browser at http://127.0.0.1:5000...
start "" "http://127.0.0.1:5000"

echo.
echo Server running at: http://127.0.0.1:5000
echo Press Ctrl+C in this terminal window to stop the server.
echo.
venv\Scripts\python.exe -m backend.app
pause
