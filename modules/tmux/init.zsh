#
# Defines tmux aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Colin Hebert <hebert.colin@gmail.com>
#   Georges Discry <georges@discry.be>
#   Xavier Cambar <xcambar@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

[[ $Z_APP_LAUNCHER -eq 1 ]] && return 0

#
# Auto Start
#

if ([[ "$TERM_PROGRAM" = 'iTerm.app' ]] && \
  zstyle -t ':prezto:module:tmux:iterm' integrate \
); then
  _tmux_iterm_integration='-CC'
fi

( ! [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] ) && {
    if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]] && ( \
    ( [[ -n "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' remote ) ||
    ( [[ -z "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' local ) \
    ); then
	#tmux_session='prezto'

	# Create a 'prezto' session if no session has been defined in tmux.conf.
	#if ! tmux has-session 2> /dev/null; then
	#    exec tmux new-session -t "$tmux_session" \; set-option destroy-unattached
	#else  
	#    exec tmux new-session -t "$tmux_session" \; new-window \; set-option destroy-unattached
	#fi

	exec tmux new-session

	# Attach to the 'prezto' session or to the last session used.
	#exec tmux $_tmux_iterm_integration attach-session
    fi
}

#
# Aliases
#

alias tmuxa="tmux $_tmux_iterm_integration new-session -A"
alias tmuxl='tmux list-sessions'
