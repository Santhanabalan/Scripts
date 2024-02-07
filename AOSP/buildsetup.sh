#!/bin/bash
# This script sets up the build environment for Android ROM

# Exit on any error
set -e

# Get input from user
read -p "Enter ROM name: " rom_name
read -p "Enter your email: " user_email
read -p "Enter your name: " user_name

# Add the OpenJDK repository
sudo add-apt-repository -y ppa:openjdk-r/ppa

# Update the package list
sudo apt-get update

# Install necessary packages
sudo apt install -y openssh-server screen python git openjdk-8-jdk android-tools-adb bc bison \
build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses-dev \
lib32readline-dev lib32z1-dev  liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev \
libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev \
libtinfo5 libncurses5

# Create bin directory in home if it doesn't exist
mkdir -p ~/bin

# Add bin to PATH
export PATH=~/bin:$PATH

# Download repo tool
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

# Make repo executable
chmod a+x ~/bin/repo

# Clone scripts repository
git clone https://github.com/akhilnarang/scripts.git ~/bin/scripts

# Run android build environment setup script
bash ~/bin/scripts/setup/android_build_env.sh

# Create rom directory in home if it doesn't exist
mkdir -p ~/$rom_name

# Change directory to rom
cd ~/$rom_name

# Set git global configuration
git config --global user.email "$user_email"
git config --global user.name "$user_name" 

# Download and install pdup tool
sudo wget https://raw.githubusercontent.com/Fornax96/pdup/master/pdup -O "/usr/local/bin/pdup"
sudo chmod +x "/usr/local/bin/pdup"