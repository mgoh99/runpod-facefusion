@echo off

cd FaceFusion

call .\venv\Scripts\activate.bat || exit /b

set /p choice=Enter the execution provider (1 for CUDA - preffered and faster, 2 for CPU): 

if "%choice%"=="1" (
  echo Using CUDA execution provider
  set PYTHONWARNINGS=ignore
  python facefusion.py run --execution-providers cuda
) else if "%choice%"=="2" (
  echo Using CPU execution provider
  set PYTHONWARNINGS=ignore
  python facefusion.py run --execution-providers cpu
) else (
  echo Invalid choice. Please enter either 1 for CUDA or 2 for CPU.
)

pause