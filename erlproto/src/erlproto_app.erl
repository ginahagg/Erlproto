
-module(erlproto_app).
-author("Gina Hagg <ghagg@yahoo.com").
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


    Paths = [
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

-ifdef(TEST).

simple_test() ->
    ok = application:start(myapp),
    ?assertNot(undefined == whereis(myapp_sup)).

-endif.
