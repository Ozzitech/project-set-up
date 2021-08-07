#!/bin/sh

# make executable - chmod +x setup-strapi.sh

# Ask the user for their name
echo Hello, what\'s the project name?
read PROJECT_NAME
echo What Port do you want it to run on?
read PORT_NUMBER
echo The project name is $PROJECT_NAME and port number is $PORT_NUMBER
npx create-strapi-app $PROJECT_NAME --quickstart

cat <<EOT >> $PROJECT_NAME/docker-compose.yml                             
 version: "3"
 services:
   strapi:
     image: strapi/strapi
     volumes:
       - ./app:/srv/app
     ports:
       - "$PORT_NUMBER:1337"
EOT

cat <<EOT >> $PROJECT_NAME/README.md                             
# $PROJECT_NAME

## Set up Strapi

### Using yarn
- run \`yarn install\`
- to run the CMS in dev mode run \`yarn develop\`
- run \`yarn start\` to run CMS in non dev mode.

### Using docker
- run \`docker-compose pull\`
- Execute Docker image detaching the terminal \`docker-compose up -d\`
- Execute Docker image without detaching the terminal \`docker-compose up\`

EOT

cd $PROJECT_NAME