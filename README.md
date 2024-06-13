# CyberChef

[![Build and push](https://github.com/obeone/cyberchef-docker/actions/workflows/build-and-publish.yaml/badge.svg)](https://github.com/obeone/cyberchef-docker/actions/workflows/build-and-publish.yaml)
![Version](https://img.shields.io/github/v/tag/obeone/cyberchef-docker?label=version&style=plastic)
![Date](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/obeone/876a9aed55cffad6054360c99ecf4093/raw/date.json)


The Cyber Swiss Army Knife - a web app for encryption, encoding, compression and data analysis

This package is rebuilt everyday to stay up-to-date and always use latest upstream version of CyberChef (there are tags using CyberChef version)

This docker image embbed [GCHQ CyberChef](https://github.com/gchq/CyberChef) in an unprivileged nginx.

## Usage
```sh
docker run -d -p 8000:8000  ghcr.io/obeone/cyberchef:latest
```

And go to [http://localhost:8000](http://localhost:8000)

## Building
Customize `build.sh` if you need, and run it!


### Kubernetes (Helm)
A helm chart exists, just follow [documentation](https://github.com/obeone/charts)
