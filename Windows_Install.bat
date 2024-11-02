@echo off

echo WARNING. For this auto installer to work you need to have installed Python 3.10.x, C++ tools, Git and FFmpeg
echo follow this tutorial to install all above : https://youtu.be/-NjNy7afOQ0

git clone https://github.com/facefusion/facefusion

cd facefusion

py --version >nul 2>&1
if "%ERRORLEVEL%" == "0" (
    echo Python launcher is available. Generating Python 3.10 VENV
    py -3.10 -m venv venv
) else (
    echo Python launcher is not available, generating VENV with default Python. Make sure that it is 3.10
    python -m venv venv
)

call .\venv\Scripts\activate.bat

pip install -r requirements.txt

pip uninstall torch torchvision torchaudio --yes

pip3 install torch==2.4.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124 --upgrade

pip install https://huggingface.co/MonsterMMORPG/SECourses/resolve/main/triton-2.1.0-cp310-cp310-win_amd64.whl --upgrade

pip install https://huggingface.co/MonsterMMORPG/SECourses/resolve/main/deepspeed-0.11.2_cuda121-cp310-cp310-win_amd64.whl --upgrade

pip install onnxruntime-gpu==1.19.2 --upgrade

pip install huggingface_hub --upgrade

cd ..

REM pip install --upgrade nvidia-cudnn-cu12==9.4.0.58 --no-cache-dir

python HF_model_downloaderV2.py

REM Windows_ADD_Capi_Folder_To_Path.bat

REM Show completion message
echo Virtual environment made and installed properly

REM Pause to keep the command prompt open
pause