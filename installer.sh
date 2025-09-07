#!/bin/bash
# Auto-installer for CookieTUI

echo "=== CookieTUI ==="
echo "v1.2 Alpha"
echo "Written by Nebuff"
sleep 1
echo "[!] YOU MUST HAVE A INTERNET CONNECTION AND SUDOERS/ROOT PRIVLEDGES"
sleep 3
echo "[!] Proceeding with Install"
echo "[+] Updating Package Manager"
sudo apt update
echo "[+] Checking for Python"
# Check for Python3
if ! command -v python3 &> /dev/null
then
    echo "[!] Python not installed, Installing"
    sudo apt update
    sudo apt install -y python3 python3-venv
fi

echo "[+] Checking for Pip"
# Check for pip
if ! command -v pip &> /dev/null
then
    echo "[!] PIP Not Installed, Installing"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    rm get-pip.py
fi

echo "[*] Pip and Python Installed/Updated"

# Install dependencies
echo "[+] Installing dependencies..."
pip install --upgrade textual --break-system-packages

echo "[+] Creating Install"
# Create installation folder
INSTALL_DIR="$HOME/.cookie_tui"
mkdir -p "$INSTALL_DIR"

# Download base.py
echo "[+] Downloading CookieTUI..."
curl -L -o "$INSTALL_DIR/base.py" https://raw.githubusercontent.com/nebuff/CookieTUI/main/base.py

# Create a convenient command
echo "[+] Creating 'cookie' command..."
echo -e "#!/bin/bash\npython3 $INSTALL_DIR/base.py" > /usr/local/bin/cookie
sudo chmod +x /usr/local/bin/cookie

echo "=== Installation Complete ==="
echo "Run 'cookie' to start the Cookie TUI Game."
