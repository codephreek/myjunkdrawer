# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function antlr4 {
    java -jar /c/JavaDir/antlr-4.2-complete.jar "$@"
}
function grun {
    java org.antlr.v4.runtime.misc.TestRig "$@"
}
export -f grun
export -f antlr4
