FROM ubuntu

# update
RUN apt-get update

ENV TZ="America/New_York"
RUN apt-get install -y tzdata \
  && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata
  
# install R
ENV R_HOME /usr/lib/R
RUN apt-get update && \
  apt install -y apt-transport-https software-properties-common && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
  apt update && \
  apt upgrade -y && \
  apt-get install r-base r-base-core r-recommended -y

# create a directory for R scripts
RUN mkdir -p /usr/local/bin/R
# copy the load.packages script
COPY ./scripts/load.packages.R /usr/local/bin/R/load.packages.R
# load package Rcpp
RUN  chmod 775 /usr/local/bin/R/load.packages.R && \
  Rscript /usr/local/bin/R/load.packages.R Rcpp

# install these libraries needed to install R tidyverse then tidyverse itself
RUN apt-get install -y libssl-dev && \
  apt-get install -y libxml2-dev && \
  apt-get install -y libcurl4-openssl-dev && \
  Rscript /usr/local/bin/R/load.packages.R tidyverse

# install these additional pacakges
ARG XTRA_PKGS="caTools bitops rprojroot rmarkdown knitr"
ARG XTRA_PKGS=${XTRA_PKGS}" shiny data.table  ggmap maptools ineq"
RUN Rscript /usr/local/bin/R/load.packages.R ${XTRA_PKGS}

ENTRYPOINT ["/bin/bash", "--"]
