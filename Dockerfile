# Use an official lightweight base image
FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    libssl-dev \
    libncurses5-dev \
    libpcre3-dev \
    libpcap-dev \
    s6 && \
    rm -rf /var/lib/apt/lists/*

# Download and install SIPp 3.5.3
RUN wget https://github.com/SIPp/sipp/releases/download/v3.5.3/sipp-3.5.3.tar.gz && \
    tar xzf sipp-3.5.3.tar.gz && \
    cd sipp-3.5.3 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf sipp-3.5.3*

# Setup s6
COPY s6 /etc/s6

# Set s6 as the entrypoint
ENTRYPOINT ["/init"]

