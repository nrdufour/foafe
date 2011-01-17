%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc foafe startup code

-module(foafe).
-author('author <author@example.com>').
-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
	ok ->
	    ok;
	{error, {already_started, App}} ->
	    ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    ensure_started(couchbeam),
    foafe_sup:start_link().

%% @spec start() -> ok
%% @doc Start the foafe server.
start() ->
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    ensure_started(couchbeam),
    application:start(foafe).

%% @spec stop() -> ok
%% @doc Stop the foafe server.
stop() ->
    Res = application:stop(foafe),
    application:stop(couchbeam),
    application:stop(webmachine),
    application:stop(mochiweb),
    application:stop(crypto),
    Res.
