# composer global require "laravel/lumen-installer"
# lumen new site

# composer create-project symfony/website-skeleton my_project

docker-compose -f "docker-compose.yml" down && \
docker-compose -f "docker-compose.yml" up --build
# docker-compose -f "docker-compose.yml" up -d --build