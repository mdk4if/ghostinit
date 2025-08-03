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

2. **Make the Script Executable**:
   ```bash
   chmod +x setup.sh
   ```

3. **Run the Script**:
   ```bash
   ./setup.sh [-v]
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

## Contributing
Contributions are welcome! Please fork the repository, make changes, and submit a pull request.
6. **Verify on GitHub**:
   - Visit `https://github.com/mdk4if/ghostinit` to confirm that `README.md` appears in the repository.
