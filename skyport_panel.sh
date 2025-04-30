#!/bin/bash

# Display the banner
cat << "EOF"

    ___    ____         _             __           __     _______ __  __  __      __  
   /   |  / / /      __(_)___  __  __/ /_   ____ _/ /_   / ____(_) /_/ / / /_  __/ /_ 
  / /| | / / / | /| / / / __ \/ / / / __/  / __ `/ __/  / / __/ / __/ /_/ / / / / __ \
 / ___ |/ / /| |/ |/ / / / / / /_/ / /_   / /_/ / /_   / /_/ / / /_/ __  / /_/ / /_/ /
/_/  |_/_/_/ |__/|__/_/_/ /_/\__, /\__/   \__,_/\__/   \____/_/\__/_/ /_/\__,_/_.___/ 
                            /____/                                                    
                                                          
EOF

echo "🔑 Setting up NodeSource repository for Node.js..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo "🚀 Updating system packages..."
sudo apt update

echo "📦 Installing Node.js and Git..."
sudo apt install -y nodejs git

echo "🌐 Cloning the skyport repository..."
git clone https://github.com/Allwinyt/skyport

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone the repository."
  exit 1
fi

echo "📂 Changing directory to panel..."
cd skyport || { echo "❌ Failed to change directory to skyport."; exit 1; }

echo "📦 Installing Node dependencies..."
npm install

echo "🌱 Seeding the database..."
npm run seed

echo "👤 Creating a new user..."
npm run createUser

echo "🚀 Starting skyport..."
node .
