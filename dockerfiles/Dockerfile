FROM ubuntu:20.04
LABEL org.opencontainers.image.title="Traversaro's Ubuntu 20.04 blank image with VNC support"
LABEL org.opencontainers.image.description="Infrastructure for running grasping experiments with the iCub humanoid in Gazebo"
LABEL org.opencontainers.image.source="https://github.com/traversaro/gitpod-ubuntu-20.04"
LABEL org.opencontainers.image.authors="Silvio Traversaro <silvio.traversaro@iit.it>"

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update apt database
RUN apt update

# Install essentials
RUN apt install -y apt-utils software-properties-common apt-transport-https sudo \
    psmisc tmux nano wget curl telnet gnupg gdb git gitk autoconf locales gdebi \
    terminator meld dos2unix meshlab

# Set the locale
RUN locale-gen en_US.UTF-8

# Install graphics
RUN apt install -y xfce4 xfce4-goodies xserver-xorg-video-dummy xserver-xorg-legacy x11vnc firefox && \
    apt remove -y xfce4-power-manager light-locker && \
    sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
COPY xorg.conf /etc/X11/xorg.conf
RUN dos2unix /etc/X11/xorg.conf

# Install python
RUN apt install -y python3 python3-dev python3-pip python3-setuptools
    
# Install other dependencies
RUN apt-get install -y bash-completion build-essential cmake cmake-curses-gui coinor-libipopt-dev curl freeglut3-dev git libace-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libdc1394-22-dev libedit-dev libeigen3-dev libgsl0-dev libjpeg-dev liblua5.1-dev libode-dev libopencv-dev libsdl1.2-dev libtinyxml-dev libv4l-dev libxml2-dev lua5.1 portaudio19-dev qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick2 qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev swig libmatio-dev libirrlicht-dev libspdlog-dev libblas-dev liblapack-dev wget sudo nlohmann-json3-dev zsh xonsh ninja-build 
    
# Install magic-wormwhole to get things from one computer to another safely
RUN apt install -y magic-wormhole

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    echo "<html><head><meta http-equiv=\"Refresh\" content=\"0; url=vnc.html?autoconnect=true&reconnect=true&reconnect_delay=1000&resize=scale&quality=9\"></head></html>" > /opt/novnc/index.html

# Set environmental variables
ENV DISPLAY=:1

# Create user gitpod
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
    # passwordless sudo for users in the 'sudo' group
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to gitpod user
USER gitpod

# Install informative git for bash
RUN git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Set up .bashrc
WORKDIR /home/gitpod
RUN echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc && \
    echo "source \${HOME}/.bash-git-prompt/gitprompt.sh" >> ~/.bashrc

# Create the Desktop dir
RUN mkdir -p /home/gitpod/Desktop

# Switch back to root
USER root

# Set up script to launch graphics and vnc
COPY start-vnc-session.sh /usr/bin/start-vnc-session.sh
RUN chmod +x /usr/bin/start-vnc-session.sh && \
    dos2unix /usr/bin/start-vnc-session.sh

# Manage ports
EXPOSE 5901 5900 6080 6942 10000/tcp 10000/udp 35900

##INSTALL ANDROID STUDIO
RUN add-apt-repository ppa:maarten-fonville/android-studio

RUN apt-get update

RUN apt-get install android-sdk lib32stdc++6 android-studio android-sdk-build-tools android-sdk android-sdk-platform-23 --no-install-recommends --yes \
        && apt-get clean
#         && rm -rf /var/lib/apt/lists/*
##================
# Clean up unnecessary installation products
RUN rm -Rf /var/lib/apt/lists/*

# Launch bash from /workspace
WORKDIR /workspace
CMD ["bash"]
