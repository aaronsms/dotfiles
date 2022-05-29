unsetopt BEEP
stty stop undef
setopt autocd
setopt interactive_comments
setopt histignorealldups sharehistory autopushd

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

autoload -Uz compinit
compinit

zmodload zsh/complist
_comp_options+=(globdots)

source "$ZDOTDIR/zsh-functions"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

zsh_add_file "zsh-prompt"
zsh_add_file "zsh-keys"
zsh_add_file "zsh-exports"
zsh_add_file "zsh-languages"
zsh_add_file "zsh-aliases"

zsh_add_plugin "lukechilds/zsh-nvm"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
emulate ksh -c '. "$ZDOTDIR/ssh-find-agent.sh"'
ssh_find_agent -a || eval "$(ssh-agent)" > /dev/null
