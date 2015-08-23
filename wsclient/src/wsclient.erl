-module(ws_client1).

-behaviour(websocket_client_handler).

-export([
         start_link/0,
         start_link/1,
         send_text/2,
         send_binary/2,
         send_ping/2,
         recv/2,
         recv/1,
         stop/1
        ]).

-export([
         init/2,
         websocket_handle/3,
         websocket_info/3,
         websocket_terminate/3
        ]).
 
-record(state, {
          buffer = [] :: list(),
          waiting = undefined :: undefined | pid()
         }).

%start communication by sending this factorial question below. Server will parse and send us an answer.
%factorial of 2 = {meta,factorial,{factorial,2,0}    
-define(Start,<<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,2,24,2>>).

start_link() ->
    start_link("ws://localhost:8080/websocket").

start_link(Url) ->
    application:start(sasl),
    application:start(gproc),
    {ok,Pid} = websocket_client:start_link(Url, ?MODULE, []),
    send_binary(Pid,?Start),
    {ok, Pid}.
    

stop(Pid) ->
    Pid ! stop.

send_text(Pid, Msg) ->
    websocket_client:cast(Pid, {text, Msg}).

send_binary(Pid, Msg) ->
    websocket_client:cast(Pid, {binary, Msg}).

send_ping(Pid, Msg) ->
    websocket_client:cast(Pid, {ping, Msg}).

recv(Pid) ->
    recv(Pid, 5000).

recv(Pid, Timeout) ->
    Pid ! {recv, self()},
    receive
        M -> M
    after
        Timeout -> error
    end.

init(_, _WSReq) ->
    {ok, #state{}}.

stop_if_num_is_50(no_more_questions) ->
    send_text(self(),<<"no_more_questions">>),
    {close, <<"50 questions/answers transmitted. Closing Shop">>, []};

stop_if_num_is_50(Resp) ->
    io:format("sending binary:~p to selfpid ~p ~n",[Resp, self()]), 
    timer:sleep(1000),     
    send_binary(self(), Resp).

                
send_binary_frame({binary,Bin})->   
    Resp = handle_binary(Bin),
    stop_if_num_is_50(Resp);
    

send_binary_frame(_) ->
    not_handling_text.
 

websocket_handle(Frame, _, State = #state{waiting = undefined, buffer = Buffer}) ->
    io:format("1.Client received frame ~p ~n",[Frame]),
    send_binary_frame(Frame),  
    {ok, State#state{buffer = [Frame|Buffer]}};


websocket_handle(Frame, _, State = #state{waiting = _From}) ->
     send_binary_frame(Frame),   
     {ok, State#state{waiting = undefined}}.

websocket_info({send_text, Text}, WSReq, State) ->
    websocket_client:send({text, Text}, WSReq),
    {ok, State};
websocket_info({recv, From}, _, State = #state{buffer = []}) ->
    {ok, State#state{waiting = From}};
websocket_info({recv, From}, _, State = #state{buffer = [Top|Rest]}) ->
    From ! Top,
    {ok, State#state{buffer = Rest}};
websocket_info(stop, _, State) ->
    {close, <<>>, State}.

websocket_terminate(Close, Reason, State) ->
    io:format("Websocket closed with frame ~p and reason ~p and state ~p", [Close, Reason,State]),
    ok.

handle_binary(Msg)->
    io:format("recvd binary:will send back ~p~n", [Msg]),
    {meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
    io:format("~p answer binary: ~p~n", [MsgName,Bin]),
    NextQuestion = (catch proto_handler:handle_msg(MsgName,Bin)),
    io:format("~p:NextQuestion: ~p~n", [MsgName,NextQuestion]),
    Send = case NextQuestion of 
        no_more_questions -> no_more_questions;
        _-> meta_proto:encode_msg({meta,MsgName,NextQuestion})
    end,
    io:format("~p:Send: ~p~n", [MsgName,Send]), 
    Send.
