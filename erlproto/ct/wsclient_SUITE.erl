-module(wsclient_SUITE).
-author("Gina Hagg <ghagg@yahoo.com").
-include_lib("common_test/include/ct.hrl").


-export([
         all/0,
         init_per_suite/1,
         end_per_suite/1
        ]).
-export([         
         test_binary_frame_factorial_3/1     
        ]).

all() ->
    [
      test_binary_frame_factorial_3
    ].

init_per_suite(Config) ->
    ok = application:ensure_started(sasl),
    ok = application:ensure_started(asn1),
    ok = crypto:start(),
    trace(),
    ok,
    Config.

end_per_suite(Config) ->
    Config.

%%See math_calcul.erl class for message protobuf definitions.
%%we send two factorial questions in binary
%%and get two answers in binary.

%%Question 1. 
%%factorial of 3.
%%in factorial protobuf terms = {meta, factorial,{factorial,"factorial",3,0}}
%%Server response comes back in the same format but 0 replaced bythe answer. {meta, factorial,{factorial,"factorial",3,6}}

test_binary_frame_factorial_3(_) ->
    {ok, Pid} = wsclient:start_link("ws://localhost:8080/websocket",test),
    
    %%wsclient takes 3, puts into fractal message format(see math_calcul), proto_handler encodes it and encodes with meta_proto for final sendoff.
    Fac3Q = wsclient:encode_msg_for_sendoff(3),      %%sending this. <<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,3,24,0>>. 
    ct:pal(info,"Sending to server: ~p~n",[Fac3Q]),
    wsclient:send_binary(Pid, Fac3Q),
    %{binary, Msg} 
    Recvd = wsclient:fetch_last_received(),    %%should be %%<8,9,18,15,10,9,102,97,99,116,111,114,105,97,108,16,2,24,6>>. (in binary) (factorial of 3)
    Payload = process_payload_considering_async(Recvd),
    ct:pal(info,"Recieved from server: ~p~n",[Payload]),
    
    
    %%Now let's see what the server sent us. It should have the answer in the 4th element of the tuple.
    %should get {factorial,<<10,9,102,97,99,116,111,114,105,97,108,16,3,24,6>>}
    {MsgName, Bin} = wsclient:decode_payload(Payload),   %%MsgName = factorial
    ct:pal(info,"Server sent answer: ~p:~p~n",[MsgName,Bin]),
    
    Fac3A = proto_handler:decode_nested_message(MsgName,Bin),
    ct:pal(info,"after final decoding factorial of 3 should be 6 from shown in 4 element of the tuple. ~p~n",[Fac3A]),
    {factorial,"factorial",3,6} = Fac3A,
      
    %%stop now..
    wsclient:stop(Pid),
    ok.

process_payload_considering_async([]) ->
    ct:pal(info,"should be empty~n"), 
    AskAgainSinceAsync = wsclient:fetch_last_received(),
    process_payload_considering_async(AskAgainSinceAsync);

process_payload_considering_async(Recvd) -> 
    ct:pal(info,"first payload: ~p~n",[Recvd]),  
    [{payload,Bin1}] = Recvd,
    Bin1.
    
%ct:pal(error, "Error ~p detected! Info: ~p", [SomeFault,ErrorInfo]),

trace() ->
    ok.
%    , dbg:tracer()
%    , dbg:p(all, c)
%    , dbg:tpl(${TM_FILEPATH/^.*\/(.*)_SUITE\.erl$/$1/g}, x).


