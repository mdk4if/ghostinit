# Hyprland Setup Script

This Bash script automates the installation and configuration of a Hyprland desktop environment on Arch Linux systems with NVIDIA proprietary drivers. It installs necessary packages, sets up the `yay` AUR helper, copies configuration files, and configures system services.

## Features
- Installs Hyprland and related packages (e.g., `waybar`, `rofi`, `hyprlock`, etc.).
- Installs AUR packages (e.g., `zsh-theme-powerlevel10k`) using `yay`.
- Configures `zsh` as the default shell.
- Enables essential services like `NetworkManager` and `power-profiles-daemon`.
- Copies Hyprland configuration files from a specified Git repository or a local `.config` directory.
- Backs up existing `~/.config` directory before copying new configurations.
- Performs system checks for internet, NVIDIA hardware, CPU cores, and RAM.

## Prerequisites
- **Arch Linux**: The script is designed for Arch Linux or Arch-based distributions.
- **NVIDIA GPU with Proprietary Drivers**: The script assumes an NVIDIA GPU with proprietary drivers installed.
- **Internet Connection**: Required for package installation and Git operations.
- **Sudo Privileges**: The script must be run as a non-root user with `sudo` access.
- **Git Repository (Optional)**: If using custom configuration files, set the `CONFIG_GIT_REPO` environment variable to a Git repository URL containing a `.config` directory.

## Usage
1. **Clone or Download the Script**:
   ```bash
   git clone https://github.com/mdk4if/ghostinit.git
   cd ghostinit
   ```
   Replace `https://github.com/mdk4if/ghostinit.git` with your repository URL.

2. **Make the Script Executable**:
   ```bash
   chmod +x hyprland_setup.sh
   ```

3. **Run the Script**:
   ```bash
   ./hyprland_setup.sh [-v]
   ```
   - `-v`: Enable verbose output (enabled by default).

4. **Optional: Specify Configuration Repository**:
   If you have a Git repository with Hyprland configuration files, set the `CONFIG_GIT_REPO` environment variable:
   ```bash
   export CONFIG_GIT_REPO="https://github.com/your-username/your-config-repo.git"
   ./hyprland_setup.sh
   ```
   Alternatively, place configuration files in a `.config` directory in the same folder as the script.

5. **Log Out and Start Hyprland**:
   After the script completes, log out and select Hyprland from your display manager (e.g., GDM, SDDM), or start it manually:
   ```bash
   Hyprland
   ```

## Installed Packages
### Pacman Packages
- `bash-completion`, `brightnessctl`, `btop`, `chafa`, `firefox`, `foot`, `fzf`, `ghostty`, `git`, `hyprland`, `hyprlock`, `hyprpaper`, `hyprpolkitagent`, `hyprshot`, `imagemagick`, `lsd`, `ncdu`, `neovide`, `neovim`, `net-tools`, `networkmanager`, `nitch`, `nodejs`, `npm`, `nwg-look`, `pavucontrol`, `pipewire`, `power-profiles-daemon`, `rofi`, `sassc`, `swaync`, `ttf-firacode-nerd`, `ttf-jetbrains-mono-nerd`, `waybar`, `wayland-protocols`, `wireplumber`, `wl-clipboard`, `xclip`, `xdg-desktop-portal-hyprland`, `xorg-server`, `xorg-xinit`, `xorg-xwayland`, `zsh`

### AUR Packages
- `zsh-theme-powerlevel10k`

## Notes
- **Backup**: The script backs up your existing `~/.config` directory to `~/.config_backup_<timestamp>` before copying new configurations.
- **NVIDIA Drivers**: Ensure NVIDIA proprietary drivers are installed before running the script. The script checks for their presence.
- **System Requirements**: The script warns if your system has fewer than 2 CPU cores or less than 4GB of RAM, as this may impact performance.
- **Services**: `NetworkManager` and `power-profiles-daemon` are enabled and started automatically.
- **zsh**: The script sets `zsh` as the default shell. Ensure you have a compatible terminal (e.g., `foot` or `ghostty`) installed.

## Troubleshooting
- **Authentication Errors**: If you encounter Git authentication issues, use a Personal Access Token (PAT) or SSH key for GitHub operations. See [GitHub's documentation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for details.
- **Merge Conflicts**: If pushing to GitHub fails due to remote changes, run:
  ```bash
  git pull origin main --rebase
  ```
  Then resolve conflicts and retry:
  ```bash
  git push -u origin main
  ```
- **Package Installation Failures**: Ensure a stable internet connection and that the Arch Linux mirrors are up-to-date (`sudo pacman -Syy`).
- **Missing Configurations**: If no `.config` directory or `CONFIG_GIT_REPO` is provided, the script will exit with an error.

## Contributing
Contributions are welcome! Please fork the repository, make changes, and submit a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.



### Next Steps
To upload this `README.md` to your GitHub repository (`https://github.com/mdk4if/ghostinit.git`), follow these steps in your terminal:

1. **Navigate to Your Repository**:
   ```bash
   cd /path/to/your/ghostinit
   ```

2. **Add the README.md File**:
   ```bash
   git add README.md
   ```

3. **Commit the Changes**:
   ```bash
   git commit -m "Add README.md for Hyprland setup script"
   ```

4. **Resolve the Previous Push Error**:
   Since you encountered a `rejected` push error, pull the remote changes first:
   ```bash
   git pull origin main --rebase
   ```
   - If conflicts occur, resolve them as described in the previous response (edit conflicting files, `git add <file>`, `git rebase --continue`).
   - If no conflicts, the pull will complete automatically.

5. **Push to GitHub**:
   ```bash
   git push -u origin main
   ```
   - Use your GitHub username (`mdk4if`) and a Personal Access Token (PAT) when prompted, as discussed earlier. Alternatively, ensure you’ve set up SSH authentication to avoid credential prompts.

6. **Verify on GitHub**:
   - Visit `https://github.com/mdk4if/ghostinit` to confirm that `README.md` appears in the repository.

If you encounter any errors during the push (e.g., authentication or conflicts), let me know the specific error message, and I’ll guide you through resolving it!
