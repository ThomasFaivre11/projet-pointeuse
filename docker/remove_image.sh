#!/bin/bash
docker-compose down
docker rmi thomas1212/front_nuxt:latest thomas1212/back_elixir:latest --force
docker-compose pull webapp phoenix
docker-compose up
