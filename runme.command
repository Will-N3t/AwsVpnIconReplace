#!/bin/sh

set +e
set -x

# Assume default AWS VPN install directory
vpnName="AWS VPN Client"
uninstallName="Uninstall AWS VPN Client"

appDir="/Applications/AWS VPN Client/"

vpnDir="${appDir}/${vpnName}.app"
uninstallDir="${appDir}/${uninstallName}.app"

# Remove originals
sudo rm "${vpnDir}/Contents/Resources/acvc-16.png"
sudo rm "${vpnDir}/Contents/Resources/acvc-64.png"
sudo rm "${vpnDir}/Contents/Resources/AppIcon.icns"
sudo rm "${uninstallDir}/Contents/Resources/AppIcon.icns"

# Replace with new
sudo cp ./resources/acvc-16.png "${vpnDir}/Contents/Resources"
sudo cp ./resources/acvc-64.png "${vpnDir}/Contents/Resources"
sudo cp ./resources/AppIcon.icns "${vpnDir}/Contents/Resources"
sudo cp ./resources/AppIcon.icns "${uninstallDir}/Contents/Resources"

# Reload the dock
sudo touch "${vpnDir}"
sudo killall Finder
sudo killall Dock

# Kill and restart the VPN
sudo killall "${vpnName}"
sudo open "${vpnDir}"