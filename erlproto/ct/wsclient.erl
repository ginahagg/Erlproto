-module(wsclient).

-behaviour(websocket_client_handler).

-export([
         start_link/0,
         start_link/1,
         start_link/2,
         send_text/2,
         send_binary/2,
         send_ping/2,
         recv/2,
         recv/1,
         stop/1,
         encode_msg_for_sendoff/1,
         decode_payload/1,
         handle_binary/1,
         fetch_last_received/0,
         cleanup_store/0
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
-define(NumOfMsgsToBeTransmitted,1).

-define(WEBSOCKET_SERVER_URL, "ws://localhost:8080/websocket").

-compile([{parse_transform, lager_transform}]).

%%start communication by sending this factorial question below. Server will parse and send us an answer.
%%factorial of 2 = {meta,factorial,{factorial,2,0}    
-define(Start,<<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,4,24,0>>).

start_link() ->
    start_link(?WEBSOCKET_SERVER_URL).

start_link(Url) ->
    application:start(sasl),
    lager:start(),
    {ok,Pid} = websocket_client:start_link(Url, ?MODULE, []),
    send_binary(Pid,?Start),
    {ok, Pid}.

%%for common_test don't send the first package.
start_link(Url,test) ->
    {ok,_Pid} = websocket_client:start_link(Url, ?MODULE, []).
    

stop(Pid) ->
    Pid ! stop.

send_text(Pid, Msg) ->
    websocket_client:cast(Pid, {text, Msg}).

send_binary(Pid, Msg) ->
    lager:info("Sending binary msg: ~p~n",[Msg]),
    websocket_client:cast(Pid, {binary, Msg}).

send_ping(Pid, Msg) ->
    websocket_client:cast(Pid, {ping, Msg}).

recv(Pid) ->
    recv(Pid, 5000).

recv(Pid, Timeout) ->
    Pid ! {recv, self()},
    receive
        M -> lager:info("receive:M is ~p~n",[M]), 
        M
    after
        Timeout -> error
    end.

init(_, _WSReq) ->
    {ok, #state{}}.

%%if we reached the NumOfMsgsToBeTransmitted, we will stop. For testing, this is 1. One message and stop.
stop_if_lastone(no_more_questions) ->
    send_text(self(),<<"no_more_questions">>),
    {close, <<"Finished transmitting. Closing Shop">>, []};

stop_if_lastone(Resp) ->
    lager:info("after sleeping for a second, sending binary:~p to selfpid ~p ~n",[Resp, self()]), 
    timer:sleep(1000),     
    send_binary(self(), Resp).

websocket_handle(Frame, _, State = #state{waiting = undefined, buffer = Buffer}) ->
    lager:info("1.Client received frame ~p ~n",[Frame]),
    BufferLength = length(Buffer),
    lager:info("We have ~p items in buffer.",[BufferLength]),
    %store_payload(Frame),
    send_binary_frame(Frame, BufferLength),
    {ok, State#state{buffer = [Frame|Buffer]}};

websocket_handle(_Frame, _, State = #state{waiting = _From}) ->  
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Helper functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

send_binary_frame({binary,Bin}, BufferLength) when BufferLength < ?NumOfMsgsToBeTransmitted -> 
    store_payload(Bin),
    Resp = handle_binary(Bin),
    stop_if_lastone(Resp);
 
send_binary_frame({binary,_},_BufferLength) ->
    stop_if_lastone(no_more_questions);   

send_binary_frame({text,_}, _) ->
    lager:info("server responded with stop_sending_me_garbage. we are done folks, we closed shop!!"),
    not_handling_text.

decode_payload(Msg) ->
    {meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
    lager:info("~p answer binary: ~p~n", [MsgName,Bin]),
    {MsgName, Bin}.

handle_binary(Msg)->
    lager:info("recvd binary: ~p~n", [Msg]),
    {meta, MsgName, Bin} = meta_proto:decode_msg(Msg,meta),
    lager:info("~p answer binary: ~p~n", [MsgName,Bin]),
    NextQuestion = (catch proto_handler:handle_msg(MsgName,Bin)),
    lager:info("~p:NextQuestion: ~p~n", [MsgName,NextQuestion]),
    Send = case NextQuestion of 
        no_more_questions -> no_more_questions;
        _-> meta_proto:encode_msg({meta,MsgName,NextQuestion})
    end,
    lager:info("~p:Send: ~p~n", [MsgName,Send]), 
    Send.

encode_msg_for_sendoff(Number) ->
    proto_handler:encodeFactorialMessage(Number).  

store_payload(Bin) ->
    {ok,Ref} = dets:open_file(?MODULE,[]),  
    dets:insert(Ref,{payload,Bin}),
    dets:close(Ref).

cleanup_store() ->
    {ok,Ref} = dets:open_file(?MODULE,[]), 
    dets:delete_all_objects(Ref),
    dets:close(Ref).
 
fetch_last_received() ->
    {ok,Ref} = dets:open_file(?MODULE,[]),  
    Payload = dets:lookup(Ref,payload),
    dets:close(Ref),
    Payload.
    