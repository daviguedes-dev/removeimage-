@echo off
where py >nul 2>nul
if %errorlevel%==0 (
    py -3 "%~dp0removeimage.py" %*
) else (
    python "%~dp0removeimage.py" %*
)
exit /b %errorlevel%
