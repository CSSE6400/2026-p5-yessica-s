FROM python:3.12-slim

ENV SQLALCHEMY_DATABASE_URI=sqlite:///:memory:

# Installing dependencies and cleaning up
RUN apt-get update && \
        apt-get install -y postgresql-client libpq-dev libcurl4-openssl-dev libssl-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Install poetry
RUN pip install poetry

# Setting the working directory
WORKDIR /app

# Install pipenv dependencies
COPY pyproject.toml .
RUN poetry install --no-root

# Copying our application into the container
COPY bin bin
COPY todo todo

# Running our application
ENTRYPOINT ["/app/bin/docker-entrypoint"]
CMD ["serve"]
