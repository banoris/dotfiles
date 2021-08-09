#!/bin/bash

# Use this with bash PROMPT_COMMAND or tcsh precmd's alias to set
# terminal title bar to the following format:
#    Fullpath: /proj1/dir1/super/long/path/dir
#    After   : /p/d/s/l/p/dir

OUT=""
for subpath in $(echo $PWD | tr / ' ')
do
    OUT+="/${subpath:0:1}"
done

# NOTE: concatenate two variables, with some nice tricks :)
#   ${OUT:0:-1}  --  print string from [0..n-1]
#   ${PWD##*/}   --  same like $(basename $PWD), but use builtin function
echo "${OUT:0:-1}${PWD##*/}"

