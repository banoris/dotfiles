-module(myprompt).

-export([node_a_prompt/1]).

% See https://www.erlang.org/doc/man/shell.html#prompt_func-1
node_a_prompt([{history, N}]) ->
    io_lib:format("node_a:~s> ", [integer_to_list(N)]).
