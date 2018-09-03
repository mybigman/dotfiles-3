#    ▒███████▒  ██████  ██░ ██  ██▀███   ▄████▄  
#    ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒▓██ ▒ ██▒▒██▀ ▀█  
#    ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░▓██ ░▄█ ▒▒▓█    ▄ 
#      ▄▀▒   ░  ▒   ██▒░▓█ ░██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
#    ▒███████▒▒██████▒▒░▓█▒░██▓░██▓ ▒██▒▒ ▓███▀ ░
#    ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒▓ ░▒▓░░ ░▒ ▒  ░
#    ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░  ░▒ ░ ▒░  ░  ▒   
#    ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░  ░░   ░ ░        
#      ░ ░          ░   ░  ░  ░   ░     ░ ░      
#    ░                                  ░        

# Themes are into ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

# It's not automatically call for me
if [ -r $HOME/.aliases.zsh ] ; then
    source $HOME/.aliases.zsh
fi

# It's not automatically call for me
if [ -r $HOME/.zshenv ] ; then
    source $HOME/.zshenv
fi

# Bindkey fr
#bindkey "\e[2~"  yank
#bindkey "\e[3~"  delete-char
#bindkey "\e[1~"  beginning-of-line
#bindkey "\e[4~"  end-of-line
#bindkey "\e[5~"  up-line-or-history
#bindkey "\e[6~"  down-line-or-history

# Path for oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Plugin list in ~/.oh-my-zsh/plugins
plugins=(git git-prompt rbenv ruby)

# With Zsh and Termite
if [[ $TERM == xterm-termite ]] ; then
    . /etc/profile.d/vte-2.91.sh
    __vte_osc7
fi

#unset GREP_OPTIONS
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)" 

# man page with less
man() {
    LESS_TERMCAP_mb=$'\e[0;31m' \
        LESS_TERMCAP_md=$'\e[01;35m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;31;31m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[0;36m' \
        command man "$@"
}

buildfile() {
    if [[ "$1" == *.* ]]; then
        echo $1
    else
        if [ -e "$1" ]; then
            echo $1
        elif [ -e "$1".gpg ]; then
            echo "$1".gpg
        else 
            echo "$1".txt
        fi
    fi
}

# Create new password with : pw newpass.gpg
# read pass : pw newpass
pw() {
   cd "$PASSWD"
   if [ ! -z "$1" ]; then
      $EDITOR $(buildfile "$1")
      cd "$OLDPWD"
   fi
}

# Function for upload file -> https://transfer.sh/
# Use : curl --upload-file ./hello.txt https://transfer.sh/hello.txt 
# or : transfer hello.txt 
transfer() { 
    local torIp=127.0.0.1
    local torPort=9050 

    if [ $# -eq 0 ]; then 
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
        return 1; 
    fi 
    tmpfile=$( mktemp -t transferXXX ); 
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
        curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; 
    else 
        curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; 
    fi;
    cat $tmpfile; 
    rm -f $tmpfile; 
}
