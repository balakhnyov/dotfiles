# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#ccc'
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias nv='nvim'
alias nvg='nvim -c "lua require(\"telescope.builtin\").live_grep()"'

cleanzip() {
  zip -r "$1".zip "$1" -x "*/__MACOSX/*" -x "*.DS_Store" -x ".*"
}

cleantar() {
  tar --exclude='.DS_Store' --exclude='__MACOSX' -czf "$1".tar.gz "$1"
}


export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

command -v lsd > /dev/null && alias ls='lsd --group-dirs first'

command -v lsd > /dev/null && alias tree='lsd --tree'

command -v mactop > /dev/null && alias top='mactop'

bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^w' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^b' backward-word
bindkey '^[[3;5~' kill-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

# # Set vi mode (default is emacs mode) (EXPERIMENTAL)
# bindkey -v
#
# # Remap navigation keys in NORMAL mode
# bindkey -M vicmd '^H' backward-char   # Ctrl + H (like h)
# bindkey -M vicmd '^L' forward-char    # Ctrl + L (like l)
# bindkey -M vicmd '^J' down-line-or-history  # Ctrl + J (like j)
# bindkey -M vicmd '^K' up-line-or-history    # Ctrl + K (like k)
#
# # Use `Ctrl + w` to delete words in insert mode
# bindkey -M viins '^W' backward-kill-word
#
# # Use `Ctrl + u` to clear the line in insert mode
# bindkey -M viins '^U' kill-whole-line
#
# # Use `Ctrl + d` to delete the current character (like Vim's x)
# bindkey -M viins '^D' delete-char
#
# # Ctrl + Left/Right to move between words in insert mode
# bindkey -M viins '^[[1;5C' forward-word
# bindkey -M viins '^[[1;5D' backward-word
#
# # Ctrl + Delete to delete the next word in insert mode
# bindkey -M viins '^[[3;5~' kill-word
# #_________________________________EXPERIMENTAL ENDS HERE_____________________________

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
hstr_no_tiocsti() {
    zle -I
    { HSTR_OUT="$( { </dev/tty hstr ${BUFFER}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    BUFFER="${HSTR_OUT}"
    CURSOR=${#BUFFER}
    zle redisplay
}
zle -N hstr_no_tiocsti
bindkey '\C-r' hstr_no_tiocsti
export HSTR_TIOCSTI=n

[ -f ~/.nvim_secrets ] && source ~/.nvim_secrets

unrar() {
    if [ -z "$1" ]; then
        echo "Использование: unrar <файл>"
        return 1
    fi

    f="$1"
    d="${f%.*}"
    mkdir -p "$d"

    # Разархивируем
    case "$f" in
        *.rar) unar -output-directory "$d" "$f";;
        *.zip) unzip "$f" -d "$d";;
        *.tar|*.tar.*) tar -xf "$f" -C "$d";;
        *.7z) 7z x "$f" -o"$d";;
        *) echo "Неподдерживаемый формат: $f"; return 1;;
    esac

    # Проверяем, есть ли внутри единственная папка с таким же именем
    local item_count=$(ls -A "$d" | wc -l | tr -d ' ')

    if [ "$item_count" -eq 1 ]; then
        local inner_item=$(ls -A "$d")
        local inner_path="$d/$inner_item"

        # Если это директория с похожим именем
        if [ -d "$inner_path" ]; then
            echo "Обнаружена вложенная папка, распаковываем..."

            # Перемещаем содержимое наружу
            mv "$inner_path"/* "$d/" 2>/dev/null
            mv "$inner_path"/.[!.]* "$d/" 2>/dev/null  # скрытые файлы

            # Удаляем пустую вложенную папку
            rmdir "$inner_path"

            echo "Вложенность устранена!"
        fi
    fi

    # Спрашиваем про удаление архива
    echo -n "Удалить исходный .rar архив? [Y/n]: "
    read -r response

    # По умолчанию Y (если просто Enter или Y/y)
    if [[ -z "$response" || "$response" =~ ^[Yy]$ ]]; then
        rm "$f"
        echo "✓ Архив удалён: $(basename "$f")"
    else
        echo "Архив сохранён: $f"
    fi
}

# Интерактивный поиск и разархивация с перемещением
unrar-work() {
    local search_dir="${1:-$HOME/Downloads}"
    local work_dir="${2:-$PWD}"

    # Ищем rar-архивы с помощью fzf
    local archive=$(find "$search_dir" -name "*.rar" -type f 2>/dev/null | fzf --prompt="Выберите архив: " --preview='echo {}' --height=40%)

    if [ -z "$archive" ]; then
        echo "Архив не выбран"
        return 1
    fi

    echo "Выбран: $archive"

    # Разархивируем
    local f="$archive"
    local archive_dir=$(dirname "$f")
    local d="${f%.*}"

    mkdir -p "$d"

    case "$f" in
        *.rar) unar -output-directory "$d" "$f";;
        *.zip) unzip "$f" -d "$d";;
        *.tar|*.tar.*) tar -xf "$f" -C "$d";;
        *) echo "Неподдерживаемый формат"; return 1;;
    esac

    # Убираем вложенность
    local item_count=$(ls -A "$d" | wc -l | tr -d ' ')
    if [ "$item_count" -eq 1 ]; then
        local inner_item=$(ls -A "$d")
        local inner_path="$d/$inner_item"
        if [ -d "$inner_path" ]; then
            mv "$inner_path"/* "$d/" 2>/dev/null
            mv "$inner_path"/.[!.]* "$d/" 2>/dev/null
            rmdir "$inner_path" 2>/dev/null
        fi
    fi

    # Перемещаем в рабочую директорию
    local folder_name=$(basename "$d")
    mv "$d" "$work_dir/"

    echo "Папка перемещена в: $work_dir/$folder_name"

    # Копируем имя папки в буфер обмена
    echo -n "$folder_name" | pbcopy

    echo "✓ Имя папки скопировано в буфер обмена: $folder_name"

    # Спрашиваем про удаление архива
    echo -n "Удалить исходный .rar архив? [Y/n]: "
    read -r response

    # По умолчанию Y (если просто Enter или Y/y)
    if [[ -z "$response" || "$response" =~ ^[Yy]$ ]]; then
        rm "$f"
        echo "✓ Архив удалён: $(basename "$f")"
    else
        echo "Архив сохранён: $f"
    fi
}

fzf-file-widget() {
  local result
  result=$(fd --type f --hidden --max-depth 5 --exclude .git --exclude node_modules --exclude .venv --exclude Library \
    | fzf --prompt="Файл: " --height=40%)
  if [[ -n "$result" ]]; then
    LBUFFER+="$result"
  fi
  zle redisplay
}

fzf-dir-widget() {
  local result
  result=$(fd --type d --hidden --max-depth 5 --exclude .git --exclude node_modules --exclude .venv --exclude Library \
    | awk '{print length, $0}' | sort -n | cut -d' ' -f2- \
    | fzf --prompt="Папка: " --height=40%)
  if [[ -n "$result" ]]; then
    LBUFFER+="$result"
  fi
  zle redisplay
}

# Added by Antigravity
export PATH="/Users/kirill/.antigravity/antigravity/bin:$PATH"

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
