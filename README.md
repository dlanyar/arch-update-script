# System Update and Cleanup Script

## Description
This Bash script automates the update and cleanup process for an Arch Linux-based system. It updates the package database, upgrades installed packages (including AUR if `yay` is available), removes orphaned packages, cleans up package cache, user cache, and system logs.

## Features
- Updates the package database with `pacman -Sy`
- Upgrades installed packages, including AUR packages if `yay` is installed
- Removes orphaned (unused) packages
- Cleans the package cache (keeps the last 3 versions if `paccache` is installed)
- Cleans the `~/.cache` directory
- Checks and cleans system logs older than 7 days

## Requirements
- Arch Linux or an Arch-based distribution
- `sudo` privileges
- `pacman` package manager
- `yay` (optional, for AUR package updates)
- `paccache` (optional, part of `pacman-contrib`, for cache cleanup)

## Usage
### Run the script
```bash
./script.sh
```
If the script does not have execution permissions, grant them with:
```bash
chmod +x script.sh
```
Then run it again.

## Notes
- If `yay` is not installed, AUR packages will not be updated.
- If `paccache` is not installed, the package cache cleanup will not run.
- This script removes orphaned packages and cleans caches without confirmation.

## License
This script is provided as-is, without any warranty. Use it at your own risk.

