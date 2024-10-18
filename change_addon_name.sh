#!/bin/bash

# Variables
OLD_NAME="YourAddon"
NEW_NAME=$1

# Find and replace in .lua files in src directory, and .toc, .pkgmeta files in the current directory
find ./src -type f -name "*.lua" -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +
find . -maxdepth 1 -type f \( -name "*.toc" -o -name "*.pkgmeta" \) -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +
# Rename AddonName.toc to NEW_NAME.toc
if [ -f "AddonName.toc" ]; then
    mv "AddonName.toc" "${NEW_NAME}.toc"
fi

echo "Replacement complete."