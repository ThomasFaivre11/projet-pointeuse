FROM --platform=linux/arm64/v8 elixir:latest AS build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN mix local.hex --force && \
    mix local.rebar --force
WORKDIR /app
COPY mix.exs mix.lock ./
RUN mix deps.get --verbose
RUN mix compile --max-concurrency=1
COPY . .
EXPOSE 4000
