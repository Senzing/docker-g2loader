# docker-g2loader

## Overview

This Dockerfile is a wrapper over Senzing's G2Loader.py.

### Contents

1. [Build docker image](#build-docker-image)
1. [Create SENZING_DIR](#create-senzing_dir)
1. [Set environment variables](#set-environment-variables)
1. [Run Docker container](#run-docker-container)

## Build docker image

1. If `senzing/python-base` image is not in local docker repository, run:

    ```console
    docker build --tag senzing/python-base https://github.com/senzing/docker-python-base.git
    ```

1. Build image:

    ```console
    docker build --tag senzing/g2loader https://github.com/senzing/docker-g2loader.git
    ```

## Create SENZING_DIR

If you do not already have an `/opt/senzing` directory, here's how to install the code.

1. Set environment variable

    ```console
    export SENZING_DIR=/opt/senzing
    ````

1. Download [Senzing_API.tgz](https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz)

    ```console
    curl -X GET \
      --output /tmp/Senzing_API.tgz \
      https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz
    ```

1. Extract [Senzing_API.tgz](https://s3.amazonaws.com/public-read-access/SenzingComDownloads/Senzing_API.tgz)
   to `/opt/senzing`.

    ```console
    mkdir -p /opt/senzing
    tar \
      --extract \
      --owner=root \
      --group=root \
      --no-same-owner \
      --no-same-permissions \
      --directory=${SENZING_DIR} \
      --file=$/tmp/Senzing_API.tgz
    ```

## Set environment variables

1. Identify the database username and password.
   Example:

    ```console
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD=root
    ```

1. Identify the database that is the target of the SQL statements.
   Example:

    ```console
    export MYSQL_DATABASE=G2
    ```

1. Identify the host running mySQL servers.
   Example:

    ```console
    docker ps

    # Choose value from NAMES column of docker ps
    export MYSQL_HOST=docker-container-name
    ```

1. Identify the Docker network of the mySQL database.
   Example:

    ```console
    docker network ls

    # Choose value from NAME column of docker network ls
    export MYSQL_NETWORK=nameofthe_network
    ```

## Run docker container

1. Run the docker container.

    ```console
    docker run -it  \
      --volume ${SENZING_DIR}:/opt/senzing \
      --net ${MYSQL_NETWORK} \
      --env SENZING_DATABASE_URL="mysql://${MYSQL_USERNAME}:${MYSQL_PASSWORD}@${MYSQL_HOST}:3306/${MYSQL_DATABASE}" \
      senzing/g2loader \
        --purgeFirst \
        --projectFile /opt/senzing/g2/python/demo/sample/project.csv
    ```
