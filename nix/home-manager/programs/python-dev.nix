{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python with development packages
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      setuptools
      wheel
    ]))

    # Python package managers
    poetry
    uv
  ];

  # Python-specific environment variables
  home.sessionVariables = {
    # Poetry configuration
    POETRY_VENV_IN_PROJECT = "1";  # Create .venv in project directory
    POETRY_CACHE_DIR = "$HOME/.cache/poetry";

    # UV configuration
    UV_CACHE_DIR = "$HOME/.cache/uv";
  };

  # Python development aliases
  home.shellAliases = {
    # Poetry shortcuts
    pi = "poetry install";
    pa = "poetry add";
    pad = "poetry add --group dev";
    pr = "poetry run";
    ps = "poetry shell";

    # UV shortcuts (for future migration)
    uvi = "uv pip install";
    uvs = "uv pip sync";
  };
}
