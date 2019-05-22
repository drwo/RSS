FROM drwo/rdocker
LABEL maintainer="Tom Woteki <drwo@vt.edu>"

# We install the following Linux libraries that are required for knitting to PDFs
# do this here to avoid constantly rebuilding this layer as we modify any layers below
RUN apt-get -y install texinfo && \
  apt-get -y install texlive-fonts-extra && \
  apt-get -y install pandoc

# Add the S6 overlay needed to run RStudioServer as a daemon server
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && rm -R /tmp/*
# copy the run and finish scripts for S6
COPY run.rstudio.sh /etc/services.d/rstudio/run
COPY finish.rstudio.sh /etc/services.d/rstudio/finish

# Install RStudioServer
RUN apt update \
  && apt -y upgrade \
  && apt-get install -y systemd wget gdebi-core psmisc sudo libssl1.0.0 \
  && wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb \ 
  && gdebi --q --n rstudio-server-1.1.463-amd64.deb \
  && chmod 777 /etc/rstudio/rserver.conf \
  && echo "auth-required-user-group=rstudio" >> /etc/rstudio/rserver.conf \
  && chmod 755 /etc/rstudio/rserver.conf
  
# create non-sudo user rstudio with password rstudio
# this account can be used by anyone to log into the server
RUN useradd rstudio \
  && echo rstudio:rstudio | chpasswd \
  && mkdir /home/rstudio \
  && chown rstudio:rstudio /home/rstudio \
  && addgroup rstudio staff

EXPOSE 8787

CMD ["/init"]