FROM python:3.8-slim-buster

WORKDIR /application

# Install system dependencies (single layer) + cleanup to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    awscli \
    ffmpeg \
    libsm6 \
    libxext6 \
    unzip \
  && rm -rf /var/lib/apt/lists/*

# Install Python dependencies first for better caching
COPY requirements.txt /application/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project
COPY . /application

CMD ["python3", "application.py"]