# Python 3.8 base (stable, still widely supported)
FROM python:3.8-slim

# Prevent Python from writing .pyc files and buffering stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /application

# System dependencies required for ML libraries (xgboost, sklearn, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    curl \
  && rm -rf /var/lib/apt/lists/*

# Upgrade pip tooling (important for old Python)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Install Python dependencies first (layer caching)
COPY requirements.txt /application/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /application

# Document the port the app listens on
EXPOSE 8080

# Start the Flask app using Gunicorn (production-safe)
CMD ["gunicorn", "-b", "0.0.0.0:8080", "application:app"]
