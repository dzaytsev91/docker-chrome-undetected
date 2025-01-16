FROM python:3.9-slim-buster

# Install required dependencies for Chrome and ChromeDriver
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    ca-certificates \
    libx11-dev \
    libxext6 \
    libxrender-dev \
    libfontconfig1 \
    libxi6 \
    libappindicator3-1 \
    libasound2 \
    libdbus-1-3 \
    libxtst6 \
    x11vnc \
    xvfb \
    dbus-x11 \
    fonts-liberation \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libvulkan1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install specific version of Google Chrome
RUN wget https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_132.0.6834.83-1_amd64.deb -O /tmp/google-chrome.deb \
    && dpkg -i /tmp/google-chrome.deb \
    || apt-get install -f -y \
    && rm -f /tmp/google-chrome.deb

# Install undetected-chromedriver and other Python dependencies
RUN pip install --no-cache-dir undetected-chromedriver selenium ipython

# Install chromedriver for the correct Chrome version
RUN wget https://repo.huaweicloud.com/chromedriver/131.0.6778.85/chromedriver-linux64.zip -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip && mv chromedriver-linux64/chromedriver /usr/local/bin \
    && chmod +x /usr/local/bin/chromedriver \
    && rm /tmp/chromedriver.zip && rm -rf chromedriver-linux64

ENV DISPLAY=:99
