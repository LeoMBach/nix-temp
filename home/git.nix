{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Leo M Bach";

    ignores = [
      ".DS_Store"
      "*.class"
      "*.pyc"
      "*.swp"
      "*.tmp"
      "node_modules/"
      "thumbs.db"
      ];

      aliases = {
        # List all aliases (TODO: That's a lotta escapes...)
        alias = "!git config --list | grep 'alias\\\\.' | sed 's/alias\\\\.\\\\([^=]*\\\\)=\\\\(.*\\\\)/\\\\1\\\\t=> \\\\2/' | sort";

        # Pretty printing
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        color = {
          branch = true;
          diff = true;
          interactive = true;
          ui = true;
        };

        commit.verbose = true;

        core = {
          compression = 9;
          editor = "vim";
          pager = "less";
          whitespace = "trailing-space,space-before-tab";
        };

        credential.helper = "store --file ~/.git-credentials";

        difftool.prompt = false;

        grep.lineNumber = true;

        i18n = {
          commitencoding = "utf-8";
          logoutputencoding = "utf-8";
        };

        pull.rebase = true;
        push.default = "upstream";
      };
    };
  }
