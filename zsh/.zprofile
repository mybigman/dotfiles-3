# start keychain
keychain --clear --gpg2 --agents "ssh,gpg" id_ed25519 git 0x9CC9729A2E369CB3

[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)

[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
   . $HOME/.keychain/$HOSTNAME-sh

[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
   . $HOME/.keychain/$HOSTNAME-sh-gpg

# Infinality conf
#if [ -r $HOME/.infinality ] ; then
#    source $HOME/.infinality
#fi

# SSH tunnel, run autossh.sh if not alrealy run
#if [ -f $HOME/bin/autossh.sh ] ; then
#  autossh_proc=$(pgrep -u $USER -x autossh)
#  [[ -z $autossh_proc ]] && ~/bin/autossh.sh &
#fi
