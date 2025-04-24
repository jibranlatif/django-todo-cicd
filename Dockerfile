FROM registry.access.redhat.com/ubi9/python-311

# Install system packages required by your Python modules
RUN dnf install -y \
    gcc \
    python3-devel \
    libcomps \
    rpm \
    python3-libselinux \
    python3-libsemanage \
    setools-console \
    dbus-python \
    python3-gnupg \
    systemd-python \
    && dnf clean all

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . .

# Start the application (adjust if needed)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
