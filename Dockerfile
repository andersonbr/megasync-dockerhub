FROM debian:stretch
LABEL maintainer "Anderson Calixto" <andersonbr@gmail.com>

# Install MATE and VNC server.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y gnupg mate-desktop-environment-core tightvncserver apt-transport-https && \
  rm -rf /var/lib/apt/lists/*

# Megasync
RUN echo deb https://mega.nz/linux/MEGAsync/Debian_9.0/ ./ > \
	/etc/apt/sources.list.d/megasync_tmp.list && \
	apt-get update && \
	apt-get install --allow-unauthenticated -y megasync && \
	rm /etc/apt/sources.list.d/megasync_tmp.list

RUN mkdir -p /root/.config/autostart
ADD megasync.desktop /root/.config/autostart/megasync.desktop

ADD run.sh /run.sh
RUN chmod +x /run.sh

RUN mkdir /root/.vnc && echo "debian" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd && touch /root/.Xresources

# Expose ports.
EXPOSE 5901

# Define working directory.
WORKDIR /data

# vnc server
CMD ["/run.sh"]