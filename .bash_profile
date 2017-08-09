# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

PATH=$HOME/heroku/bin:$PATH
PATH=$PATH:$HOME/.composer/vendor/bin

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/local/bin:$PATH:/usr/local/sbin"
export TERM=xterm-color
