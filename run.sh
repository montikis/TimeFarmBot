#!/bin/bash

#Проверка обновления репозитория
git pull --allow-unrelated-histories #принудительное обновление

#установка библиотек если такие появились
pip install -r requirements.txt
#python3 --version

#dmesg | grep "Linux version"



# Проверка на наличие папки venv
if [ ! -d "venv" ]; then
    echo "💻 Creating virtual environment..."
    python3 -m venv venv
fi

echo "✅  Activating virtual environment..."
source venv/bin/activate

# Проверка на наличие установленного флага в виртуальном окружении
if [ ! -f "venv/installed" ]; then
    if [ -f "requirements.txt" ]; then
		echo "💬 Installing wheel for faster installing"
		pip3 install wheel
        echo "Installing dependencies..."
        pip3 install -r requirements.txt
        touch venv/installed
    else
        echo "📄 requirements.txt not found, skipping dependency installation."
    fi
else
    echo "💬 Dependencies already installed, skipping installation."
fi

if [ ! -f ".env" ]; then
	echo "💬 Copying configuration file"
	cp .env-example .env
else
	echo "💬 Skipping .env copying"
fi

echo "🤖 Starting the bot..."
python3 main.py

echo "✅ done"
echo "⚙️ PLEASE EDIT .ENV FILE"
