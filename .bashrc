# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if [ -e /bin/nvim ]; then
    alias vi='nvim'
    alias view='nvim -R'
fi

alias ll='ls -la'
alias sbr='source ~/.bashrc'
alias vr='vi ~/.vim/init.vim'
alias vd='vi ~/.vim/dein.toml'
alias vdl='vi ~/.vim/dein_lazy.toml'
alias br='vi ~/.bashrc'
alias sd='sudo shutdown -h now'
alias ..='cd ..'
alias shttpd='service httpd.service'
alias color='perl ~/termcolor.pl'
alias ga='git add --all'
alias gc='git commit -m'
alias gs='git status'
alias gl='git log --graph'
