#!/bin/bash

# Your yuzu folder, hopefully
YUZU_DIR="/home/deck/.local/share/yuzu"
# Get latest version (yellows8 my beloved)
FW_VERSION=$(curl -s https://yls8.mtheall.com/ninupdates/feed.php | grep -m 1 "Switch" | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

echo "Yuzu Updater Script V1.0"

# Grab latest EA Yuzu
curl -s https://api.github.com/repos/pineappleEA/pineapple-src/releases/latest | jq -r ".assets[0] | .browser_download_url" | wget -qO "/home/deck/Applications/Yuzu.AppImage" -i - && echo "Downloaded latest Yuzu AppImage"
chmod +x "/home/deck/Applications/Yuzu.AppImage"

# Get latest keys (mind the URL)
wget -qO "$YUZU_DIR/keys/prod.keys" "https://sigmapatches.coomer.party/prod.keys" && echo "Downloaded keys for $FW_VERSION"

# Get latest firmware and extract it
wget -qO "$YUZU_DIR/nand/system/Contents/registered/firmware.zip" "https://archive.org/download/nintendo-switch-global-firmwares/Firmware%20$FW_VERSION.zip" && echo "Downloaded firmware $FW_VERSION"

rm -f $YUZU_DIR/nand/system/Contents/registered/*.nca
unzip -q "$YUZU_DIR/nand/system/Contents/registered/firmware.zip" -d "$YUZU_DIR/nand/system/Contents/registered/" && echo "Extracted firmware"
rm "$YUZU_DIR/nand/system/Contents/registered/firmware.zip"
