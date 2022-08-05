#!/bin/bash

set +e

# Run in repo directory
cd "`dirname $0`"

# Assume default AWS VPN install directory
appName="AWS VPN Client"
appDir="/Applications/AWS VPN Client/${appName}.app"

# Remove originals
sudo rm "${appDir}/Contents/Resources/acvc-16.png"
sudo rm "${appDir}/Contents/Resources/acvc-64.png"
sudo rm "${appDir}/Contents/Resources/AppIcon.icns"

# Replace with new
sudo cp resources/acvc-16.png "${appDir}/Contents/Resources"
sudo cp resources/acvc-64.png "${appDir}/Contents/Resources"
sudo cp resources/AppIcon.icns "${appDir}/Contents/Resources"

# Issue instruction to click + drag icon over
open resources

sudo osascript -e "set aFile to (POSIX file \"${appDir}\") as text" \
          -e "tell application \"Finder\" to open information window of file aFile"

printf "\n\n\nDrag the new AppIcon file onto the existing orange icon to replace it, \n"
read -n 1 -s -r -p "then press any key to continue..."


# Kill the VPN
printf "\n\nKilling AWS VPN...\n"
sleep 2
sudo killall "${appName}"

# Reload the dock
sleep 2
sudo touch "${appDir}"

printf "\n\nRestarting UI...\n"
sleep 2
sudo killall Finder
sudo killall Dock

# Restart the VPN
printf "\n\nRestarting AWS VPN...\n"
sleep 2
sudo open "${appDir}"