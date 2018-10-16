FROM senzing/python-base

# Build-time variables

ARG REFRESHED_AT=2018-10-15

# Run-time command

WORKDIR /opt/senzing/g2/python
ENTRYPOINT python G2Loader.py
CMD ""
