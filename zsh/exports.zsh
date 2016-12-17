# Currently this path is appended to dynamically when picking a ruby version
# zshenv has already started PATH with rbenv so append only here
#export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin
export PATH=$PATH:/usr/local/sbin:$HOME/bin:/usr/local/go/bin
export PATH=$PATH:${JAVA_HOME}/bin
export JAVA_HOME=`/usr/libexec/java_home`
# remove duplicate entries
typeset -U PATH


# Setup terminal, and turn on colors
#export TERM=xterm-256color
export TERM=screen-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
