# export ANDROID_HOME=$HOME/AndroidStudioProjects/Android-meteor
export EDITOR='vim'
# export _JAVA_AWT_WM_NONREPARENTING=1
# export _JAVA_OPTIONS=-Djava.io.tmpdir=/var/tmp
# export JAVA_HOME=/opt/oracle-jdk-bin-1.8.0.112
export SUDO_EDITOR='vim'
export PATH=$HOME/.gems/bin:$PATH
# export PATH=$HOME/node_modules/cordova/bin:$HOME/bin:/usr/lib64/node_modules:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME:$PATH
# export RB_USER_INSTALL='true'
export TERMINAL=/usr/bin/kitty

# my current passwords dir encrypt with vim-gpg
export PASSWD=~/.passwords

# Bspwm
# export PANEL_FIFO="/tmp/panel-fifo"

# mpd port
# export MPD_PORT="6600"

# Proxy
export http_proxy="http://<your hostname>:8118/"
export https_proxy=${http_proxy}
export ftp_proxy=${http_proxy}
export rsync_proxy=${http_proxy}
export HTTP_PROXY=${http_proxy}
export HTTPS_PROXY=${http_proxy}
export no_proxy="localhost,127.0.0.1,localaddress,localdomain.com"

# GPG and SSH
export GNUPGHOME="$HOME/.gnupg"
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
export GPG_TTY=$(tty)

# For jekyll, mkdir -p ~/.gems/bin
# export GEM_PATH=/home/izsha/.gems:/usr/lib64/ruby/gems/2.3.0/gems/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Ruby | Rails
export GEM_HOME=$HOME/.gems
# export RAILSLAB_U=""
# export SHAKEN_U=""
# export RAILSLAB_C="$HOME/.certs/mongo-client.pem"
# export SHAKEN_C="$HOME/.certs/mongo-shaken-client.pem"
# export MONGO_CA="$HOME/.certs/mongo-ca.pem"
# decrypt secret with rails
# export RAILS_MASTER_KEY=$(cat $HOME/labs/szorfein/Erebe/config/secrets.yml.key)
# export AUTH0_CLIENT=""
# export AUTH0_SEC=""
# decrypt session with rails
#export SECRET_KEY_BASE=$(rake secret)

# Hack 
export HYDRA_PROXY_HTTP="$HTTP_PROXY"
