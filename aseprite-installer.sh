#!/bin/bash

# Colors
green=$'\033[1;32m'
end=$'\033[0m'
red=$'\033[1;31m'
blue=$'\033[1;34m'
yellow=$'\033[1;33m'
purple=$'\033[1;35m'
cyan=$'\033[1;36m'
gray=$'\033[1;37m'

echo -e "${yellow}[+++] Script installer by Ander -> ( https://github.com/ander-velc ) [+++]\n\n${end}"

sudo apt update
sudo apt install wget

mkdir -p ~/Aseprite-Installer
cd ~/Aseprite-Installer

wget https://github.com/aseprite/aseprite/releases/download/v1.3.17.1/Aseprite-v1.3.17.1-Source.zip
unzip Aseprite-v1.3.17.1-Source.zip -d Aseprite-v1.3.17.1-Source

wget https://github.com/aseprite/skia/releases/download/m124-08a5439a6b/Skia-Linux-Release-x64.zip
mkdir -p ~/deps
unzip Skia-Linux-Release-x64.zip -d ~/deps/skia

cd ~/

echo -e "${green}[+] Installing packages${end}"

sudo apt-get install -y g++ clang cmake ninja-build libx11-dev libxcursor-dev libxi-dev libxrandr-dev libgl1-mesa-dev libfontconfig1-dev extra-cmake-modules libkf5kio-dev

sudo apt install extra-cmake-modules libkf5kio-dev -y

echo -e "${green}[+] Packages successfully installed${end}"

cd ~/Aseprite-Installer/Aseprite-v1.3.17.1-Source/

echo -e "${green}[+] Exporting variables${end}"

export CC=gcc
export CXX=g++

mkdir build
cd build

echo -e "${green}[+] Building... This may take some minutes${end}"

cmake \
-DSKIA_DIR=$HOME/deps/skia \
-DSKIA_LIBRARY_DIR=$HOME/deps/skia/out/Release-x64 \
-DSKIA_LIBRARY=$HOME/deps/skia/out/Release-x64/libskia.a \
-DCMAKE_BUILD_TYPE=Release \
-DLAF_BACKEND=skia \
-DENABLE_PSD=ON \
-DENABLE_DESKTOP_INTEGRATION=ON \
-DENABLE_QT_THUMBNAILER=ON \
-G Ninja ..

ninja

echo -e "${green}[+] Installing yay...${end}"

sudo cmake --install . --prefix=/usr/local

echo -e "${green}[+] Script installed successfully${end}"
echo -e "${green}[+] Aseprite now avaible on your desktop apps${end}"
