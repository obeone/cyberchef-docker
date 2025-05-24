# syntax=docker/dockerfile:1

# Define the base image argument, default is 'build'
ARG BASE_IMAGE=build

# Stage 1: Builder stage using Node.js 18 image
FROM docker.io/node:18 AS builder
ARG GIT_TAG=

# Clone the CyberChef repository into /srv directory
RUN git clone https://github.com/gchq/CyberChef /srv
WORKDIR /srv

# Checkout the specified git tag if provided
RUN if [ -n "${GIT_TAG}" ]; then git checkout ${GIT_TAG}; fi

# Increase Node.js memory limit to 2GB for build process
ENV NODE_OPTIONS="--max-old-space-size=2048"

# Install npm dependencies
RUN npm install

# Run the production build using grunt
RUN npx grunt prod

# Stage 2: Build stage from scratch (empty image)
FROM scratch AS build

# Copy the production build output from builder stage
COPY --from=builder /srv/build/prod /

# Stage 3: Builded stage (placeholder, no content)
FROM $BASE_IMAGE AS builded

# Stage 4: Final application stage using unprivileged nginx on Alpine
FROM docker.io/nginxinc/nginx-unprivileged:alpine AS app

# Change nginx listen port from 8080 to 8000 to maintain compatibility with old http-server
RUN sed -i 's|listen       8080;|listen       8000;|g' /etc/nginx/conf.d/default.conf

# Copy the built application files from the build stage to nginx html directory
COPY --from=builded / /usr/share/nginx/html

# Expose port 8000 for the application
EXPOSE 8000

# Metadata labels
LABEL org.opencontainers.image.source="https://github.com/obeone/cyberchef-docker"
LABEL maintainer="Grégoire Compagnon <obeone@obeone.org>"
LABEL org.opencontainers.image.description="CyberChef served by unprivileged nginx"
