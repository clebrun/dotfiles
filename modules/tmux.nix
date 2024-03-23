{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        tmux
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
        tmuxPlugins.power-theme
    ];

    programs.tmux = {
        enable = true;
        baseIndex = 1;
        mouse = true;
        historyLimit = 10000;
        aggressiveResize = true;

        # Shorten the delay tmux uses to see if an esc key code is actually for a meta combination
        # The default is long enough to cause problems when using modal editing. see:
        # https://evil.readthedocs.io/en/latest/faq.html#problems-with-the-escape-key-in-the-terminal
        escapeTime = 200; # default is 500

        prefix = "C-Space";
        terminal = "screen-256color";

        extraConfig = ''
            bind-key C-o popup -h 80% -w 60% -E tms
            bind-key C-g popup -d "#{pane_current_path}" -h 90% -w 100% -E lazygit
            bind-key C-j popup -d "#{pane_current_path}" -h 50% -w 50% -E just --choose
        '';

        plugins = with pkgs; [
            {
                plugin = tmuxPlugins.power-theme;
                extraConfig = "set -g @tmux_power_theme 'everforest'";
            }
            {
                plugin = tmuxPlugins.vim-tmux-navigator;
                # this plugin binds the 'terminal clear' shortcut (C-l), so we make prefix + C-l as a backup.
                extraConfig = "bind C-l send-keys 'C-l'";
            }
        ];
    };
}