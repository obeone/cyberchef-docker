# CyberChef
The Cyber Swiss Army Knife - a web app for encryption, encoding, compression and data analysis

This package is rebuilt everyday to stay up-to-date and always use latest upstream version of CyberChef (there are tags using CyberChef version)

This docker image embbed [GCHQ CyberChef](https://github.com/gchq/CyberChef) in an unprivileged nginx.

## Usage
```sh
docker run -d -p 8000:8000  obebete/cyberchef
```

And go to [http://localhost:8000](http://localhost:8000)

## Building
Customize `build.sh` if you need, and run it!


### Kubernetes (Helm)
A helm chart exists, just follow [documentation](https://github.com/obeone/charts)
