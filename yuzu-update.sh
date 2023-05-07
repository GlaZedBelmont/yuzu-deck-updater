#!/bin/bash

# Your yuzu folder, hopefully
YUZU_DIR="/home/deck/.local/share/yuzu"
# Get latest version (yellows8 my beloved)
FW_VERSION=$(curl -s https://yls8.mtheall.com/ninupdates/feed.php | grep -m 1 "Switch" | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

echo -e "\e[95mYuzu Updater Script V1.0\e[0m"

# Grab latest EA Yuzu
echo -e "[ * ] Downloading latest Yuzu AppImage"
curl -s https://api.github.com/repos/pineappleEA/pineapple-src/releases/latest | jq -r ".assets[0] | .browser_download_url" | wget -q --show-progress -O "/home/deck/Applications/Yuzu.AppImage" -i - \
&& echo -e "\e[32m[ \u2714 ] Downloaded latest Yuzu AppImage\e[0m"
chmod +x "/home/deck/Applications/Yuzu.AppImage"

# Get latest firmware and extract it IF there's a new update
if [[ `echo $FW_VERSION | sed 's@\.@@g'` -eq `cat $YUZU_DIR/firmware.txt | sed 's@\.@@g'` ]]
then
    echo -e "[ \u2714 ] Firmware is already up-to-date"
else
    echo -e "\e[33m[ \u2716 ] Firmware outdated, `cat $YUZU_DIR/firmware.txt` -> $FW_VERSION\e[0m"
	echo -e "[ * ] Downloading firmware $FW_VERSION"
	wget -q --show-progress -O "$YUZU_DIR/nand/system/Contents/registered/firmware.zip" "https://archive.org/download/nintendo-switch-global-firmwares/Firmware%20$FW_VERSION.zip" \
	&& echo -e "\e[32m[ \u2714 ] Downloaded firmware $FW_VERSION\e[0m"
	rm -f $YUZU_DIR/nand/system/Contents/registered/*.nca
	unzip -q "$YUZU_DIR/nand/system/Contents/registered/firmware.zip" -d "$YUZU_DIR/nand/system/Contents/registered/" \
	&& echo -e "\e[32m[ \u2714 ] Extracted firmware\e[0m"
	rm "$YUZU_DIR/nand/system/Contents/registered/firmware.zip"
	echo $FW_VERSION > $YUZU_DIR/firmware.txt
fi

