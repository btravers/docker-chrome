FROM alpine:3.16

EXPOSE 9222

RUN apk upgrade --no-cache --available \
    && apk add --no-cache \
      chromium

COPY ./fonts /tmp/fonts

RUN mkdir -p /usr/share/fonts/truetype/ \
    && install -m644 /tmp/fonts/Monserrat/Montserrat-VariableFont_wght.ttf /usr/share/fonts/truetype/ \
    && install -m644 /tmp/fonts/Monserrat/Montserrat-Italic-VariableFont_wght.ttf /usr/share/fonts/truetype/ \
    && rm -rf /tmp/fonts

RUN mkdir -p /usr/src/app \
    && adduser -D chrome \
    && chown -R chrome:chrome /usr/src/app

USER chrome
WORKDIR /usr/src/app

ENTRYPOINT [ "chromium-browser", "--headless", "--disable-gpu", "--disable-dev-shm-usage", "--disable-setuid-sandbox", "--no-sandbox", "--font-render-hinting=none", "--force-color-profile=srgb", "–-no-first-run", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
