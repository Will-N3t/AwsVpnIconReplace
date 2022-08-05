#!/bin/sh

set +e
set -x

# Assume default AWS VPN install directory
appName="AWS VPN Client"
appRemoveName="Uninstall AWS VPN Client"
appDir="/Applications/AWS VPN Client/${appName}.app"
appRemoveDir="/Applications/AWS VPN Client/${appRemoveName}.app"

# Remove originals
sudo rm "${appDir}/Contents/Resources/acvc-16.png"
sudo rm "${appDir}/Contents/Resources/acvc-64.png"
sudo rm "${appDir}/Contents/Resources/AppIcon.icns"
sudo rm "${appRemoveDir}/Contents/Resources/AppIcon.icns"

# Replace with new
sudo cp ./resources/acvc-16.png "${appDir}/Contents/Resources"
sudo cp ./resources/acvc-64.png "${appDir}/Contents/Resources"
sudo cp ./resources/AppIcon.icns "${appDir}/Contents/Resources"
sudo cp ./resources/AppIcon.icns "${appRemoveDir}/Contents/Resources"

# Reload the dock
sudo touch "${appDir}"
sudo killall Finder
sudo killall Dock

# Kill and restart the VPN
sudo killall "${appName}"
sudo open "${appDir}"