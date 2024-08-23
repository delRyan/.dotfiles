export PATH="/apollo/env/SDETools/bin:$PATH"

alias sshd='ssh ryandel.aka.corp.amazon.com'

alias bb=brazil-build
alias bbc="brazil-build clean"
alias bbt="brazil-build test"
alias bbr="brazil-build release"
alias bbs="brazil-build server"

alias ninja=ninja-dev-sync

# Runs a single unit test class.
bbst() {
         CLASS=`echo $1 | perl -pe 's/\//./gi; s/\.java$//; s/^.*\.(?=com\.)//'`
          echo "\n> Running single test for $CLASS\n"
          brazil-build single-test -DtestClass $CLASS
 }

# Increase maximum number of open files per shell.
ulimit -S -n 8192
