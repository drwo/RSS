FROM rdocker

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN apt update \
  && apt -y upgrade \
  && apt-get install -y systemd wget gdebi-core psmisc sudo libssl1.0.0 

RUN wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb \ 
  && gdebi --q --n rstudio-server-1.1.463-amd64.deb \
  && chmod 777 /etc/rstudio/rserver.conf \
  && echo "auth-required-user-group=rstudio" >> /etc/rstudio/rserver.conf \
  && chmod 755 /etc/rstudio/rserver.conf
  
# We install the following Linux libraries that are required for knitting to PDFs
# do this hre to avoid constantly rebuilding this layer as we modify any layers below
RUN apt-get -y install texinfo && \
  apt-get -y install texlive-fonts-extra && \
  apt-get -y install pandoc

# create non-sudo user rstudio and sudo user rstudioadmin
ARG ADMIN_PASSWD="RStudio@\$Warrior99"
RUN useradd rstudio \
  && echo rstudio:rstudio | chpasswd \
  && mkdir /home/rstudio \
  && chown rstudio:rstudio /home/rstudio \
  && addgroup rstudio staff \
  && useradd rstudioadmin \
  && echo rstudioadmin:${ADMIN_PASSWD} | chpasswd \
  && mkdir /home/rstudioadmin \
  && chown rstudioadmin:rstudioadmin /home/rstudioadmin \
  && addgroup rstudioadmin staff \
  && addgroup rstudioadmin rstudio \
  && addgroup rstudioadmin sudo


COPY ./rssdocker/run.rstudio.sh /etc/services.d/rstudio/run
COPY ./rssdocker/finish.rstudio.sh /etc/services.d/rstudio/finish

EXPOSE 8787

CMD ["/init"]