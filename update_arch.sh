#!/bin/bash

# Update the package database
echo "Updating the package database..."
sudo pacman -Sy

# Update all installed packages (including AUR packages with yay)
echo "Updating installed packages (including AUR)..."
sudo pacman -Su --noconfirm
if command -v yay &> /dev/null; then
    yay -Su --noconfirm
else
    echo "yay is not installed. Skipping AUR package updates."
fi

# Remove orphaned (unused) packages
echo "Removing orphaned packages..."
ORPHANED_PACKAGES=$(pacman -Qdtq)
if [ -z "$ORPHANED_PACKAGES" ]; then
    echo "No orphaned packages to remove."
else
    echo "Found orphaned packages:"
    echo "$ORPHANED_PACKAGES"
    sudo pacman -Rns $ORPHANED_PACKAGES --noconfirm
fi

# Clean the package cache (keep the last 3 versions) if paccache is installed
if command -v paccache &> /dev/null; then
    echo "Cleaning the package cache..."
    sudo paccache -r
    sudo paccache -ruk0
else
    echo "paccache is not installed. To clean the package cache, install pacman-contrib."
fi

# Clean the ~/.cache directory
echo "Checking user cache size..."
CACHE_SIZE=$(sudo du -sh ~/.cache | cut -f1)
echo "User cache size: $CACHE_SIZE"

echo "Cleaning user cache..."
rm -rf ~/.cache/*
echo "User cache cleaned."

# Clean system logs
echo "Checking system log size..."
JOURNAL_SIZE=$(journalctl --disk-usage | awk '{print $7}')
echo "System log size: $JOURNAL_SIZE"

echo "Cleaning system logs (removing logs older than 7 days)..."
sudo journalctl --vacuum-time=7d
echo "System logs cleaned."

echo "Update and cleanup completed!"
