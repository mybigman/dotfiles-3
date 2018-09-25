#! /usr/bin/env python2
# -*- coding: utf8 -*-

from subprocess import check_output

# get_pass() use the script give_pass (from ~/bin) to retrieve password of a file looks like this, it work with extension gnupg.vim:
# vim ~/.mypass/mail.gpg 
#   Gmail {{{
#     user: userGmail@gmail.com
#     passwd: s@K$J3=VRxff9R/PX^hmxj;$R
#  }}}
#
# more info here: https://szorfein.github.io/vim/gpg/password/vim-gpg/
def get_pass():
    return check_output("give_pass mail Gmail", shell=True).strip("\n")
