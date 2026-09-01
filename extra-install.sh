#!/usr/bin/env bash
set -ex

wget https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-x64-online.run

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 24
nvm alias default 24
