FROM odoo:18.0

USER root

# Add PostgreSQL 17 repo
RUN apt-get update && apt-get install -y wget gnupg2 lsb-release && \
    wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/pgdg.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
        > /etc/apt/sources.list.d/pgdg.list

# Install build dependencies (with libpq-dev for PG 17)
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    libffi-dev \
    libssl-dev \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY ./requirements.txt /tmp/requirements.txt

# Install Python dependencies
RUN pip3 install --break-system-packages --no-cache-dir --ignore-installed -r /tmp/requirements.txt


USER odoo
