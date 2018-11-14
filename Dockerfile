FROM debian:stretch
LABEL maintainer "Anderson Calixto" <andersonbr@gmail.com>

# Install MATE and VNC server.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y gnupg mate-desktop-environment-core tightvncserver apt-transport-https && \
  rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

# Expose ports.
EXPOSE 5901

# Megasync
RUN echo deb https://mega.nz/linux/MEGAsync/Debian_9.0/ ./ > \
	/etc/apt/sources.list.d/megasync_tmp.list && \
	apt-get update && \
	apt-get install --allow-unauthenticated -y megasync && \
	rm /etc/apt/sources.list.d/megasync_tmp.list

COPY ./autostart /root/.config/autostart

RUN mkdir /root/.vnc && echo "debian" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd
