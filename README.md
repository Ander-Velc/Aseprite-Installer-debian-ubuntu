# Aseprite-Installer-debian-ubuntu

<img width="533" height="300" alt="tumblr_static_tumblr_static_44z6demav7cwk0sw4kocs4ss4_focused_v3" src="https://github.com/user-attachments/assets/fabfa5da-e542-4ea3-9a9d-eb71967d3ca9" />

<img width="224" height="225" alt="images" src="https://github.com/user-attachments/assets/af72bfb6-28ac-4048-b213-f5d03e994155" />

<p align="center">
  <img width="533" height="300" alt="tumblr_static_tumblr_static_44z6demav7cwk0sw4kocs4ss4_focused_v3" src="https://github.com/user-attachments/assets/fabfa5da-e542-4ea3-9a9d-eb71967d3ca9" />
</p>

A script that installs aseprite for free in debian and ubuntu distributions


# Quick install:

Get the aseprite-installer.sh

```
chmod +x aseprite-installer.sh
bash aseprite-installer.sh
```

# Code:

```

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

confirm_prompt() {
	read -r -p "$1" confirm
	[[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
}

echo -e "${yellow}[+++] Script installer by Ander -> ( https://github.com/ander-velc ) [+++]\n\n${end}"

confirm_prompt "${red}[!] This script must be ran without being root... If you are root, then please do not run this script, you sure you want to continue? ${end} (y/N): "

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
echo -e "${red}[!] Warning: If you do not have an icon-theme as papirus, you won't see the aseprite icon on desktop${end}"
confirm_prompt "${green}[+] Do you want to install it?${end} (y/N): "
sudo apt update
sudo apt install papirus-icon-theme

echo -e "${red}[!] Warning: Now you have to access to tweaks (gnome) or your Appearance and set it as Papirus${end}"

```
