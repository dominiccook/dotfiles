# config for z shell

# many options in this file will
#+likely be copied from :
# git@github.com:lukesmithxyz/voidrice/.config/zsh
# so i will mark them with #lukevr
# (Last edited: 2025-12-28)

###### GOOGLE GEMINI TRANSLATION OF MY BASHRC ######
# ----- Git helpers (silent outside repos) -----
git_branch() {
    git branch --show-current 2>/dev/null
}

git_dirty() {
    git diff --quiet --ignore-submodules HEAD 2>/dev/null || echo "*"
}

setopt PROMPT_SUBST # Enable dynamic evaluation of the prompt #lukevr

# ----- Greyscale Git-aware prompt -----
if [[ "$color_prompt" == "yes" ]]; then
    # Zsh escape equivalents:
    # \u -> %n | \h -> %m | \w -> %~ (with tilde)
    # \[ \] -> %{ %} | \e[...m -> %F{...} and %f
    PROMPT='%{$(echo -ne "\e]0;%n@%m: %~\a")%}${debian_chroot:+($debian_chroot)}%F{248}[%F{255} дом %F{248}]%F{247}@%f%F{250}%m%f%F{245} → %F{255}%~%f%F{242}$([ -n "$(git_branch)" ] && echo "(%F{250}$(git_branch)%F{240}$(git_dirty)%F{242})")%f
%F{244}%# %f'
else
    PROMPT='%{$(echo -ne "")%}${debian_chroot:+($debian_chroot)}%F{248}[%F{255} дом %F{248}]%F{247}@%f%F{250}%m%f%F{245} → %F{255}%~%f
%F{244}%# %f'
fi
####################################################

### lukevr #
setopt autocd       # Automatically cd into a typed directory.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu: 
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# lukevr ###

# [TODO] move to alias file at some point
alias \
	ls="gls -hN --color=auto --group-directories-first" \
    l="ls" \
    ll="ls -l" \ 
    la="ls -a" \
    grep="grep --color=auto" \
    diff="diff --color=auto" \
    ccat="highlight --out-format=ansi" \
    ip="ip -color=auto" \

alias \
    zrc="vim /Users/dom/.zshrc" \
    vrc="vim /Users/dom/.vimrc"
