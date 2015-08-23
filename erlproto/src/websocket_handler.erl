%% cowboy websocket
-module(websocket_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {}).
-define(Start,<<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,2,24,2>>).

init(_, _Req, _Opts) ->
    {upgrade, protocol, cowboy_websocket}.

websocket_init(_Type, Req, _Opts) ->
    lager:info("websocket_init~n"),
    %below for console testing websocket ! msg
    %register(websocket, self()),
    {ok, Req, #state{}}.


websocket_handle({binary, Msg}, Req, State) ->
    io:format("binaryprotocol: sendback:~p~n", [Msg]),   
    {meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
    io:format("~p question: {~p}~n", [MsgName,Msg]),
    Recvd = (catch protobuf_handler:handle_msg(MsgName,Bin)), 
    io:format("recvd: ~p~n", [Recvd]),  
    Resp = meta_proto:encode_msg({meta,MsgName,Recvd}),
    io:format("answer: ~p~n", [Resp]),
    {reply, [{binary, Resp}], Req, State};

websocket_handle({text, Msg}, Req, State) ->
    io:format("textprotocol: ~p~n", [Msg]),    
    case Msg of 
        no_more_questions -> {reply, {text, <<"goodbye_until_next_transmission">>}, Req, State};
        <<"connect">> ->
            {meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
            lager:info("~p question: {~p}~n", [MsgName,Msg]),
            Recvd = (catch protobuf_handler:handle_msg(MsgName,Bin)), 
            lager:info("recvd: ~p~n", [Recvd]),  
            Resp = meta_proto:encode_msg({meta,MsgName,Recvd}),
            lager:info("answer: ~p~n", [Resp]),
            {reply, [{binary, ?Start}], Req, State};
        _->{reply, {text, <<"stop_sending_me_garbage">>}, Req, State}           
    end.
                

websocket_info(Content, Req, State) ->
    lager:info("info:message: ~p~n", [Content]),
    {ok, Req, State}.

websocket_terminate(Reason, Req, State) -> 
    lager:info("terminate: Reason: ~p~n",[Reason]),
    ok.
    
handle(Req, State=#state{}) ->
    {ok, Req, State}.


terminate(_Reason, _Req, _State) ->
	ok.


