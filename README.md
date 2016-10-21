# t3kit_docker

t3kit_docker helps you developing t3kit based TYPO3 CMS projects.

It uses DockerT3kit which creates the necessary Docker containers to run your t3kit based TYPO3 CMS project on your 
local development environment.

To initiate new project:

    git clone https://github.com/t3kit/t3kit_docker ~/path_to_your_project
    cd ~/path_to_your_project
    ./init.sh

Init script will ask you for the site folder name which will be also used as the domain name for your site. 
For example, if you name your site `local.your-site-name` Your TYPO3 installation will be located in 
`~/path_to_your_project/shared/local.your-site-name` and can be accessed from `http://local.your-site-name/` domain.

## Good to know:

DockerT3kit uses port 80 for web access so you need to make sure that your host machine does not have any software
using that port. Usually this happens if you have apache or nginx installed in your host machine, so you can stop it with:

    sudo service apache2 stop
    sudo service nginx stop

## Starting Docker containers

To get Docker container up and running:

    cd ~/path_to_your_project/shared/local.your-site-name
    vendor/bin/dockert3kit up -d

The parameter `-d` will keep it running in the background as process.

On the first run the DockerT3kit creates the database and creates sample data to it.

## Access project url when inside `app` container

As of current docker doesn't support bi-directional link, you cannot access web container from app container.
But in some case you will need this connection. For example in behat tests without selenium, you need the url of
your site in `Testing` context while running the tests has to be done inside the `app` container.

DockerT3kit adds additional script after starting all containers to fetch the IP address of web container and
append it to `/etc/hosts` inside app container as below:

    0.0.0.0    local.your-site-name
    0.0.0.0    test.local.your-site-name

## Stopping Docker containers

    cd ~/path_to_your_project/shared/local.your-site-name
    vendor/bin/dockert3kit stop

## Removing Docker containers

    cd ~/path_to_your_project/shared/local.your-site-name
    vendor/bin/dockert3kit kill
    vendor/bin/dockert3kit rm
    
*Note:* Removing Docker container will also remove database and all changes will be lost

## Check the status

    cd ~/path_to_your_project/shared/local.your-site-name
    vendor/bin/dockert3kit ps

This will show the running containers. 

## Running a shell in one of the service containers

    vendor/bin/dockert3kit run SERVICE /bin/bash

SERVICE can currently be `app`, `web`, `data`, `db` or `solr`.

## Requirements

To use the t3kit with docker you need to have following installed on your local machine:

* Docker
* Docker compose
* Composer

## More info about DockerT3kit

For more details about DockerT3kit, please [read about it here](https://github.com/laurisaarni/DockerT3kit)
