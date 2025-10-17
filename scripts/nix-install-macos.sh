#!/bin/bash

# nix-install-macos.sh
#
# Purpose: Install Nix and nix-darwin on macOS systems
# Usage: ./scripts/nix-install-macos.sh (run from repository root)

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

# Function to check if we're running on macOS
check_macos() {
    if [[ "$(uname -s)" != "Darwin" ]]; then
        print_error "This script is designed for macOS only. Detected OS: $(uname -s)"
        print_error "Please run this script on a macOS system."
        exit 1
    fi
    print_info "Verified running on macOS"
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

# Function to check if nix-darwin is already installed
is_nix_darwin_installed() {
    if command -v darwin-rebuild &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to install nix-darwin
install_nix_darwin() {
    if is_nix_darwin_installed; then
        print_info "nix-darwin is already installed, skipping nix-darwin installation"
        return 0
    fi

    print_info "Installing nix-darwin..."

    # Ensure Nix environment is loaded
    if [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
        # shellcheck source=/dev/null
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-darwin.sh" 2>/dev/null || true
        # shellcheck source=/dev/null
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi

    # Simply run nix-darwin to make it available
    # This will install darwin-rebuild command without switching to any configuration
    print_info "Making nix-darwin available via darwin-rebuild command..."
    if nix run nix-darwin -- --help &>/dev/null; then
        print_success "nix-darwin is now available"
        print_info "You can now use 'darwin-rebuild' command to build and switch configurations"
    else
        print_error "Failed to install nix-darwin"
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
        if configs=$(cd "${repo_root}" && nix eval .#darwinConfigurations --apply builtins.attrNames 2>/dev/null); then
            # Parse the output format [ "config1" "config2" ] and format nicely
            local config_list
            config_list=$(echo "$configs" | sed 's/\[ *//' | sed 's/ *\]//' | sed 's/"//g' | tr ' ' '\n' | grep -v '^$')

            while IFS= read -r config; do
                if [[ -n "$config" ]]; then
                    print_info "- $config"
                fi
            done <<< "$config_list"
        else
            print_info "- Unable to parse configurations (you can check manually with 'nix eval .#darwinConfigurations --apply builtins.attrNames')"
        fi
    fi
}

# Main execution
main() {
    print_info "Starting Nix and nix-darwin installation for macOS..."

    # Check if running on macOS
    check_macos

    # Install Nix
    install_nix

    # Install nix-darwin
    install_nix_darwin

    # Print completion message
    echo
    print_success "Installation completed successfully!"
    echo
    print_info "Summary of what was installed:"
    print_info "- Nix package manager (upstream version)"
    print_info "- nix-darwin configuration management (available via darwin-rebuild)"
    echo

    # List available configurations
    list_configurations
    echo

    print_info "Next steps:"
    print_info "1. Navigate to your dotfiles directory (repo root)"
    print_info "2. Run 'darwin-rebuild switch --flake .#CONFIGURATION_NAME' to activate nix-darwin"
    print_info "3. Use 'darwin-rebuild switch --flake .#CONFIGURATION_NAME' for future updates"
    echo
    print_info "For more information, visit:"
    print_info "- Nix documentation: https://nix.dev/"
    print_info "- nix-darwin documentation: https://nix-darwin.org/"
}

# Run main function
main "$@"
