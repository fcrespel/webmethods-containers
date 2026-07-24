# webMethods containers samples

This repository contains samples for **IBM webMethods** 11.1 containers.

These samples are provided as-is and without warranty or support. They do not constitute part of the IBM webMethods product suite, and are not endorsed by IBM. Users are free to use, fork and modify them, subject to the license agreement.

## Prerequisites

To build and run container images, make sure to install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) and have sufficient RAM available.

You will also need an **IBM ID** with access to the products you want to build. In particular, make sure you can access:

- [webMethods Container Registry](https://containers.webmethods.io), to be able to pull the official webMethods container images. Generate a password from your profile and login with the `docker login ibmwebmethods.azurecr.io` command.
- [webMethods Package Registry](https://packages.webmethods.io), to be able to use webMethods Package Manager (WPM). Generate a token from your profile and set it in the `WPM_TOKEN` environment variable or in a `.env` file in this directory.

## Usage

### Microservices Runtime

Run the following command to build and start the Microservices Runtime and Universal Messaging (optional) containers:

```bash
docker compose build is
docker compose up -d is um
```

Connect to the Microservices Runtime container at [http://localhost:5555](http://localhost:5555) and log in with the default credentials (`Administrator` / `manage`).

Review the `is/Dockerfile` file for more details and customization of the build process (e.g. WPM packages and extra JARs).

Configuration variables are defined in the `is/IntegrationServer/application.properties` file.

### API Gateway

Run the following command to start the API Gateway containers:

```bash
docker compose up -d apigw apigw-es apigw-kb
```

Connect to the API Gateway container at [http://localhost:5556](http://localhost:5556) and log in with the default credentials (`Administrator` / `manage`).

Configuration variables are defined in the `apigw/IntegrationServer/application.properties` file.

### Developer Portal

Run the following command to start the Developer Portal containers:

```bash
docker compose up -d devportal devportal-es
```

Connect to the Developer Portal container at [http://localhost:18101](http://localhost:18101) and log in with the default credentials (`Administrator` / `manage`).

### Managed File Transfer

Run the following command to start the Managed File Transfer containers:

```bash
docker compose up -d mft-pg
docker compose run --rm mft-dcc
docker compose up -d mft
```

Connect to the Managed File Transfer container at [http://localhost:5557/WmMFT/](http://localhost:5557/WmMFT/) and log in with the default credentials (`Administrator` / `manage`).

Configuration variables are defined in the `mft/IntegrationServer/application.properties` file.
