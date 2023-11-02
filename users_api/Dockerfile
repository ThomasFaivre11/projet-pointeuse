FROM --platform=linux/arm64/v8 elixir:1.13.4-alpine AS build

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
COPY . .
RUN cd /app
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
EXPOSE 4000

