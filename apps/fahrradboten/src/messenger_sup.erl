-module(messenger_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, new_worker/1]).

%% Supervisor callbacks
-export([init/1]).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

new_worker(Messanger) ->
	supervisor:start_child(?MODULE, [Messanger]).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

init([]) ->
    {ok, {{simple_one_for_one, 100, 1}, [
        {dispatch_messenger, {dispatch_messenger, start_link, []},
            temporary, 5000, worker, dynamic}
    ]}}.

