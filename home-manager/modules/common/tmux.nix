{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          # General
          set -g base-index 1
          setw -g pane-base-index 1

          # Key
          unbind C-b
          set -g prefix C-a
          bind C-a send-prefix

          # nvim tmux navigator
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\S+\/)?g?(view|n?vim?x?)(diff)?$'"
          bind-key -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
          bind-key -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
          bind-key -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
          bind-key -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

          # Theme
          set -g default-terminal "tmux-256color" 
          set -g @catppuccin_flavour 'mocha'  # latte, frappe, macchiato, mocha
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"

          # Active Color
          set -g window-style fg=colour247,bg=colour236
          set -g window-active-style fg=colour250,bg=colour234

          # View Prefix Key
          set -g status-left "#{?client_prefix,#[fg=colour2]●#[default],#[fg=colour242]●#[default]} #S "
        '';
      }
    ];
  };
}
