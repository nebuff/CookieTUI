#!/bin/bash
# Auto-installer for CookieTUI

# Check for Python3
if ! command -v python3 &> /dev/null
then
    echo "Python3 is required but not installed. Please install Python3."
    exit 1
fi

# Check for pip
if ! command -v pip &> /dev/null
then
    echo "pip is required but not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    rm get-pip.py
fi

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade textual

# Create installation folder
INSTALL_DIR="$HOME/.cookie_tui"
mkdir -p "$INSTALL_DIR"

# Download base.py
echo "Downloading CookieTUI..."
curl -L -o "$INSTALL_DIR/base.py" https://raw.githubusercontent.com/nebuff/CookieTUI/main/base.py

# Create a convenient command
echo "Creating 'cookie' command..."
echo -e "#!/bin/bash\npython3 $INSTALL_DIR/base.py" > /usr/local/bin/cookie
chmod +x /usr/local/bin/cookie

echo "Installation complete! Run the game with:"
echo "cookie"
