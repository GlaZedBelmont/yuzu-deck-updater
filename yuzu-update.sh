#!/bin/bash

# Your yuzu folder, hopefully
YUZU_DIR="/home/deck/.local/share/yuzu"
# Get latest version (yellows8 my beloved)
FW_VERSION=$(curl https://yls8.mtheall.com/ninupdates/feed.php | grep -m 1 "Switch" | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

# Grab latest EA Yuzu
curl -s https://api.github.com/repos/pineappleEA/pineapple-src/releases/latest | jq -r ".assets[0] | .browser_download_url" | wget -qO "/home/deck/Applications/yuzu.AppImage" --show-progress -i -
chmod +x /home/deck/Applications/yuzu.AppImage

# Get latest keys (mind the URL)
wget -qO "$YUZU_DIR/keys/prod.keys" --show-progress "https://sigmapatches.coomer.party/prod.keys"

# Get latest firmware and extract it
wget -qO "$YUZU_DIR/nand/system/Contents/registered/firmware.zip" --show-progress "https://archive.org/download/nintendo-switch-global-firmwares/Firmware%20$FW_VERSION.zip"

unzip -q $YUZU_DIR/nand/system/Contents/registered/firmware.zip -d $YUZU_DIR/nand/system/Contents/registered/
rm $YUZU_DIR/nand/system/Contents/registered/firmware.zip
