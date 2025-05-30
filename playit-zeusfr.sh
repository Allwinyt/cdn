#!/bin/bash

echo "🔧 Setting up the Playit tunnel... Sit tight, warrior."

echo "📥 Fetching GPG key..."
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null

echo "📡 Adding Playit to your APT sources..."
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list

echo "🔄 Updating package list... Time to sync up 📡"
sudo apt update

echo "📦 Installing Playit like a boss..."
sudo apt install -y playit

echo "🚀 Launching Playit! Get ready to tunnel through the matrix..."
playit

