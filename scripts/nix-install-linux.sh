#!/bin/bash

# nix-install-linux.sh
#
# Purpose: Install Nix and home-manager on Linux systems
# Usage: ./scripts/nix-install-linux.sh (run from repository root)

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}ERROR: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}SUCCESS: $1${NC}"
}

print_info() {
    echo -e "${YELLOW}INFO: $1${NC}"
}

# Function to check if we're running on Linux
check_linux() {
    if [[ "$(uname -s)" != "Linux" ]]; then
        print_error "This script is designed for Linux only. Detected OS: $(uname -s)"
        print_error "Please run this script on a Linux system."
        exit 1
    fi
    print_info "Verified running on Linux"
}

# Function to check if Nix is already installed
is_nix_installed() {
    if command -v nix &> /dev/null && [[ -d "/nix" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to install Nix using Determinate Systems installer
install_nix() {
    if is_nix_installed; then
        print_info "Nix is already installed, skipping Nix installation"
        return 0
    fi

    print_info "Installing Nix using Determinate Systems installer..."

    # Download and run the Determinate Systems installer for upstream Nix
    # Using --no-confirm to avoid interaction and ensuring upstream Nix (not Determinate Nix)
    if curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm; then
        print_success "Nix installation completed"

        # Source the Nix profile to make nix command available
        if [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
            # shellcheck source=/dev/null
            . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
        fi
    else
        print_error "Failed to install Nix"
        exit 1
    fi
}

# Function to check if home-manager is already installed
is_home_manager_installed() {
    if command -v home-manager &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install home-manager
install_home_manager() {
    if is_home_manager_installed; then
        print_info "home-manager is already installed, skipping home-manager installation"
        return 0
    fi

    print_info "Installing home-manager..."

    # Ensure Nix environment is loaded
    if [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
        # shellcheck source=/dev/null
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi

    # Install home-manager via nix profile
    print_info "Making home-manager available via nix profile..."
    if nix profile install nixpkgs#home-manager; then
        print_success "home-manager is now available"
        print_info "You can now use 'home-manager' command to build and switch configurations"
    else
        print_error "Failed to install home-manager"
        exit 1
    fi
}

# Function to list available configurations
list_configurations() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local repo_root
    repo_root="$(cd "${script_dir}/.." && pwd)"

    if [[ -f "${repo_root}/flake.nix" ]]; then
        print_info "Available configurations in your flake:"

        # Change to repo root directory and get configurations
        local configs
        if configs=$(cd "${repo_root}" && nix eval .#homeConfigurations --apply builtins.attrNames 2>/dev/null); then
            # Parse the output format [ "config1" "config2" ] and format nicely
            local config_list
            config_list=$(echo "$configs" | sed 's/\[ *//' | sed 's/ *\]//' | sed 's/"//g' | tr ' ' '\n' | grep -v '^$')

            while IFS= read -r config; do
                if [[ -n "$config" ]]; then
                    print_info "- $config"
                fi
            done <<< "$config_list"
        else
            print_info "- Unable to parse configurations (you can check manually with 'nix eval .#homeConfigurations --apply builtins.attrNames')"
        fi
    fi
}

# Main execution
main() {
    print_info "Starting Nix and home-manager installation for Linux..."

    # Check if running on Linux
    check_linux

    # Install Nix
    install_nix

    # Install home-manager
    install_home_manager

    # Print completion message
    echo
    print_success "Installation completed successfully!"
    echo
    print_info "Summary of what was installed:"
    print_info "- Nix package manager (upstream version)"
    print_info "- home-manager configuration management"
    echo

    # List available configurations
    list_configurations
    echo

    print_info "Next steps:"
    print_info "1. Navigate to your dotfiles directory (repo root)"
    print_info "2. Run 'home-manager switch --flake .#CONFIGURATION_NAME' to activate home-manager"
    print_info "3. Use 'home-manager switch --flake .#CONFIGURATION_NAME' for future updates"
    echo
    print_info "For more information, visit:"
    print_info "- Nix documentation: https://nix.dev/"
    print_info "- home-manager documentation: https://nix-community.github.io/home-manager/"
}

# Run main function
main "$@"
