# composer global require "laravel/lumen-installer"
# lumen new site

# composer create-project symfony/website-skeleton site 3.4

docker-compose -f "docker-compose.yml" down && \
docker-compose -f "docker-compose.yml" up -d --build