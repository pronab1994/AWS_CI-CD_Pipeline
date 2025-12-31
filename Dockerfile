FROM python:3.8-slim-bullseye

WORKDIR /application

RUN apt-get update && apt-get install -y --no-install-recommends \
    awscli \
    ffmpeg \
    libsm6 \
    libxext6 \
    unzip \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /application/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . /application

CMD ["python3", "application.py"]
