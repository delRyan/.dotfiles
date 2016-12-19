# --Exports--
export PATH="/apollo/env/SDETools/bin:$PATH"

# --Functions--
 # Runs a single unit test class.
 bbst() {
         CLASS=`echo $1 | perl -pe 's/\//./gi; s/\.java$//; s/^.*\.(?=com\.)//'`
          echo "\n> Running single test for $CLASS\n"
          brazil-build single-test -DtestClass $CLASS
 }
