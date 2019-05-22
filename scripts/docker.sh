#!/bin/bash

# build rdocker in the project's directory
# docker image build -t rdocker -f ./rdocker/Dockerfile .
# build rdocker in the image's directory
docker image build -t rdocker -f ./rdocker/Dockerfile ./rdocker

# get a bash CLI in the container
docker container run --rm -it --name rdocker rdocker
# get an R CLI in the container
docker container run --rm -it --name rdocker rdocker R
# display the R version and exit
docker container run --rm --name rdocker rdocker R --version

# build rssdocker in the project's directory
# docker image build -t rssdocker -f ./rssdocker/Dockerfile .
# build rssdocker in the image's directory
docker image build -t rssdocker -f ./rssdocker/Dockerfile ./rssdocker
# run the server
docker container run --rm --name rssdocker -p 8787:8787 -d rssdocker
