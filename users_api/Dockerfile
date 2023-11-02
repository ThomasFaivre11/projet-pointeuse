FROM --platform=linux/arm64/v8 elixir:1.13.4-alpine AS build

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
# Copie du reste du code source
COPY . .
# Installation des outils Elixir et récupération des dépendances
RUN cd /app && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile
EXPOSE 4000

CMD ["mix", "phx.server"]
