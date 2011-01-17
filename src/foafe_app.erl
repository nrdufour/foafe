%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the foafe application.

-module(foafe_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for foafe.
start(_Type, _StartArgs) ->
    foafe_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for foafe.
stop(_State) ->
    ok.
