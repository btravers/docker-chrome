FROM ubuntu:22.04

EXPOSE 9222

RUN apt-get update -qq \
    && apt-get -qq dist-upgrade \
    && apt-get install -qqy software-properties-common \
    && add-apt-repository ppa:saiarcot895/chromium-beta \
        && apt-get update -qq \
    && apt-get -qqy --no-install-recommends install \
        chromium-browser \
        tini \
    && fc-cache -f -v \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["tini", "--"]
CMD [ "chromium-browser", "--headless", "--disable-gpu", "–-no-first-run", "--disable-dev-shm-usage", "--disable-setuid-sandbox", "--no-sandbox", "--font-render-hinting=none", "--force-color-profile=srgb", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
