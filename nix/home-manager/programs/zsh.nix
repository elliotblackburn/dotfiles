{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Environment variables
    sessionVariables = {
      ZSH = "$HOME/.dotfiles";
      GPG_TTY = "$(tty)";
      EDITOR = "zed";
      LSCOLORS = "exfxcxdxbxegedabagacad";
      CLICOLOR = "true";
    };

    # Shell options
    # defaultKeymap = "emacs";

    # Shell aliases - you can migrate your git aliases here
    shellAliases = {
      # General
      cls = "clear";

      # Improved ls commands
      ls = "ls -F --color";
      l = "ls -lAh --color";
      ll = "ls -l --color";
      la = "ls -A --color";

      # Git aliases
      gl = "git lg";
      gup = "git up";
      gd = "git diff --color | sed \"s/^\\([^-+ ]*\\)[-+ ]/\\\\1/\" | less -r";
      gc = "git commit";
      gca = "git commit -a";
      gac = "git add -A && git commit -m";
      gco = "git co";
      gcob = "git cob";
      gcb = "git copy-branch-name";
      gb = "git branch";
      gs = "git status -sb";
    };

    # Init content - for complex shell logic that can't be declarative
    initContent = ''
      # Source local config files
      if [[ -e ~/.localrc ]]; then
        source ~/.localrc
      fi

      if [[ -e ~/.localaliases ]]; then
        source ~/.localaliases
      fi

      # Load custom shell functions
      for file in $ZSH/shell/functions/*.zsh; do
        [[ -r "$file" ]] && source "$file"
      done

      # Initialize completion system
      autoload -Uz compinit
      compinit

      # Load custom completions
      for file in $ZSH/shell/completions/*.zsh; do
        [[ -r "$file" ]] && source "$file"
      done

      # Better history search
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      # Shell options
      setopt NO_BG_NICE           # don't nice background tasks
      setopt NO_HUP
      setopt NO_LIST_BEEP
      setopt LOCAL_OPTIONS        # allow functions to have local options
      setopt LOCAL_TRAPS          # allow functions to have local traps
      setopt HIST_VERIFY
      setopt EXTENDED_HISTORY     # add timestamps to history
      setopt PROMPT_SUBST
      setopt CORRECT
      setopt COMPLETE_IN_WORD
      setopt IGNORE_EOF
      setopt HIST_IGNORE_ALL_DUPS # don't record dupes in history
      setopt HIST_REDUCE_BLANKS
      setopt complete_aliases     # don't expand aliases before completion

      # Key bindings
      bindkey '^[^[[D' backward-word
      bindkey '^[^[[C' forward-word
      bindkey '^[[5D' beginning-of-line
      bindkey '^[[5C' end-of-line
      bindkey '^[[3~' delete-char
      bindkey '^?' backward-delete-char

      # Source asdf
      if [[ -f $HOME/.asdf/asdf.sh ]]; then
        . $HOME/.asdf/asdf.sh
      fi

      # Add dotfiles bin directory to PATH for git utilities and scripts
      export PATH="$ZSH/bin:$PATH"

      # Add pip3 --user installed stuff to path
      export PATH=~/.local/bin:$PATH
    '';

    # History configuration
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };
}
