# colors
set -g default-terminal "screen-256color"

tm_color_light=colour252
tm_color_dark=colour8
tm_color_highlight=colour10

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold="▶"
tm_separator_right_thin="❯"

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
set-option -g status-fg $tm_color_dark
set-option -g status-bg $tm_color_light

# default window title colors
set -g window-status-style fg=$tm_color_dark,bg=default
set -g window-status-format "#[bold] #I:#W "

# active window title colors
set -g window-status-current-style fg=$tm_color_highlight,bg=$tm_color_dark
set-window-option -g  window-status-current-format " #[bold]#I:#W "

# pane border
set -g pane-border-style fg=$tm_color_highlight
set -g pane-active-border-style fg=$tm_color_light

# message text
set -g message-style fg=$tm_color_light,bg=default

# pane number display
set-option -g display-panes-active-colour $tm_color_light
set-option -g display-panes-colour $tm_color_dark

# clock
set-window-option -g clock-mode-colour $tm_color_light

tm_date="#[bold] %d %b %R "
tm_session_name="#[fg=$tm_color_light,bg=$tm_color_dark,bold] [#S] "

set -g status-left $tm_session_name
set -g status-right $tm_date

set -g status-justify left
set -g status-interval 1
