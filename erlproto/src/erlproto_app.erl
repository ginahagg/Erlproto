
-module(erlproto_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

-define(ANY_HOST, '_').
-define(NO_OPTIONS, []).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%orig
%start(_Type, _Args) ->
	%erlproto_sup:start_link().

%cowboy
start(_Type, _Args) ->
    % Bindings can be per host or per path
    %
    % HostWithConstraints = {Host, ConstraintExamples, Paths},
    % PathWithConstraints = {Path, ConstraintExamples, Handler, Bindings},
    %
    % Can also compile and update routes on the fly:
    %    cowboy:set_env(my_http_listener, dispatch, cowboy_router:compile(Dispatch)).

    % constraint function arguments are BINARY!
    Constraints = [{an_int, int},
                   {three_chars, function, fun three_chars/1},
                   {add_one, function, fun add_one/1}%,
                   %{non_empty, nonempty}, %% not_implemented in this version
                  ],

    Paths = [{"/hello", hello_handler, ?NO_OPTIONS = []},
             {"/constraints/:anything", constraints_handler, {constraints_met, true}},
             {"/constraints/:an_int/:three_chars/[:add_one]", Constraints, constraints_handler, {constraints_met, true}},
             {"/constraints/[...]", constraints_handler, {constraints_met, false}},
             {"/websocket", websocket_handler, ?NO_OPTIONS},
             {"/[...]", cowboy_static, {priv_dir, erlproto, "static"}}
             ],

    Routes = [{?ANY_HOST, Paths},
              {"[...]", [{"/hpi/[...]", host_path_info_handler, ?NO_OPTIONS}]}],
    %[...] in the host spec must be in a string
    %[...] in the path spec must follow a slash

    Dispatch = cowboy_router:compile(Routes),
    _ = cowboy:start_http(my_http_listener, 100, [{port, 8080}], [{env, [{dispatch, Dispatch}]}]),
    erlproto_sup:start_link().

stop(_State) ->
	ok.

three_chars(<<X:8, Y:8, Z:8>> = Chars) ->
    io:format(standard_error, "three_chars(~p) pass~n", [[X, Y, Z]]),
    AllChars = lists:all(fun is_char/1, binary_to_list(Chars)),
    io:format(standard_error, "All chars? ~p~n", [AllChars]),
    AllChars;
three_chars(Other) ->
    io:format(standard_error, "three_chars(~p) fail~n", [Other]),
    false.

is_char(X) when is_integer(X), X >= 32, X =< 126 ->
    true;
is_char(_) ->
    false.

add_one(<<X:8>>) when is_integer(X) ->
    io:format(standard_error, "add_one(~p) pass~n", [X]),
    {true, list_to_integer([X]) + 1};
add_one(Other) ->
    io:format(standard_error, "add_one(~p) fail~n", [Other]),
    false.

-ifdef(TEST).

simple_test() ->
    ok = application:start(myapp),
    ?assertNot(undefined == whereis(myapp_sup)).

-endif.
