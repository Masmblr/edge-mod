#!/bin/bash
set -e

echo -e "\e[0;36m Installing EDGE build dependencies.."
sudo apt update
sudo apt install -y build-essential cmake git libsdl2-dev libopenal-dev \
libjpeg-dev libvorbis-dev zlib1g-dev libglew-dev libcurl4-openssl-dev \
libpng-dev libspeex-dev libogg-dev bison zip libsdl1.2-dev libsdl1.2debian lib32z1 lib32stdc++6

echo -e "Make sure \e[1;32mtremulous-1.1.0.zip\e[0m and \e[1;32mtremulous-gpp1.zip\e[0m are in \e[1;32m~/Downloads\e[0m"
read -p "Press ENTER to continue when ready.."

cd ~/Downloads

echo -e "\e[0;36m Extracting Tremulous.."
unzip -o tremulous-1.1.0.zip
unzip -o tremulous-gpp1.zip

git clone https://github.com/Masmblr/edge-mod.git || true
chmod -R +x edge-mod/
cd edge-mod
./build_project.sh

echo -e "\e[0;36m Copying.."
cp -r build/Tremulous/* ../tremulous/
chmod -R +x ../tremulous

echo -e "\e[0;36m Edge successfully installed."
