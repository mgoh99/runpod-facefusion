import os
import requests
import zipfile
import time
from tqdm import tqdm

def download_file(url, destination):
    max_retries = 5
    retry_delay = 5
    chunk_size = 8192
    
    for attempt in range(max_retries):
        try:
            response = requests.get(url, stream=True)
            response.raise_for_status()
            
            total_size = int(response.headers.get('content-length', 0))
            
            mode = 'ab' if os.path.exists(destination) else 'wb'
            
            with open(destination, mode) as file, tqdm(
                desc=destination,
                total=total_size,
                unit='iB',
                unit_scale=True,
                unit_divisor=1024,
            ) as progress_bar:
                downloaded_size = file.tell()
                progress_bar.update(downloaded_size)
                
                for chunk in response.iter_content(chunk_size=chunk_size):
                    size = file.write(chunk)
                    progress_bar.update(size)
            
            print(f"Download completed successfully: {destination}")
            return True
        
        except requests.exceptions.RequestException as e:
            print(f"Attempt {attempt + 1} failed: {str(e)}")
            if attempt < max_retries - 1:
                print(f"Retrying in {retry_delay} seconds...")
                time.sleep(retry_delay)
            else:
                print("Max retries reached. Download failed.")
                return False

def extract_zip(zip_path, extract_path):
    try:
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_path)
        print(f"Successfully extracted {zip_path} to {extract_path}")
        return True
    except zipfile.BadZipFile:
        print(f"Error: {zip_path} is not a valid zip file.")
    except Exception as e:
        print(f"Error extracting {zip_path}: {str(e)}")
    return False

def main():
    url = "https://huggingface.co/MonsterMMORPG/Generative-AI/resolve/main/cudnn_9_4.zip"
    filename = "cudnn_9_4.zip"
    extract_dir = os.path.join("facefusion", "venv", "Lib", "site-packages", "onnxruntime", "capi")
    
    # Download the file to the current directory
    if download_file(url, filename):
        print("Download completed successfully.")
        
        # Ensure the extraction directory exists
        os.makedirs(extract_dir, exist_ok=True)
        
        # Extract the file
        if extract_zip(filename, extract_dir):
            print("Extraction completed successfully.")
        else:
            print("Extraction failed.")
    else:
        print("Download failed.")

if __name__ == "__main__":
    main()