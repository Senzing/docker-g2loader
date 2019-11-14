ARG BASE_IMAGE=senzing/senzing-base:1.3.0
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-11-13

LABEL Name="senzing/g2loader" \
      Maintainer="support@senzing.com" \
      Version="1.3.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Copy files from repository.

COPY ./rootfs /

# Make non-root container.

USER 1001

# Runtime execution.

WORKDIR /opt/senzing/g2/python
ENTRYPOINT ["/opt/senzing/g2/python/G2Loader.py"]
CMD ["-c", "/etc/opt/senzing/G2Module.ini"]
