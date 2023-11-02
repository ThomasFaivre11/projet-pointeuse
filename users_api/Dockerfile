FROM --platform=linux/arm64/v8 elixir:1.13.4-alpine AS build

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
COPY . .
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installation de Hex et Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copie des fichiers de dépendance Elixir
COPY mix.exs mix.lock ./

# Obtention et compilation des dépendances
RUN mix deps.get
RUN mix deps.compile

EXPOSE 4000

