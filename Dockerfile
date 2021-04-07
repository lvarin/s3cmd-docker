FROM python:3-alpine

RUN pip3 install s3cmd && \
    apk add postgresql-client

ENTRYPOINT ["/bin/sh"]
