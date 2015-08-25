-module(erlproto_sup).
-author("Gina Hagg <ghagg@yahoo.com").
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    lager:start(),
	{ok, {{one_for_one, 1, 5}, []}}.
