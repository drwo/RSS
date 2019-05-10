FROM rdocker

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN apt update \
  && apt -y upgrade \
  && apt-get install -y systemd wget gdebi-core psmisc sudo libssl1.0.0 

RUN useradd rstudio \
  && echo rstudio:rstudio | chpasswd \
  && mkdir /home/rstudio \
  && chown rstudio:rstudio /home/rstudio \
  && addgroup rstudio staff

RUN wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb \ 
  && gdebi --q --n rstudio-server-1.1.463-amd64.deb \
  && chmod 777 /etc/rstudio/rserver.conf \
  && echo "auth-required-user-group=rstudio" >> /etc/rstudio/rserver.conf \
  && chmod 755 /etc/rstudio/rserver.conf
  
  
# the 1.2, below, version needs a library libssl.so.1.0.2 we can't find
# so, reverting to an ealier version above
# see similar discussion here:
#https://community.rstudio.com/t/rstudio-server-1-1-453-libcrypto-so-1-0-2/8661
# wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb && \
#  gdebi server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb

COPY ./rssdocker/run.rstudio.sh /etc/services.d/rstudio/run

EXPOSE 8787

# ENTRYPOINT ["/bin/bash", "--"]
CMD ["/init"]