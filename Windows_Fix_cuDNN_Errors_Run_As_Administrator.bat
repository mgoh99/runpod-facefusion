@echo off
setlocal EnableDelayedExpansion

pip install requests tqdm huggingface_hub


echo This is a diagnostic script. Press any key after each step to continue.
REM pause

echo Step 1: Checking administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires administrative privileges.
    echo Please run this script as an administrator.
    goto :END
) else (
    echo SUCCESS: Script is running with administrative privileges.
)
REM pause

echo Step 2: Getting script directory
set "SCRIPT_DIR=%~dp0"
echo Script directory: "%SCRIPT_DIR%"
REM pause

echo Step 3: Changing to script directory
cd /d "%SCRIPT_DIR%"
echo Current directory: %CD%
REM pause

echo Step 4: Checking for HF_model_downloader.py
if exist "HF_model_downloader.py" (
    echo SUCCESS: HF_model_downloader.py found.
) else (
    echo ERROR: HF_model_downloader.py not found in the script directory.
    goto :END
)
REM pause

echo Step 5: Running HF_model_downloader.py
python HF_model_downloader.py
if %errorlevel% neq 0 (
    echo ERROR: Failed to run HF_model_downloader.py
    echo Error code: %errorlevel%
    goto :END
) else (
    echo SUCCESS: HF_model_downloader.py ran successfully.
)
REM pause

echo Step 6: Constructing path to add
set "PATH_TO_ADD=%SCRIPT_DIR%facefusion\venv\Lib\site-packages\onnxruntime\capi"
echo Path to add: "%PATH_TO_ADD%"
REM pause

echo Step 7: Checking if directory exists
if exist "%PATH_TO_ADD%" (
    echo SUCCESS: Directory exists.
) else (
    echo ERROR: The specified directory does not exist.
    echo Please make sure the path is correct and try again.
    goto :END
)
REM pause

echo Step 8: Attempting to update System PATH
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH_TO_ADD%;%PATH%" /f
if %errorlevel% equ 0 (
    echo SUCCESS: System PATH updated.
) else (
    echo ERROR: Failed to update System PATH.
    echo Error code: %errorlevel%
)
REM pause

echo Step 9: Attempting to update User PATH
reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH_TO_ADD%;%PATH%" /f
if %errorlevel% equ 0 (
    echo SUCCESS: User PATH updated.
) else (
    echo ERROR: Failed to update User PATH.
    echo Error code: %errorlevel%
)
REM pause

echo Diagnostic complete. Please provide the output of this script.

:END
echo.
echo Script execution completed. Press any key to exit.
pause > nul