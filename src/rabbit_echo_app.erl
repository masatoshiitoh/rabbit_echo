-module(rabbit_echo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).
-export([fmt/1]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    rabbit_echo_sup:start_link().

stop(_State) ->
    ok.

fmt(A) ->
    io_lib:format("Hello, ~s", [A]).

%% https://github.com/rebar/rebar/wiki/Getting-started

-ifdef(TEST).

simple_test() ->
    ok = application:start(rabbit_echo),
    ?assertNot(undefined == whereis(rabbit_echo_sup)).

utilfunc_test() ->
    ?assertNot("Hello, world" == fmt("world")).

-endif.
