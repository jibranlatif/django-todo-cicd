FROM registry.access.redhat.com/ubi9/python-311

# Become root to install system packages
USER root

RUN dnf install -y \
    gcc \
    python3-devel \
    libcomps \
    rpm \
    python3-libselinux \
    python3-libsemanage \
    && dnf clean all


# Switch back to non-root user (if required)
USER 1001

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
