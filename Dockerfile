FROM senzing/python-base

# Build-time variables

ENV REFRESHED_AT=2019-01-14

# Run-time command

WORKDIR /opt/senzing/g2/python
ENTRYPOINT ["python", "G2Loader.py"]

CMD [""]
