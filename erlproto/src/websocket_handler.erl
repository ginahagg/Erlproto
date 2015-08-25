%% cowboy websocket
-module(websocket_handler).
-author("Gina Hagg <ghagg@yahoo.com").
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {}).
-compile([{parse_transform, lager_transform}]).

init(_, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_Type, Req, _Opts) ->
    lager:info("websocket_init~n"),
    %below for console testing websocket ! msg
    %register(websocket, self()),
    {ok, Req, #state{}}.


websocket_handle({binary, Msg}, Req, State) ->
    lager:info("binary payload received:: ~p~n", [Msg]),   
    {MsgName, Bin} = protobuf_handler:decode_incoming_payload(Msg),
    Answer = (catch protobuf_handler:decode_nested_question_and_get_answer(MsgName,Bin)),   
    AnswerPayload = protobuf_handler:encode_outgoing_payload(MsgName,Answer),
    {reply, [{binary, AnswerPayload}], Req, State};


websocket_handle({text, Msg}, Req, State) ->
    lager:info("textprotocol: ~p~n", [Msg]),    
    case Msg of 
        no_more_questions -> {reply, {text, <<"goodbye_until_next_transmission">>}, Req, State};
        _->{reply, {text, <<"stop_sending_me_garbage">>}, Req, State}           
    end.
                

websocket_info(Content, Req, State) ->
    lager:info("info:message: ~p~n", [Content]),
    {ok, Req, State}.
    
handle(Req, State=#state{}) ->
    {ok, Req, State}.


terminate(_Reason, _Req, _State) ->
	ok.


