#!/bin/bash

# Exit on any error
set -e

# Define variables
CONFIG_DIR="$HOME/.config"
AUR_HELPER="yay"
VERBOSE=true
PACKAGES=(
    bash-completion
    brightnessctl
    btop
    chafa
    firefox
    foot
    fzf
    ghostty
    git
    hyprland
    hyprlock
    hyprpaper
    hyprpolkitagent
    hyprshot
    imagemagick
    lsd
    ncdu
    neovide
    neovim
    net-tools
    networkmanager
    nitch
    nodejs
    npm
    nwg-look
    pavucontrol
    pipewire
    power-profiles-daemon
    rofi
    sassc
    swaync
    ttf-firacode-nerd
    ttf-jetbrains-mono-nerd
    waybar
    wayland-protocols
    wireplumber
    wl-clipboard
    xclip
    xdg-desktop-portal-hyprland
    xorg-server
    xorg-xinit
    xorg-xwayland
    zsh
)
AUR_PACKAGES=(
    zsh-theme-powerlevel10k
)

# Function to log messages
log() {
    if [[ "$VERBOSE" == true ]]; then
        echo "[INFO] $1"
    fi
}

# Function to check internet connectivity
check_internet() {
    log "Checking internet connectivity..."
    if ! ping -c 1 archlinux.org &>/dev/null; then
        echo "Error: No internet connection detected. Please ensure you are connected to the internet."
        exit 1
    fi
    log "Internet connection confirmed."
}

# Function to check NVIDIA hardware
check_nvidia_hardware() {
    log "Checking for NVIDIA GPU..."
    if ! lspci | grep -i nvidia &>/dev/null; then
        echo "Error: No NVIDIA GPU detected. This script assumes an NVIDIA GPU with proprietary drivers."
        exit 1
    fi
    log "NVIDIA GPU detected."
}

# Function to check system requirements
check_system_requirements() {
    log "Checking system requirements..."
    local cpu_cores=$(nproc)
    if [[ "$cpu_cores" -lt 2 ]]; then
        echo "Warning: System has only $cpu_cores CPU core(s). Compilation may be slow."
    else
        log "System has $cpu_cores CPU core(s)."
    fi
    local mem_total=$(free -m | awk '/^Mem:/{print $2}')
    if [[ "$mem_total" -lt 4000 ]]; then
        echo "Warning: System has only ${mem_total}MB of RAM. Installation may be slow or fail."
    else
        log "System has ${mem_total}MB of RAM."
    fi
}

# Parse command-line options
while getopts "v" opt; do
    case "$opt" in
        v) VERBOSE=true ;;
        *) echo "Usage: $0 [-v]"; exit 1 ;;
    esac
done

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo "Error: This script should not be run as root. Please run as a regular user with sudo privileges."
    exit 1
fi

# Perform initial checks
check_internet
check_nvidia_hardware
check_system_requirements

# Check if NVIDIA drivers are installed
log "Checking for NVIDIA proprietary drivers..."
if ! pacman -Qs nvidia >/dev/null; then
    echo "Error: NVIDIA proprietary drivers are not installed. Please ensure they are installed."
    exit 1
fi
log "NVIDIA drivers found."

# Update system and install base packages
log "Updating system and installing packages..."
sudo pacman -Syu --needed "${PACKAGES[@]}" || {
    echo "Error: Failed to install packages. Check your internet connection or package availability."
    exit 1
}

# Install yay if not already installed
if ! command -v "$AUR_HELPER" >/dev/null; then
    log "Installing yay AUR helper..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay || {
        echo "Error: Failed to clone yay repository."
        exit 1
    }
    cd /tmp/yay
    makepkg -si --noconfirm || {
        echo "Error: Failed to build and install yay."
        exit 1
    }
    cd -
    rm -rf /tmp/yay
else
    log "yay is already installed."
fi

# Install AUR packages
log "Installing AUR packages..."
yay -S --needed "${AUR_PACKAGES[@]}" || {
    echo "Error: Failed to install AUR packages. Check your internet connection or AUR package availability."
    exit 1
}

# Create .config directory and back up existing configs
log "Setting up configuration files..."
mkdir -p "$CONFIG_DIR"
if [[ -d "$CONFIG_DIR" && -n "$(ls -A "$CONFIG_DIR")" ]]; then
    local backup_dir="${CONFIG_DIR}_backup_$(date +%F_%H-%M-%S)"
    log "Backing up existing $CONFIG_DIR to $backup_dir..."
    mv "$CONFIG_DIR" "$backup_dir" || {
        echo "Error: Failed to back up existing $CONFIG_DIR."
        exit 1
    }
    mkdir -p "$CONFIG_DIR"
fi

# Copy Hyprland configuration files
    rm -rf /tmp/hyprland-config
if [[ -d "./.config" ]]; then
    log "Copying local configuration files..."
    cp -r ./.config/* "$CONFIG_DIR/" || {
        echo "Error: Failed to copy local configuration files."
        exit 1
    }
else
    echo "Error: .config directory not found in the current directory and no Git repository specified."
    exit 1
fi
log "Configuration files copied to $CONFIG_DIR."

# Set zsh as the default shell
if [[ ! "$SHELL" =~ "zsh" ]]; then
    log "Setting zsh as the default shell..."
    chsh -s "$(which zsh)" || {
        echo "Error: Failed to set zsh as the default shell."
        exit 1
    }
fi

# Enable and verify services
log "Enabling and starting services..."
for service in NetworkManager power-profiles-daemon; do
    sudo systemctl enable "$service.service" || {
        echo "Error: Failed to enable $service.service."
        exit 1
    }
    sudo systemctl start "$service.service" || {
        echo "Warning: Failed to start $service.service. It may start on next boot."
    }
    if systemctl is-active --quiet "$service.service"; then
        log "$service.service is active."
    else
        echo "Warning: $service.service is not active."
    fi
done

# Notify user of completion
echo "Hyprland setup completed successfully! Please log out and select Hyprland from your display manager or start it with 'Hyprland'."
