FROM python:3.8-slim

WORKDIR /app

RUN apt update \
    && apt-get install -y graphviz \
    && pip install -U pip \
    && pip install poetry

COPY . /app

RUN poetry install \
    && rm -r /root/.cache/pip \
    && yes | poetry cache clear pypi --all

CMD ["bin/sh"]
