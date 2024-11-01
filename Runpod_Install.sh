
apt update --yes
apt install ffmpeg --yes


python -m pip install --upgrade pip

git clone https://github.com/facefusion/facefusion

cd facefusion

python -m venv venv

source ./venv/bin/activate

pip install -r requirements.txt

pip uninstall torch torchvision torchaudio --yes

pip3 install torch==2.4.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124 --upgrade

pip install onnxruntime-gpu==1.19.2 --upgrade

apt update --yes

wget https://developer.download.nvidia.com/compute/cudnn/9.4.0/local_installers/cudnn-local-repo-ubuntu2204-9.4.0_1.0-1_amd64.deb
dpkg -i cudnn-local-repo-ubuntu2204-9.4.0_1.0-1_amd64.deb
cp /var/cudnn-local-repo-ubuntu2204-9.4.0/cudnn-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cudnn
ldconfig

# Add cuDNN library path to system-wide library path
echo '/usr/local/cuda/lib64' | tee /etc/ld.so.conf.d/cuda-9-4.conf

# Update the dynamic linker run-time bindings
ldconfig

# Add CUDA and cuDNN to system-wide environment variables
echo 'export PATH=/usr/local/cuda/bin:$PATH' | tee -a /etc/environment
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' | tee -a /etc/environment
echo 'export CUDNN_PATH=/usr/local/cuda' | tee -a /etc/environment

# Reload environment variables
source /etc/environment

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.4.0/local_installers/cuda-repo-ubuntu2004-12-4-local_12.4.0-550.54.14-1_amd64.deb
dpkg -i cuda-repo-ubuntu2004-12-4-local_12.4.0-550.54.14-1_amd64.deb
cp /var/cuda-repo-ubuntu2004-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cuda-toolkit-12-4

# Add CUDA to system-wide PATH and LD_LIBRARY_PATH
echo 'export PATH=/usr/local/cuda-12.4/bin${PATH:+:${PATH}}' | tee /etc/profile.d/cuda.sh
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' | tee -a /etc/profile.d/cuda.sh

# Make CUDA libraries available to the dynamic linker
echo '/usr/local/cuda-12.4/lib64' | tee /etc/ld.so.conf.d/cuda.conf
ldconfig

# Verify CUDA installation
nvcc --version


wget "https://huggingface.co/MonsterMMORPG/Generative-AI/resolve/main/face_fix_next.py" -O "/workspace/facefusion/facefusion/uis/layouts/default.py"

# Show completion message
echo "Virtual environment made and installed properly"

cd /workspace

pip install huggingface_hub --upgrade

python HF_model_downloaderV2.py

# Keep the terminal open
read -p "Press Enter to continue..."

