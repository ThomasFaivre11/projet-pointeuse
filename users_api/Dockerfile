# Utilisation de l'image Elixir basée sur Debian
FROM elixir:1.15

# Eviter les questions/interactions pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Mise à jour et installation de paquets
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installation des dépendances Elixir
RUN mix local.hex --force && \
    mix local.rebar --force

# Définition du répertoire de travail
WORKDIR /app

# Copie des fichiers nécessaires pour l'installation des dépendances
COPY mix.exs mix.lock ./

# Installation des dépendances
RUN mix do deps.get, deps.compile

# Copie du reste des fichiers
COPY . .

# Exposition du port 4000
EXPOSE 4000
# Commande par défaut pour démarrer l'application
CMD ["mix", "phx.server"]
