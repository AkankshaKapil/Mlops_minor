# --------------------------
# Base Image (PyTorch + CUDA)
# --------------------------
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# --------------------------
# Set working directory
# --------------------------
WORKDIR /app

# --------------------------
# System dependencies
# --------------------------
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# --------------------------
# Copy requirements and install
# --------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# --------------------------
# Copy project files
# --------------------------
COPY train.py .
COPY evaluate.py .
COPY setB.pth .
COPY data/ data/

# --------------------------
# Default command (evaluation)
# --------------------------
CMD ["python", "evaluate.py"]
