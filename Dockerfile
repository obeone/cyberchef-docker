# syntax=docker/dockerfile:1

# Stage 1: Builder stage using Node.js 24 Alpine image (CyberChef v11 requires Node >=24 <25)
FROM --platform=$BUILDPLATFORM docker.io/node:24-alpine AS builder
ARG GIT_TAG=

# git is required to clone the upstream CyberChef repository
RUN apk add --no-cache git

# Clone the CyberChef repository into /srv directory
RUN git clone https://github.com/gchq/CyberChef /srv
WORKDIR /srv

# Checkout the specified git tag if provided
RUN if [ -n "${GIT_TAG}" ]; then git checkout ${GIT_TAG}; fi

# Increase Node.js memory limit to 4GB for build process
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Install npm dependencies
RUN npm install

# Run the production build
RUN npm run build

# Stage 2: Final application stage using unprivileged nginx on Alpine
FROM docker.io/nginxinc/nginx-unprivileged:alpine AS app

# Change nginx listen port from 8080 to 8000 to maintain compatibility with old http-server
RUN sed -i 's|listen       8080;|listen       8000;|g' /etc/nginx/conf.d/default.conf

# Copy the built application files from the build stage to nginx html directory
COPY --from=builder /srv/build/prod /usr/share/nginx/html

# Expose port 8000 for the application
EXPOSE 8000

# Metadata labels
LABEL org.opencontainers.image.source="https://github.com/obeone/cyberchef-docker"
LABEL maintainer="Grégoire Compagnon <obeone@obeone.org>"
LABEL org.opencontainers.image.description="CyberChef served by unprivileged nginx"
