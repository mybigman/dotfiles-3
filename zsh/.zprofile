# shart keychain
keychain --clear --agents "ssh,gpg" ssh_git 0x91D16ADFCDDD7959E25F21648838FC91D890EB06

[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)

[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
   . $HOME/.keychain/$HOSTNAME-sh

[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
   . $HOME/.keychain/$HOSTNAME-sh-gpg

# Infinality conf
#if [ -r $HOME/.infinality ] ; then
#    source $HOME/.infinality
#fi

# SSH tunnel
if [ -f $HOME/bin/autossh.sh ] ; then
  autossh.sh &
fi
