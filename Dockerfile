FROM python:3.11-slim

# Set the working directory
WORKDIR /data

# Install system dependencies including distutils
RUN apt-get update && \
    apt-get install -y python3-distutils gcc && \
    rm -rf /var/lib/apt/lists/*

# Install Django and any other dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose port and set default command
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

