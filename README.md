# CyberChef

[![Build and Push Workflow](https://github.com/obeone/cyberchef-docker/actions/workflows/build-and-publish.yaml/badge.svg)](https://github.com/obeone/cyberchef-docker/actions/workflows/build-and-publish.yaml)
![Version](https://img.shields.io/github/v/tag/obeone/cyberchef-docker?label=version&style=plastic)
![Last Updated](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/obeone/876a9aed55cffad6054360c99ecf4093/raw/date.json)

## Overview

**CyberChef** is a web app known as the "Cyber Swiss Army Knife" for its wide array of operations including encryption, encoding, compression, and data analysis. This versatile tool is invaluable for cybersecurity professionals, developers, and data analysts alike.

This package is automatically rebuilt every day to make sure that it utilizes the latest upstream version of [CyberChef](https://github.com/gchq/CyberChef). The Docker image embeds CyberChef in an unprivileged NGINX container, providing a robust and secure environment for your operations.

## Getting Started

### Running CyberChef

Run the next command to start CyberChef in a Docker container:

```bash
docker run -d -p 8000:8000 ghcr.io/obeone/cyberchef:latest
```

Then, open your web browser and navigate to [http://localhost:8000](http://localhost:8000) to start using CyberChef.

### Building from Source

If you need to customize the build, edit `build.sh` script as needed and execute it to build your container.

### Kubernetes Deployment

A Helm chart is available for deploying CyberChef on Kubernetes. You can find the files and instructions [here](https://github.com/obeone/charts).

## Features

- **Encryption/Decryption**: Do cryptographic operations using a variety of algorithms.
- **Encoding/Decoding**: Encode or decode data in formats such as Base64, URL encoding, and more.
- **Data Analysis**: Conduct extensive data manipulation and analysis tasks.
- **Compression/Decompression**: Easily compress and decompress data.

This project follows continuous integration practices, ensuring the software remains up-to-date with the latest features and security patches from the main CyberChef repository.

## Community and Support

Feel free to contribute to the project by opening issues or pull requests on [GitHub](https://github.com/obeone/cyberchef-docker).

For user community and support, check out the CyberChef user forum, or connect with other users and developers through relevant online platforms.

## License

This project is licensed under the terms of the [MIT License](LICENSE).
