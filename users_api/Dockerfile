FROM --platform=linux/arm64/v8 elixir:latest

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Installation des outils Elixir et récupération des dépendances
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile

# Copie du reste du code source
COPY . .

EXPOSE 4000

CMD ["mix", "phx.server"]
