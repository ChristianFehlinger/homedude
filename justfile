# default recipe to display
default:
  @just --list

# start all container
up:
  docker-compose up -d

# updates all container
update:
  docker-compose pull

# stops all container
down:
  docker-compose down
