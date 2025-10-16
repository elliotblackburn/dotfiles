{ config, pkgs, userName ? "Elliot Blackburn", userEmail ? "elliot@lybrary.io", ... }:

{
  programs.git = {
    enable = true;

    userName = userName;
    userEmail = userEmail;

    aliases = {
      ec = "config --global -e";
      co = "checkout";
      cob = "checkout -b";
      up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";
      cm = "!git add -A && git commit -m";
      save = "!git add -A && git commit -m 'SAVEPOINT'";
      wip = "!git add -u && git commit -m 'WIP'";
      undo = "reset HEAD~1 --mixed";
      amend = "commit -a --amend";
      wipe = "!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard";
      bclean = "!f() { git branch --merged \${1-master} | grep -v \" \${1-master}$\" | xargs git branch -d; }; f";
      bdone = "!f() { git checkout \${1-master} && git up && git bclean \${1-master}; }; f";
      count = "!git shortlog -sn";
      lg1 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg3 = "log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      lg = "!git lg1";
      fetchpr = "!f() { git fetch \${1} pull/\${2}/head:pr-\${2}; }; f";
    };

    ignores = [
      ".DS_Store"
      ".zed"
      ".elliot"
    ];

    extraConfig = {
      hub = {
        protocol = "https";
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };

      core = {
        editor = "nano";
        autocrlf = "input";
      };

      apply = {
        whitespace = "nowarn";
      };

      mergetool = {
        keepBackup = false;
      };

      difftool = {
        prompt = false;
      };

      help = {
        autocorrect = 1;
      };

      push = {
        default = "nothing";
      };

      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
      };

      commit = {
        gpgsign = true;
      };

      credential = {
        helper = "cache";
      };
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3fznw303UZ4U+35laeeSuY4VMCKIDsT/ZGpSbQGQpi";
      signByDefault = true;
    };
  };
}
