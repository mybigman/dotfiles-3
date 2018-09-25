# shart keychain
keychain --clear --agents "ssh,gpg" ssh1 ssh2 0xgpgkey

[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)

[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
   . $HOME/.keychain/$HOSTNAME-sh

[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
   . $HOME/.keychain/$HOSTNAME-sh-gpg

# Infinality conf
#if [ -r $HOME/.infinality ] ; then
#    source $HOME/.infinality
#fi
