import onnxruntime

# Get the available execution providers
available_providers = onnxruntime.get_available_providers()

# GPU providers typically include:
gpu_providers = ['CUDAExecutionProvider', 'TensorrtExecutionProvider', 'OpenVINOExecutionProvider', 'DirectMLExecutionProvider']

# Check if any GPU providers are available
found_gpu_providers = [provider for provider in available_providers if provider in gpu_providers]

# Print the available execution providers
print("Available ONNX Runtime Execution Providers:")
for provider in available_providers:
    print(f"- {provider}")

# Print the available GPU providers
if found_gpu_providers:
    print("\nGPU Execution Providers Available:")
    for gpu_provider in found_gpu_providers:
        print(f"- {gpu_provider}")
else:
    print("\nNo GPU Execution Providers Available.")