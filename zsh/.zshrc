autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the fade theme with parameter blue.
prompt fade blue

# Basic zsh config
ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='128000'
SAVEHIST='96000'
if [[ -x /usr/bin/nvim ]]; then
	export EDITOR="/usr/bin/nvim"
fi

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
# unsetopt LIST_BEEP
# Ignore space prepended commands
setopt HIST_IGNORE_SPACE

# PATH
function addtopath() {
	if [[ -d $1 && -x $1 ]]; then
		path=($1 $path)
	fi
}
typeset -U path PATH
addtopath ~/node_modules/.bin
addtopath ~/.emacs.d/bin 
addtopath ~/bin
#path=(~/.emacs.d/bin ~/bin ~/node_modules/.bin $path)
export PATH

# Comp stuf
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Aliases
alias yay="paru"
alias ls="ls --color=auto"
alias llatex="lualatex -synctex=1 -interaction=nonstopmode"
alias upgrade-hosts="cd ~/Projects/home-sysadmin && ansible-playbook -i inventory/penteli -i inventory/patras -i inventory/chania -i inventory/oracle-cloud -i inventory/google-cloud -i inventory/okeanos-cloud --ask-become-pass -f 30 ./playbooks/apt.yml; cd -"
alias batt="upower -i $(upower -e | grep BAT) | grep -E 'state|to full|to empty|percentage'"

# Fish-like syntax highlighting and autosuggestions
# Pacman OSes
if command -v pacman > /dev/null; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	# command-not-found handler using pkgfile
	# sudo pkgfile -u to update cache
	source /usr/share/doc/pkgfile/command-not-found.zsh

# Debian-based OSes
elif command -v apt > /dev/null; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

activate_conda () {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dimitris/Applications/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dimitris/Applications/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dimitris/Applications/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dimitris/Applications/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

# Load starship
eval "$(starship init zsh)"
# Load atuin (history sever /search)
eval "$(atuin init zsh)"
