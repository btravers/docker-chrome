ARG PROXY_REGISTRY_PREFIX
FROM ubuntu:22.04

EXPOSE 9222

RUN apt-get update -qq \
    && apt-get -qq dist-upgrade \
    && apt-get install -qqy software-properties-common \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get install -qqy gnupg \
    && add-apt-repository ppa:saiarcot895/chromium-beta \
        && apt-get update -qq \
    && apt-get -qqy --no-install-recommends install \
        chromium-browser \
        build-essential \
        ca-certificates \
        dumb-init \
        ffmpeg \
        fontconfig \
        fonts-freefont-ttf \
        fonts-gfs-neohellenic \
        fonts-indic \
        fonts-ipafont-gothic \
        fonts-kacst \
        fonts-liberation \
        fonts-noto-cjk \
        fonts-noto-color-emoji \
        fonts-roboto \
        fonts-thai-tlwg \
        fonts-ubuntu \
        fonts-wqy-zenhei \
        gconf-service \
        libappindicator1 \
        libappindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgbm-dev \
        libgbm1 \
        libgcc1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        locales \
        lsb-release \
        msttcorefonts \
        xdg-utils \
        xvfb \
        tini \
    # Cleanup
    && fc-cache -f -v \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["tini", "--"]
CMD [ "chromium-browser", "--headless", "--disable-gpu", "–-no-first-run", "--disable-dev-shm-usage", "--disable-setuid-sandbox", "--no-sandbox", "--font-render-hinting=none", "--force-color-profile=srgb", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
