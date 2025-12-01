{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "html"
      "catppuccin"
      "elixir"
      "nix"
    ];

    userSettings = {
      context_servers = {
        tidewave = {
          command = "/usr/local/bin/mcp-proxy";
          args = ["http://localhost:4000/tidewave/mcp"];
          env = null;
        };
        mcp-server-linear = {
          enabled = true;
          command = "npx";
          args = ["-y" "mcp-remote" "https://mcp.linear.app/sse"];
        };
      };
      ui_font_size = 14;
      buffer_font_size = 14;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Catppuccin Macchiato - No Italics";
      };
      languages = {
        "Plain Text" = {
          show_edit_predictions = false;
        };
        Python = {
          language_servers = ["pyright" "ruff"];
          format_on_save = "on";
          formatter = [
            {
              language_server = {
                name = "ruff";
              };
            }
          ];
          code_actions_on_format = {
            # Fix all auto-fixable lint violations
            "source.fixAll.ruff" = true;
            # Organize imports
            "source.organizeImports.ruff" = true;
          };
        };
        CSS = {
          tab_size = 2;
        };
      };
      show_edit_predictions = true;
      features = {
        edit_prediction_provider = "zed";
      };
      edit_predictions = {
        mode = "subtle";
        disabled_globs = [
          "**/.env*"
          "**/*.pem"
          "**/*.key"
          "**/*.cert"
          "**/*.crt"
          "**/secrets.yml"
          "**/*.secrets.*"
          "**/node_modules/**"
          "**/.git/**"
        ];
      };
      edit_predictions_disabled_in = ["comment"];
      agent = {
        always_allow_tool_actions = true;
        default_profile = "write";
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
      };
    };
  };
}
