# Firejail profile for vivaldi
# This file is overwritten after every install/update
# Persistent local customizations
include /etc/firejail/vivaldi.local
# Persistent global definitions
include /etc/firejail/globals.local

noblacklist ~/.cache/vivaldi
noblacklist ~/.config/vivaldi

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-programs.inc

mkdir ~/.cache/vivaldi
mkdir ~/.config/vivaldi
whitelist ~/downloads 
whitelist ~/images
whitelist ~/.cache/vivaldi
whitelist ~/.config/vivaldi
include /etc/firejail/whitelist-common.inc

caps.keep sys_chroot,sys_admin
netfilter
nodvd
nogroups
noroot
notv
seccomp
shell none
dns 127.0.0.1

private-dev
private-tmp

noexec ${HOME}
noexec /tmp
