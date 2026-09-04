#!/usr/bin/env bash
set -ex

apt update

apt install -y \
    tmux \
    build-essential \
    flex \
    bison \
    swig \
    git \
    clangd \
    clang-format \
    emacs \
    default-jdk \
    cmake \
    wget \
    curl \
    python3-pip \
    python3-venv \
    python-is-python3 \
    ack \
    ccache \
    golang-go \
    dotnet-sdk-10.0 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-xkb1 \
    libxcb-cursor0 \
    libxcb-cursor-dev \
    libxcb-xinerama0 \
    libgl-dev \
    libegl-dev \
    libglx-dev \
    libglu1-mesa-dev
