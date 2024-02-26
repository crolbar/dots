# crolbar
export TERMINAL='alacritty'
export BROWSER='brave'
export VISUAL='nvim'
export EDITOR='nvim'
export PATH="/home/plier/bin:$PATH"

# history
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000

# zsh options
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		     # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# engine
autoload -Uz compinit
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done
compinit -C -d ~/.config/zsh/zcompdump
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# binds
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word 
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# prompt
PROMPT=' %B%F{blue}%n%f%b %B%F{red}%~%f%b${vcs_info_msg_0_}%b %(?.%B%F{green}✓.%F{red}✕)%f%b %B%F{green}%f%b '

# alias
alias ls='lsd -a --group-directories-first'
alias ll='lsd -la --group-directories-first'
alias cdd='cd ..'
alias vs='cd ~/.config/hypr && nvim .'
alias yay='paru'
alias vim='nvim'
alias vimc='cd ~/.config/nvim && nvim .'

alias n='cd ~/.config/nixos && vim .'
alias ns='nix-shell'
alias reb='sudo nixos-rebuild switch --flake /home/plier/.config/nixos'
alias lfc='cd ~/.config/leftwm && nvim .'

alias v='p=$(find . -type d | sk --preview "tree -C {}" --preview-window down:50%) && cd "$p" && vim .'
alias vf='p=$(sk --preview "tree -C {}" --preview-window down:50%) && vim "$p"'

alias lapp='ssh lapp@192.168.1.5'
alias crol='ssh crolbar@192.168.1.12'

alias mnas='sudo mount -t nfs 192.168.1.5:/nas /mnt/nas -o rw'
alias umnas='sudo umount /mnt/nas'
alias nas='cd /mnt/nas'

alias d='. ~/scripts/dapu.sh'
alias dc='. ~/scripts/dapu.sh cd'

neofetch
