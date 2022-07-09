ARG BASE_IMAGE
FROM --platform=${BUILDPLATFORM} ${BASE_IMAGE} as build

FROM docker.io/nginxinc/nginx-unprivileged:alpine as app
# old http-server was running on port 8000, avoid breaking change
RUN sed -i 's|listen       8080;|listen       8000;|g' /etc/nginx/conf.d/default.conf

COPY --from=build / /usr/share/nginx/html
EXPOSE 8000


LABEL org.opencontainers.image.source=https://github.com/obeone/cyberchef-docker
LABEL maintainer='Grégoire Compagnon <obeone@obeone.org>'
LABEL org.opencontainers.image.description="CyberChef served by unprivileged nginx"
