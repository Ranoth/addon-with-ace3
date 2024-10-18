#!/bin/bash

# Variables
OLD_NAME="YourAddon"
NEW_NAME=$1

# Fetch the latest interface version from the provided URL
INTERFACE_VERSION=$(curl -s https://warcraft.wiki.gg/wiki/Template:API_LatestInterface | grep -oP '(?<=<li><code>)[0-9]+(?=</code>)' | head -1)

# Check if INTERFACE_VERSION is empty
if [ -z "$INTERFACE_VERSION" ]; then
    echo "Failed to fetch the interface version."
    exit 1
fi

# Rename AddonName.toc to NEW_NAME.toc
if [ -f "AddonName.toc" ]; then
    mv "AddonName.toc" "${NEW_NAME}.toc"
fi

# Find and replace in .lua files in src directory, and .toc, .pkgmeta files in the current directory
find ./src -type f -name "*.lua" -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +
find . -maxdepth 1 -type f \( -name "*.toc" -o -name "*.pkgmeta" \) -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +

# Update the interface version in the .toc file
if [ -f "${NEW_NAME}.toc" ]; then
    sed -i "s/## Interface: .*/## Interface: ${INTERFACE_VERSION}/" "${NEW_NAME}.toc"
fi


echo "Replacement complete."