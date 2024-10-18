#!/bin/bash

# Variables
OLD_NAME="YourAddon"
NEW_NAME="NewAddonName"

# Find and replace in .lua files in src directory, and .toc, .pkgmeta files in the current directory
find ./src -type f -name "*.lua" -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +
find . -maxdepth 1 -type f \( -name "*.toc" -o -name "*.pkgmeta" \) -exec sed -i "s/$OLD_NAME/$NEW_NAME/g" {} +

echo "Replacement complete."