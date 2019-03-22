ARG BASE_IMAGE=senzing/senzing-base
FROM ${BASE_IMAGE}

# Build-time variables.

ENV REFRESHED_AT=2019-03-09

LABEL Name="senzing/g2loader" \
      Version="1.0.0"

# Runtime execution.

WORKDIR /opt/senzing/g2/python
ENTRYPOINT ["/app/docker-entrypoint.sh", "python G2Loader.py" ]
CMD [""]
