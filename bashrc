alias ll='ls -lh --color=auto' # --time-style=long-iso'
ulimit -c unlimited

alias tree="tree -C"
alias scons='scons -j32'
alias g++='g++ -std=c++11'
alias g--='g++'

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
export TERM=xterm

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PS1="\[\e[36m\][\u@`hostname -i`\[\e[m\]:\`pwd\`]$"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto '
  alias fgrep='fgrep --color=auto -n'
  alias egrep='egrep --color=auto -n'
fi

cd "/home/admin/project"
alias cd...='cd ../../'
alias cd....='cd ../../../'

HISTSIZE=2000
