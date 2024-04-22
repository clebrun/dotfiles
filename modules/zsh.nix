{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ zsh oh-my-zsh fzf ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      SHELL = "/home/hxegon/.nix-profile/bin/zsh";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
    };

    defaultKeymap = "emacs";

    shellAliases = {
      g = "git";
      tm = "tmux";
      lg = "lazygit";
      lt = "/home/hxegon/Code/hxegon/lazytsm/lazytsm"; # temporary
      j = "just";
      jc = "just --choose";
      ".." = "cd ../";
      la = "ls -a";
    };

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "docker" ];
      theme = "lambda";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
