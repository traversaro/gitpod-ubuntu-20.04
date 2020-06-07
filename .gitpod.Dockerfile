FROM ubuntu:20.04

RUN apt-get -q update && \
    apt-get install -yq libeigen3-dev libxml2-dev coinor-libipopt-dev qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev qml-module-qtquick2 qml-module-qtquick-window2 qml-module-qtmultimedia qml-module-qtquick-dialogs qml-module-qtquick-controls qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings libassimp-dev && \
    rm -rf /var/lib/apt/lists/*
