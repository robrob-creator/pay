# syntax=docker/dockerfile:1
FROM --platform=linux/amd64 vincemoonshot/isaac-http:v3
ENV SERVER_NAME="" \
    SERVER_VERSION="" \
    APP_PORT=":5000" 

COPY ./build/web /web

EXPOSE 5000

CMD ["/isaac-http"]

