# Docker/Symfony Project
Docker/Symfony Project with EasyAdmin

The purpose of this project is to act as an initial seed for Symfony 3.3/4.x projects using Docker (docker-compose not yet supported).

## Installing
This project is built using a serious of bash scripts. However, if you do not have bash installed, you should be able to run the docker commands individually within each script.

#### Update configuration
Update the configurations in the following files

* bin/config.inc
* docker/mysql/Dockerfile (database settings)
* docker/nginx/docker-web.conf (website/server settings)
* docker/symfony/web-php.ini (php.ini settings)

#### Build Docker Images/Containers
`$ sh bin/build.sh`

*Note:* For your personal server, consider running the bin/build-prod.sh script which removes the local volume linking and run nginx on port 80.

##### Log into the *php* container and run the entry script
`$ docker exec -it symfonyapp bash`
`$ sh entrypoint.sh`

#### Destroying Images/Containers
`$ sh bin/destroy.sh`

#### Stopping/Restarting Images/Containers
`$ sh bin/stop.sh`
`$ sh bin/restart.sh`

## Symfony Clear Cache
Since docker is weird, you should run the 'cc' script to clear the cache.

`$ cc`

## View Admin
At this point your symfony application should be ready to go and you can visit the following url (if your hosts file is setup properly)

`http://symfony-local.dev:8080/admin`
