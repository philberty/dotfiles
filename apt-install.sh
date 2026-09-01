#!/usr/bin/env bash
set -ex

apt isntall tmux \
    build-essential \
    flex \
    bison \
    swig \
    git \
    clangd \
    emacs \
    clang-format \
    default-jdk \
    flex \
    bison \
    cmake \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-xkb1 \
    wget \
    curl \
    python3-pip

wget https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-x64-online.run
